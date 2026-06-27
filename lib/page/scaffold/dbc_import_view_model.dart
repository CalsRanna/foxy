import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/database/database.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:signals/signals.dart';
import 'package:warcrafty/warcrafty.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class DbcImportViewModel {
  final dbcImported = signal(false);
  final dbcPath = signal<String?>(null);
  final dbcImportError = signal<String?>(null);
  final dbcImporting = signal(false);
  final dbcProgress = signal<double?>(null);
  final dbcProgressLabel = signal('');
  final dbcProgressDetail = signal('');

  static const requiredDbcTableNames = [
    'dbc_achievement',
    'dbc_area_table',
    'dbc_char_titles',
    'dbc_creature_display_info',
    'dbc_creature_model_data',
    'dbc_creature_spell_data',
    'dbc_currency_types',
    'dbc_emotes_text',
    'dbc_faction',
    'dbc_gem_properties',
    'dbc_glyph_properties',
    'dbc_item_display_info',
    'dbc_item_extended_cost',
    'dbc_item_random_properties',
    'dbc_item_random_suffix',
    'dbc_item_set',
    'dbc_lock',
    'dbc_map',
    'dbc_quest_faction_reward',
    'dbc_quest_info',
    'dbc_quest_sort',
    'dbc_scaling_stat_distribution',
    'dbc_scaling_stat_values',
    'dbc_spell',
    'dbc_spell_duration',
    'dbc_spell_icon',
    'dbc_spell_item_enchantment',
    'dbc_spell_range',
    'dbc_talent',
    'dbc_vehicle',
  ];

  // ========== 入口 ==========

  Future<void> checkAndImport() async {
    try {
      if (dbcImported.value) return;
      final missing = await _checkRequiredTablesExist();
      if (missing.isEmpty) {
        dbcImported.value = true;
        return;
      }
      final config = await _loadConfig();
      final path = config['dbc_path'] as String?;
      if (path != null && path.isNotEmpty) dbcPath.value = path;
    } catch (e) {
      LoggerUtil.instance.e('检查DBC导入状态失败: $e');
      DialogUtil.instance.error('检查DBC导入状态失败: $e');
    }
  }

  void startImport() {
    if (dbcPath.value == null || dbcImporting.value) return;
    _startImportWorker();
  }

  Future<void> setDbcPath(String path) async {
    try {
      dbcPath.value = path;
      dbcImportError.value = null;
      await _updateConfig('dbc_path', path);
      _startImportWorker();
    } catch (e) {
      LoggerUtil.instance.e('设置DBC路径失败: $e');
      DialogUtil.instance.error('设置DBC路径失败: $e');
    }
  }

  Future<void> retryImport() async {
    try {
      dbcImportError.value = null;
      _startImportWorker();
    } catch (e) {
      LoggerUtil.instance.e('重试DBC导入失败: $e');
      DialogUtil.instance.error('重试DBC导入失败: $e');
    }
  }

  // ========== 导入引擎 ==========

  void _startImportWorker() {
    dbcImporting.value = true;
    dbcProgress.value = null;
    dbcProgressLabel.value = '准备导入...';
    dbcProgressDetail.value = '';
    dbcImportError.value = null;
    _runInWorker().catchError((_) {});
  }

  Future<void> _runInWorker() async {
    try {
      // 1. 扫描目录
      final registry = _buildSchemaRegistry();
      final dir = Directory(dbcPath.value!);
      final fileDefs = <_FileDef>[];

      for (final entry in dir.listSync()) {
        if (entry is! File) continue;
        final nameWithExt = p.basename(entry.path);
        if (!nameWithExt.endsWith('.dbc')) continue;
        final name = nameWithExt.substring(0, nameWithExt.length - 4);
        final schema = registry[name];
        if (schema == null) continue;

        final tableName = 'foxy.dbc_${_toSnakeCase(schema.name)}';
        if (!requiredDbcTableNames.contains(tableName.substring(5))) continue;

        fileDefs.add((
          name: name,
          tableName: tableName,
          format: schema.format,
          fields: [
            for (final f in schema.fields)
              if (!f.type.isSkip)
                (
                  index: f.index,
                  name: f.name,
                  type: f.type.name,
                  sqlType: _sqlTypeFromString(f.type.name),
                ),
          ],
        ));
      }

      if (fileDefs.isEmpty) {
        dbcImporting.value = false;
        dbcImportError.value = '未在目录中找到需要的 DBC 文件。\n目录：${dbcPath.value}';
        return;
      }

      fileDefs.sort((a, b) => a.name.compareTo(b.name));

      // 2. 读取 MySQL 配置
      final config = await _loadConfig();

      // 3. 启动 worker isolate
      final receivePort = ReceivePort();
      await Isolate.spawn(
        _importWorker,
        (
          sendPort: receivePort.sendPort,
          dbcPath: dbcPath.value!,
          host: config['host'] as String? ?? '127.0.0.1',
          port: int.tryParse(config['port'] as String? ?? '3306') ?? 3306,
          database: config['database'] as String? ?? 'acore_world',
          username: config['username'] as String? ?? 'acore',
          password: config['password'] as String? ?? 'acore',
          files: fileDefs,
        ),
      );

      var completed = 0;
      final total = fileDefs.length;

      await for (final msg in receivePort) {
        switch (msg) {
          case (String status, int d, int t):
            completed = d;
            dbcProgress.value = t > 0 ? d / t : null;
            dbcProgressLabel.value = status;
            dbcProgressDetail.value = '已处理 $d / $t 个文件';
          case (bool success, int imported, int skipped, List errs):
            receivePort.close();
            dbcImporting.value = false;
            dbcProgress.value = null;
            dbcProgressLabel.value = '';
            dbcProgressDetail.value = '';
            if (success) {
              LoggerUtil.instance.i(
                'DBC 导入完成: $imported 个, 跳过 $skipped 个',
              );
              dbcImported.value = true;
            } else {
              final top = (errs as List<String>).take(3).join('\n');
              dbcImportError.value =
                  '导入完成，部分文件失败：\n$top'
                  '${errs.length > 3 ? '\n...等 ${errs.length} 个错误' : ''}';
            }
          default:
            break;
        }
      }

      receivePort.close();
    } catch (e) {
      dbcImporting.value = false;
      dbcProgress.value = null;
      dbcImportError.value = '导入出错：$e';
      LoggerUtil.instance.e('DBC 导入异常: $e');
    }
  }

  // ========== 检查已有表 ==========

  Future<List<String>> _checkRequiredTablesExist() async {
    try {
      final laconic = Database.instance.laconic;
      final results = await laconic.select(
        "SELECT TABLE_NAME FROM information_schema.TABLES "
        "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME LIKE 'dbc_%' AND TABLE_ROWS > 0",
      );
      final existing = results.map((r) => r['TABLE_NAME'] as String).toSet();
      return requiredDbcTableNames
          .where((t) => !existing.contains(t))
          .toList();
    } catch (e) {
      LoggerUtil.instance.w('查询 DBC 表状态失败: $e');
      return requiredDbcTableNames.toList();
    }
  }

  // ========== 配置持久化 ==========

  Future<Map<String, dynamic>> _loadConfig() async {
    final file = File(_configPath);
    if (!await file.exists()) return {};
    final content = await file.readAsString();
    if (content.isEmpty) return {};
    return Map<String, dynamic>.from(loadYaml(content));
  }

  Future<void> _updateConfig(String key, String value) async {
    final file = File(_configPath);
    if (!await file.exists()) await file.create(recursive: true);
    final content = await file.readAsString();
    Map<String, dynamic> existingConfig = {};
    if (content.isNotEmpty) {
      existingConfig = Map<String, dynamic>.from(loadYaml(content));
    }
    existingConfig[key] = value;
    final editor = YamlEditor('');
    editor.update([], existingConfig);
    await file.writeAsString(editor.toString());
  }

  String get _configPath => p.join(Directory.current.path, 'config.yaml');
}

