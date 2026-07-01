import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/database/database.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// DBC 与数据库同步所需的表名清单（导入/导出共用）。
const requiredDbcTableNames = [
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

/// 同步进度事件。导入/导出过程通过 [DbcSyncUtil.import] 的流回传。
sealed class DbcSyncProgress {}

/// 单条状态文本（如「正在扫描 DBC 目录...」）。
class DbcSyncStatus implements DbcSyncProgress {
  final String status;
  DbcSyncStatus(this.status);
}

/// 带进度计数的更新（status, 已完成, 总数）。
class DbcSyncCount implements DbcSyncProgress {
  final String status;
  final int done;
  final int total;
  DbcSyncCount(this.status, this.done, this.total);
}

/// 导入流程的最终结果。
class DbcSyncResult implements DbcSyncProgress {
  final bool success;
  final int imported;
  final int skipped;
  final List<String> errors;
  DbcSyncResult(this.success, this.imported, this.skipped, this.errors);
}

/// DBC 文件与数据库之间的双向同步工具。
///
/// 当前实现导入（DBC → MySQL）；后续将扩展导出（MySQL → DBC）。
/// 所有耗时操作在 worker isolate 内完成，通过返回的 [Stream] 报告进度，
/// 不持有任何 UI 状态，便于单测与复用。
class DbcSyncUtil {
  /// 检查 [requiredDbcTableNames] 中缺失或为空的表名。
  ///
  /// 返回需要（重新）导入的表名清单；为空表示数据已就绪。
  Future<List<String>> checkRequiredTablesExist() async {
    final laconic = Database.instance.laconic;

    // 1) 已存在的 dbc_* 表：仅判存在性，不依赖 InnoDB 估算的 TABLE_ROWS
    //    （TABLE_ROWS 对 InnoDB 只是粗略估计，可能为 NULL 或陈旧，导致误判）
    final Set<String> existing;
    try {
      final results = await laconic.select(
        "SELECT TABLE_NAME FROM information_schema.TABLES "
        "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME LIKE 'dbc_%'",
      );
      existing = results.map((r) => r['TABLE_NAME'] as String).toSet();
    } catch (e) {
      LoggerUtil.instance.w('查询 DBC 表状态失败: $e');
      return requiredDbcTableNames.toList();
    }

    // 2) 不存在的表直接计入缺失；存在的表待批量判空。
    final missing = <String>[];
    final present = <String>[];
    for (final table in requiredDbcTableNames) {
      if (existing.contains(table)) {
        present.add(table);
      } else {
        missing.add(table);
      }
    }
    if (present.isEmpty) return missing;

    // 3) 一次性批量判空：对已存在的表做 UNION ALL EXISTS，把最多 ~29 次往返
    //    压成 1 次。EXISTS 比 information_schema.TABLE_ROWS 可靠（后者对 InnoDB
    //    只是估算，可能为 NULL 或陈旧）。批量查询失败时退化为逐表探测——探测
    //    失败一律视为缺失（保守触发导入，worker 会跳过已填充的表，绝不误删数据）。
    try {
      final union = present
          .map(
            (t) =>
                "SELECT '$t' AS t, "
                "EXISTS(SELECT 1 FROM foxy.$t) AS has_rows",
          )
          .join(' UNION ALL ');
      final rows = await laconic.select(union);
      final nonEmpty = <String>{
        for (final r in rows)
          if (_truthy(r['has_rows'])) r['t'] as String,
      };
      for (final table in present) {
        if (!nonEmpty.contains(table)) missing.add(table);
      }
    } catch (e) {
      LoggerUtil.instance.w('批量检查 DBC 表是否为空失败，退化为逐表探测: $e');
      missing.addAll(await _probeTablesIndividually(present));
    }
    return missing;
  }

  /// 逐表探测非空（批量查询失败时的兜底路径）。探测失败的表按缺失处理。
  Future<List<String>> _probeTablesIndividually(List<String> tables) async {
    final laconic = Database.instance.laconic;
    final missing = <String>[];
    for (final table in tables) {
      try {
        final rows = await laconic.select('SELECT 1 FROM foxy.$table LIMIT 1');
        if (rows.isEmpty) missing.add(table);
      } catch (e) {
        LoggerUtil.instance.w('检查表 $table 是否为空失败: $e');
        missing.add(table);
      }
    }
    return missing;
  }

  /// EXISTS 经 typedAssoc 通常回传 int 1/0；容忍 bool/String 形态以防驱动差异。
  static bool _truthy(Object? v) => v == 1 || v == true || v == '1';

  /// 从 config.yaml 读取配置。
  Future<Map<String, dynamic>> loadConfig() async {
    final file = File(_configPath);
    if (!await file.exists()) return {};
    final content = await file.readAsString();
    if (content.isEmpty) return {};
    return Map<String, dynamic>.from(loadYaml(content));
  }

  /// 更新 config.yaml 中某个键。
  Future<void> updateConfig(String key, String value) async {
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

  /// 启动导入：在 worker isolate 内扫描目录并批量写入数据库。
  ///
  /// 返回进度事件流：先发若干 [DbcSyncStatus]/[DbcSyncCount]，
  /// 最后发一个 [DbcSyncResult] 后关闭。调用方应在流结束后清理状态。
  Stream<DbcSyncProgress> import({
    required String dbcPath,
    required String host,
    required int port,
    required String database,
    required String username,
    required String password,
  }) {
    final controller = StreamController<DbcSyncProgress>();
    final receivePort = ReceivePort();

    () async {
      try {
        await Isolate.spawn(_importWorker, (
          sendPort: receivePort.sendPort,
          dbcPath: dbcPath,
          host: host,
          port: port,
          database: database,
          username: username,
          password: password,
        ));

        await for (final msg in receivePort) {
          switch (msg) {
            case (String status,):
              controller.add(DbcSyncStatus(status));
            case (String status, int d, int t):
              controller.add(DbcSyncCount(status, d, t));
            case (bool success, int imported, int skipped, List errs):
              controller.add(
                DbcSyncResult(success, imported, skipped, errs.cast<String>()),
              );
              break;
            default:
              break;
          }
        }
        receivePort.close();
        await controller.close();
      } catch (e) {
        LoggerUtil.instance.e('DBC 导入异常: $e');
        controller.add(DbcSyncResult(false, 0, 0, ['导入出错：$e']));
        await controller.close();
      }
    }();

    return controller.stream;
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
});

// ========== Schema 注册表 ==========

Map<String, DbcSchema> _buildSchemaRegistry() {
  final schemas = [
    Definitions.achievement,
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
  final (:sendPort, :dbcPath, :host, :port, :database, :username, :password) =
      args;

  // ====== 阶段 0：扫描目录（在 isolate 内完成，不阻塞主线程）======
  sendPort.send(('正在扫描 DBC 目录...',));
  final registry = _buildSchemaRegistry();
  final dir = Directory(dbcPath);
  final fileDefs = <_FileDef>[];

  if (!await dir.exists()) {
    sendPort.send((false, 0, 0, ['目录不存在: $dbcPath']));
    return;
  }

  await for (final entry in dir.list()) {
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
    sendPort.send((false, 0, 0, ['未在目录中找到需要的 DBC 文件。\n目录：$dbcPath']));
    return;
  }

  fileDefs.sort((a, b) => a.name.compareTo(b.name));
  final total = fileDefs.length;
  sendPort.send(('找到 $total 个匹配文件，准备导入...', 0, total));

  // ====== 阶段 1：连接数据库 ======
  var laconic = Laconic(
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
  try {
    // 一次性查已存在的 dbc_* 表（仅判存在性），避免对不存在的表逐个 count
    // 触发 ~30 次异常重连（首次导入时所有表都不存在）
    final existingTables = <String>{};
    try {
      final existRows = await laconic.select(
        "SELECT TABLE_NAME FROM information_schema.TABLES "
        "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME LIKE 'dbc_%'",
      );
      for (final r in existRows) {
        existingTables.add(r['TABLE_NAME'] as String);
      }
    } catch (_) {
      // 查询失败不致命：退化为"逐表探测"，下面按不存在处理
    }

    var imported = 0;
    var skipped = 0;
    final errors = <String>[];

    for (var i = 0; i < fileDefs.length; i++) {
      final file = fileDefs[i];
      sendPort.send(('正在处理 ${file.name}...',));
      try {
        final tableShort = file.tableName.substring(5); // 去掉 'foxy.'
        final exists = existingTables.contains(tableShort);

        if (exists) {
          // 表已存在：仅当确认无数据时才重建导入。
          // count 失败一律跳过——绝不把"超时/连接故障"误判为空表后 DROP，
          // 否则会清掉已有数据（含用户编辑）。
          int count;
          try {
            count = await laconic
                .table(file.tableName)
                .count()
                .timeout(const Duration(seconds: 10));
          } on Exception catch (_) {
            await laconic.close();
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
            errors.add('${file.name}: 检查表行数失败，已跳过以防数据丢失');
            skipped++;
            sendPort.send((
              file.name,
              imported + skipped + errors.length,
              total,
            ));
            continue;
          }
          if (count > 0) {
            skipped++;
            sendPort.send((
              file.name,
              imported + skipped + errors.length,
              total,
            ));
            continue;
          }
          // count == 0：空表，安全重建（可能是上次导入失败留下的空壳）
        }

        // 表不存在或确认空 → 建表 + 导入
        await _createTable(laconic, file);

        // 读 DBC + 分批写入（事务包裹，单文件原子导入）
        final dbcPath_ = p.join(dbcPath, '${file.name}.dbc');
        final rowCount = await laconic.transaction(
          () => _importFile(
            laconic,
            dbcPath_,
            file,
            sendPort,
            imported + skipped + errors.length,
            total,
          ),
        );
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
    await laconic.close();
  }
}

Future<void> _createTable(Laconic laconic, _FileDef file) async {
  final cols = file.fields.map((f) => '`${f.name}` ${f.sqlType}').join(',\n  ');
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
  SendPort sendPort,
  int completedFiles,
  int totalFiles,
) async {
  final f = File(filePath);
  if (!await f.exists()) return 0;

  final loader = DbcLoader(filePath, file.format);
  final recordCount = loader.recordCount;
  if (recordCount == 0) return 0;

  // 按累计字节封顶批大小，避免拼出超过 max_allowed_packet 的巨型 INSERT。
  // 1 MiB 上限留有充足余量（旧版默认 4MB、新版 16/64MB）；buf.length 为字符数，
  // 含中文时略低于实际 UTF-8 字节数，余量已覆盖。
  const maxBatchBytes = 1 << 20;
  final cols = file.fields.map((f) => '`${f.name}`').join(', ');
  final sqlPrefix = 'INSERT INTO ${file.tableName} ($cols) VALUES ';
  var buf = StringBuffer(sqlPrefix);
  var inBatch = 0;
  var imported = 0;

  for (final record in loader.records) {
    if (inBatch > 0) buf.write(',');
    buf.write('(');
    for (var fi = 0; fi < file.fields.length; fi++) {
      if (fi > 0) buf.write(',');
      final field = file.fields[fi];
      buf.write(_readAndEscape(record, field.index, field.type, field.sqlType));
    }
    buf.write(')');
    inBatch++;

    if (buf.length >= maxBatchBytes) {
      await laconic.statement(buf.toString());
      imported += inBatch;
      sendPort.send((
        '${file.name} ($imported / $recordCount)',
        completedFiles,
        totalFiles,
      ));
      buf = StringBuffer(sqlPrefix);
      inBatch = 0;
    }
  }

  if (inBatch > 0) {
    await laconic.statement(buf.toString());
    imported += inBatch;
  }

  return imported;
}

/// 从 DBC 记录读取值并转为 SQL 字面量（内联值，无参数）
String _readAndEscape(dynamic record, int index, String type, String sqlType) {
  return switch (type) {
    'string' => _escapeString(record.getString(index) as String),
    'float' => record.getFloat(index).toString(),
    'int32' || 'id' => record.getInt(index).toString(),
    'uint8' => record.getUint8(index).toString(),
    'boolean' => record.getInt(index) != 0 ? '1' : '0',
    _ => 'NULL',
  };
}

/// MySQL 字符串字面量转义。
///
/// 为什么这里不用参数化（prepared statement）？
/// 复核 laconic_mysql 1.2.0 源码后确认：它对带 params 的语句走服务端真·预编译
/// （COM_STMT_PREPARE），且每次调用都重新 prepare、无语句缓存；又因为
/// mysql_client 的 PreparedStmt.execute 只接受单行参数，多行 INSERT 无法
/// 一次 execute。本热路径是「单条 INSERT 含数千行 VALUES」的批量插入，
/// 改用参数化会把每批 ~1 次 COM_QUERY 往返拆成「每行一次 prepare+execute+
/// close」，对 dbc_spell（5 万行）会从约 10 次往返暴涨到约 15 万次。因此
/// 保留字面多行批量路径以换取吞吐，转而在这里补全完整的 MySQL 转义集
/// 以消除残留脆弱性。数据来自本地 DBC 文件，无注入面。
///
/// 转义集对齐 mysql_real_escape_string 的必要项：NUL、\n、\r、\、'、
/// \x1a(Ctrl-Z)。固定用单引号定界，故 " 无需转义；\b/\t 裸字节在单引号
/// 串 + backslash-escapes 默认模式下合法，不转以减小批量字节数。顺序须
/// 先转反斜杠，避免后续插入的转义符被二次转义。
String _escapeString(String s) {
  if (!s.contains('\\') &&
      !s.contains("'") &&
      !s.contains('\x00') &&
      !s.contains('\n') &&
      !s.contains('\r') &&
      !s.contains('\x1a')) {
    return "'$s'";
  }
  final out = s
      .replaceAll('\\', '\\\\')
      .replaceAll("'", "\\'")
      .replaceAll('\x00', '\\0')
      .replaceAll('\n', '\\n')
      .replaceAll('\r', '\\r')
      .replaceAll('\x1a', '\\Z');
  return "'$out'";
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
            input[i + 1].toLowerCase() == input[i - 1]) {
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
    'id' => 'INT NOT NULL PRIMARY KEY',
    'int32' => 'INT',
    'uint8' => 'TINYINT UNSIGNED',
    'float' => 'FLOAT',
    'string' => 'TEXT',
    'boolean' => 'TINYINT(1)',
    _ => 'INT',
  };
}