// ========== 类型定义 ==========

typedef _FieldDef = ({int index, String name, String type, String sqlType});

typedef _FileDef = ({
  String name,
  String tableName,
  String format,
  List<_FieldDef> fields,
});

typedef _WorkerArgs = ({
  SendPort sendPort,
  String dbcPath,
  String host,
  int port,
  String database,
  String username,
  String password,
  List<_FileDef> files,
});

// ========== Schema 注册表 ==========

Map<String, DbcSchema> _buildSchemaRegistry() {
  final schemas = [
    Definitions.achievement,
    Definitions.achievementCategory,
    Definitions.achievementCriteria,
    Definitions.areaTable,
    Definitions.charTitles,
    Definitions.creatureDisplayInfo,
    Definitions.creatureModelData,
    Definitions.creatureSpellData,
    Definitions.currencyTypes,
    Definitions.emotesText,
    Definitions.faction,
    Definitions.gemProperties,
    Definitions.glyphProperties,
    Definitions.itemDisplayInfo,
    Definitions.itemExtendedCost,
    Definitions.itemRandomProperties,
    Definitions.itemRandomSuffix,
    Definitions.itemSet,
    Definitions.lock,
    Definitions.map,
    Definitions.questFactionReward,
    Definitions.questInfo,
    Definitions.questSort,
    Definitions.scalingStatDistribution,
    Definitions.scalingStatValues,
    Definitions.spell,
    Definitions.spellDuration,
    Definitions.spellIcon,
    Definitions.spellItemEnchantment,
    Definitions.spellRange,
    Definitions.talent,
    Definitions.vehicle,
  ];
  return {for (final s in schemas) s.name: s};
}

// ========== Worker Isolate ==========

Future<void> _importWorker(_WorkerArgs args) async {
  final (
    :sendPort,
    :dbcPath,
    :host,
    :port,
    :database,
    :username,
    :password,
    :files,
  ) = args;

  Laconic? laconic;
  try {
    laconic = Laconic(
      MysqlDriver(
        MysqlConfig(
          host: host,
          port: port,
          database: database,
          username: username,
          password: password,
        ),
      ),
    );

    var imported = 0;
    var skipped = 0;
    final errors = <String>[];
    final total = files.length;

    for (var i = 0; i < files.length; i++) {
      final file = files[i];
      try {
        // 跳过已有数据的表
        int count;
        try {
          count = await laconic.table(file.tableName).count();
        } on LaconicException {
          count = 0;
        }
        if (count > 0) {
          skipped++;
          sendPort.send((file.name, imported + skipped + errors.length, total));
          continue;
        }

        // 建表
        await _createTable(laconic, file);

        // 读 DBC + 分批写入
        final dbcPath_ = p.join(dbcPath, '${file.name}.dbc');
        final rowCount = await _importFile(laconic, dbcPath_, file);
        if (rowCount > 0) {
          imported++;
        } else {
          skipped++;
        }
      } catch (e) {
        errors.add('${file.name}: $e');
      }

      sendPort.send((file.name, imported + skipped + errors.length, total));
    }

    sendPort.send((errors.isEmpty, imported, skipped, errors));
  } catch (e) {
    sendPort.send((false, 0, 0, ['Worker 错误: $e']));
  } finally {
    await laconic?.close();
  }
}

Future<void> _createTable(Laconic laconic, _FileDef file) async {
  final cols =
      file.fields.map((f) => '`${f.name}` ${f.sqlType}').join(',\n  ');
  if (cols.isEmpty) return;

  await laconic.statement('DROP TABLE IF EXISTS ${file.tableName}');
  await laconic.statement(
    'CREATE TABLE ${file.tableName} (\n  $cols\n) '
    'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4',
  );
}

Future<int> _importFile(
  Laconic laconic,
  String filePath,
  _FileDef file,
) async {
  final f = File(filePath);
  if (!await f.exists()) return 0;

  final loader = DbcLoader(filePath, file.format);
  if (loader.recordCount == 0) return 0;

  const batchSize = 200;
  var batch = <Map<String, dynamic>>[];
  var total = 0;

  for (final record in loader.records) {
    final map = <String, dynamic>{};
    for (final (:index, :name, :type, :sqlType) in file.fields) {
      map[name] = switch (type) {
        'string' => record.getString(index),
        'float' => record.getFloat(index),
        'int32' || 'id' => record.getInt(index),
        'uint8' => record.getUint8(index),
        'boolean' => record.getInt(index) != 0,
        _ => null,
      };
    }
    batch.add(map);

    if (batch.length >= batchSize) {
      await _safeInsert(laconic, file.tableName, batch);
      total += batch.length;
      batch.clear();
    }
  }

  if (batch.isNotEmpty) {
    await _safeInsert(laconic, file.tableName, batch);
    total += batch.length;
  }

  return total;
}

Future<void> _safeInsert(
  Laconic laconic,
  String table,
  List<Map<String, dynamic>> records,
) async {
  if (records.isEmpty) return;
  final cols = records.first.keys.map((c) => '`$c`').join(', ');
  final row = '(${List.filled(records.first.length, '?').join(', ')})';
  final rows = List.filled(records.length, row).join(', ');
  final params = <Object?>[];
  for (final record in records) {
    params.addAll(record.values);
  }
  await laconic.statement('INSERT INTO $table ($cols) VALUES $rows', params);
}

// ========== 工具函数 ==========

String _toSnakeCase(String input) {
  if (input.isEmpty) return input;
  final buffer = StringBuffer();
  for (var i = 0; i < input.length; i++) {
    final char = input[i];
    if (char == '_' || char == ' ') {
      buffer.write(char);
    } else if (char.toUpperCase() == char) {
      if (i > 0 && input[i - 1] != '_' && input[i - 1] != ' ') {
        if (input[i - 1].toLowerCase() == input[i - 1] ||
            input[i - 1].toUpperCase() != input[i - 1]) {
          buffer.write('_');
        } else if (i + 1 < input.length &&
            input[i + 1].toLowerCase() == input[i + 1]) {
          buffer.write('_');
        }
      }
      buffer.write(char.toLowerCase());
    } else {
      buffer.write(char);
    }
  }
  return buffer.toString().replaceAll(' ', '_');
}

String _sqlTypeFromString(String type) {
  return switch (type) {
    'id' => 'INT NOT NULL',
    'int32' => 'INT',
    'uint8' => 'TINYINT UNSIGNED',
    'float' => 'FLOAT',
    'string' => 'TEXT',
    'boolean' => 'TINYINT(1)',
    _ => 'INT',
  };
}
