import 'dart:io';
import 'dart:isolate';

import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:signals/signals.dart';
import 'package:warcrafty/warcrafty.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class DbcImportViewModel {
  /// DBC 是否已就绪（导入完成、应用可用）
  final dbcImported = signal(false);

  /// DBC 文件目录路径，null 表示未配置
  final dbcPath = signal<String?>(null);

  /// 导入进度文本，空字符串表示不在导入中
  final dbcImportProgress = signal('');

  /// 错误信息，null 表示无错误
  final dbcImportError = signal<String?>(null);

  // ========== 导入流程 ==========

  Laconic? get _laconic => GetIt.instance.get<FoxyViewModel>().laconic;

  /// 从 config.yaml 加载并检查 DBC 状态
  Future<void> checkAndImport() async {
    if (dbcImported.value) return;

    final config = await _loadConfig();
    final path = config['dbc_path'] as String?;
    if (path != null && path.isNotEmpty) {
      dbcPath.value = path;
    }

    final laconic = _laconic;
    if (laconic == null) {
      dbcImportError.value = '数据库连接未就绪';
      return;
    }

    if (dbcPath.value == null) return;

    await _runImport(laconic);
  }

  /// 用户选择 DBC 路径后保存并开始导入
  Future<void> setDbcPath(String path) async {
    dbcPath.value = path;
    dbcImportError.value = null;
    await _updateConfig('dbc_path', path);

    final laconic = _laconic;
    if (laconic == null) {
      dbcImportError.value = '数据库连接未就绪';
      return;
    }

    await _runImport(laconic);
  }

  /// 重试导入
  Future<void> retryImport() async {
    dbcImportError.value = null;
    final laconic = _laconic;
    if (laconic == null) {
      dbcImportError.value = '数据库连接未就绪';
      return;
    }
    await _runImport(laconic);
  }

  Future<void> _runImport(Laconic laconic) async {
    try {
      dbcImportProgress.value = '准备导入...';
      final config = await _loadConfig();

      // 提取文件定义（DbcSchema 不可跨 isolate 传递）
      final fileDefs = <_FileDef>[];
      for (final entry in _dbcEntries) {
        final fields = <_FieldDef>[];
        for (final field in entry.schema.fields) {
          if (field.type.isSkip) continue;
          fields.add((
            index: field.index,
            name: field.name,
            type: field.type.name,
          ));
        }
        fileDefs.add((
          name: entry.fileName,
          tableName: entry.qualifiedTable,
          format: entry.schema.format,
          fields: fields,
        ));
      }

      final receivePort = ReceivePort();
      final _WorkerArgs workerArgs = (
        sendPort: receivePort.sendPort,
        dbcPath: dbcPath.value!,
        host: config['host'] as String? ?? '127.0.0.1',
        port: int.tryParse(config['port'] as String? ?? '3306') ?? 3306,
        database: config['database'] as String? ?? 'acore_world',
        username: config['username'] as String? ?? 'acore',
        password: config['password'] as String? ?? 'acore',
        files: fileDefs,
      );
      await Isolate.spawn<_WorkerArgs>(_importWorker, workerArgs);

      // 初始化日志文件头
      await _writeTimingHeader();
      await for (final msg in receivePort) {
        switch (msg) {
          case (int done, int total):
            dbcImportProgress.value = '$done / $total';
          case (String fileName, int processed):
            if (processed < 0) {
              dbcImportProgress.value = '导入中：$fileName ...';
            } else {
              dbcImportProgress.value = '导入中：$fileName ($processed 行)';
            }
          case (String fileName, String tag) when tag == 'skip' || tag == 'err':
            await _appendTimingLine(
              fileName,
              tag == 'skip' ? 'SKIP' : 'ERR',
              0,
              0,
              0,
              0,
            );
          case (
            String fileName,
            int parseUs,
            int convertUs,
            int insertUs,
            int startedAt,
          ):
            await _appendTimingLine(
              fileName,
              'OK',
              parseUs,
              convertUs,
              insertUs,
              startedAt,
            );
          case (bool success, int imported, int skipped, List errs):
            await _appendTimingSummary(imported, skipped, errs.length);
            if (success) {
              dbcImportProgress.value = '';
              dbcImported.value = true;
            } else {
              final top = errs.take(3).join('\n');
              dbcImportError.value =
                  '导入完成，但部分文件失败：\n$top'
                  '${errs.length > 3 ? '\n...等 ${errs.length} 个错误' : ''}';
              dbcImportProgress.value = '';
            }
          default:
            break;
        }
      }
    } catch (e) {
      dbcImportProgress.value = '';
      dbcImportError.value = '导入出错：$e';
    }
  }

  String get _timingLogPath =>
      p.join(Directory.current.path, 'dbc_import_timing.log');

  Future<void> _writeTimingHeader() async {
    final line =
        '${'Time'.padRight(22)} ${'File'.padRight(28)} ${'Result'.padRight(8)} ${'Parse(ms)'.padRight(10)} ${'Convert(ms)'.padRight(12)} ${'Insert(ms)'.padRight(10)} Total(ms)';
    await File(_timingLogPath).writeAsString('$line\n');
  }

  Future<void> _appendTimingLine(
    String file,
    String result,
    int parseUs,
    int convertUs,
    int insertUs,
    int startedAt,
  ) async {
    final ts = DateTime.fromMicrosecondsSinceEpoch(
      startedAt,
    ).toIso8601String().padRight(22);
    final parseMs = (parseUs ~/ 1000).toString();
    final convertMs = (convertUs ~/ 1000).toString();
    final insertMs = (insertUs ~/ 1000).toString();
    final totalMs = ((parseUs + convertUs + insertUs) ~/ 1000).toString();
    final line =
        '$ts ${file.padRight(28)} ${result.padRight(8)} ${parseMs.padRight(10)} ${convertMs.padRight(12)} ${insertMs.padRight(10)} $totalMs';
    await File(_timingLogPath).writeAsString('$line\n', mode: FileMode.append);
  }

  Future<void> _appendTimingSummary(
    int imported,
    int skipped,
    int errors,
  ) async {
    final line = '\nImported: $imported, Skipped: $skipped, Errors: $errors';
    await File(_timingLogPath).writeAsString('$line\n', mode: FileMode.append);
    logger.i('DBC import timing log: $_timingLogPath');
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

// ========== 辅助类型和函数 ==========

class _DbcFile {
  final String fileName;
  final DbcSchema schema;

  _DbcFile(this.fileName, this.schema);

  String get qualifiedTable => 'foxy.dbc_${_toSnakeCase(schema.name)}';
}

final _dbcEntries = [
  _DbcFile('Achievement', Definitions.achievement),
  _DbcFile('Achievement_Category', Definitions.achievementCategory),
  _DbcFile('AreaTable', Definitions.areaTable),
  _DbcFile('AuctionHouse', Definitions.auctionHouse),
  _DbcFile('BankBagSlotPrices', Definitions.bankBagSlotPrices),
  _DbcFile('CharBaseInfo', Definitions.charBaseInfo),
  _DbcFile('CharHairGeosets', Definitions.charHairGeosets),
  _DbcFile('CharHairTextures', Definitions.charHairTextures),
  _DbcFile('CharSections', Definitions.charSections),
  _DbcFile('CharStartOutfit', Definitions.charStartOutfit),
  _DbcFile('CharTitles', Definitions.charTitles),
  _DbcFile('ChatChannels', Definitions.chatChannels),
  _DbcFile('ChrClasses', Definitions.chrClasses),
  _DbcFile('ChrRaces', Definitions.chrRaces),
  _DbcFile('CreatureDisplayInfo', Definitions.creatureDisplayInfo),
  _DbcFile('CreatureModelData', Definitions.creatureModelData),
  _DbcFile('CurrencyTypes', Definitions.currencyTypes),
  _DbcFile('DurabilityCosts', Definitions.durabilityCosts),
  _DbcFile('DurabilityQuality', Definitions.durabilityQuality),
  _DbcFile('EmotesText', Definitions.emotesText),
  _DbcFile('Faction', Definitions.faction),
  _DbcFile('GemProperties', Definitions.gemProperties),
  _DbcFile('GlyphProperties', Definitions.glyphProperties),
  _DbcFile('ItemDisplayInfo', Definitions.itemDisplayInfo),
  _DbcFile('ItemExtendedCost', Definitions.itemExtendedCost),
  _DbcFile('ItemRandomProperties', Definitions.itemRandomProperties),
  _DbcFile('Lock', Definitions.lock),
  _DbcFile('Map', Definitions.map),
  _DbcFile('Movie', Definitions.movie),
  _DbcFile('MovieFileData', Definitions.movieFileData),
  _DbcFile('QuestFactionReward', Definitions.questFactionReward),
  _DbcFile('ScalingStatDistribution', Definitions.scalingStatDistribution),
  _DbcFile('SkillLine', Definitions.skillLine),
  _DbcFile('SkillLineAbility', Definitions.skillLineAbility),
  _DbcFile('Spell', Definitions.spell),
  _DbcFile('SpellDuration', Definitions.spellDuration),
  _DbcFile('SpellIcon', Definitions.spellIcon),
  _DbcFile('SpellItemEnchantment', Definitions.spellItemEnchantment),
  _DbcFile('SpellRadius', Definitions.spellRadius),
  _DbcFile('SpellRange', Definitions.spellRange),
  _DbcFile('Vehicle', Definitions.vehicle),
  _DbcFile('CreatureSpellData', Definitions.creatureSpellData),
  _DbcFile('ItemRandomSuffix', Definitions.itemRandomSuffix),
];

typedef _FieldDef = ({int index, String name, String type});
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
    'uint8' => 'TINYINT',
    'float' => 'FLOAT',
    'string' => 'TEXT',
    'boolean' => 'TINYINT(1)',
    _ => 'INT',
  };
}

const _maxConcurrent = 6;
const _batchSize = 200;

// ========== 后台导入 worker (运行在独立 isolate 中) ==========

/// 整个 DBC 导入流程在后台 isolate 中执行，包含 DB 连接、建表和写入。
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

  try {
    final laconic = Laconic(
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

    // 建表
    for (final file in files) {
      await _workerCreateTable(laconic, file);
    }

    // 并发导入
    final pool = Pool(_maxConcurrent);
    var imported = 0, skipped = 0;
    final errors = <String>[];
    await Future.wait(
      files.map(
        (file) => pool.withResource(() async {
          try {
            final result = await _workerImportFile(
              sendPort,
              laconic,
              dbcPath,
              file,
            );
            if (result.done) {
              imported++;
              sendPort.send((
                file.name,
                result.parseUs,
                result.convertUs,
                result.insertUs,
                result.startedAt,
              ));
            } else {
              skipped++;
              sendPort.send((file.name, 'skip'));
            }
          } catch (e) {
            errors.add('${file.name}: $e');
            sendPort.send((file.name, 'err'));
          }
          sendPort.send((imported + skipped + errors.length, files.length));
        }),
      ),
    );

    sendPort.send((errors.isEmpty, imported, skipped, errors));
  } catch (e) {
    sendPort.send((false, 0, 0, <String>['worker 初始化失败: $e']));
  }
}

Future<void> _workerCreateTable(Laconic laconic, _FileDef file) async {
  final columns = <String>[];
  for (final field in file.fields) {
    columns.add('`${field.name}` ${_sqlTypeFromString(field.type)}');
  }
  if (columns.isEmpty) return;
  final sql =
      'CREATE TABLE IF NOT EXISTS ${file.tableName} (\n'
      '  ${columns.join(',\n  ')}\n'
      ') ENGINE=InnoDB DEFAULT CHARSET=utf8mb4';
  await laconic.statement(sql);
}

Future<({bool done, int parseUs, int convertUs, int insertUs, int startedAt})>
_workerImportFile(
  SendPort sendPort,
  Laconic laconic,
  String dbcPath,
  _FileDef file,
) async {
  final count = await laconic.table(file.tableName).count();
  if (count > 0)
    return (done: false, parseUs: 0, convertUs: 0, insertUs: 0, startedAt: 0);

  final path = '$dbcPath\\${file.name}.dbc';
  if (!File(path).existsSync()) {
    throw FileSystemException('DBC 文件不存在', path);
  }

  final sw = Stopwatch()..start();
  final startedAt = DateTime.now().microsecondsSinceEpoch;
  var parseUs = 0, convertUs = 0, insertUs = 0;
  sendPort.send((file.name, -1));

  await laconic.transaction(() async {
    final loader = DbcLoader(path, file.format);
    parseUs = sw.elapsedMicroseconds;
    var records = <Map<String, dynamic>>[];
    var processedCount = 0;

    for (final record in loader.records) {
      final before = sw.elapsedMicroseconds;
      final map = <String, dynamic>{};
      for (final (:index, :name, :type) in file.fields) {
        map[name] = switch (type) {
          'string' => record.getString(index),
          'float' => record.getFloat(index),
          'int32' || 'id' => record.getInt(index),
          'uint8' => record.getUint8(index),
          'boolean' => record.getInt(index) != 0,
          _ => null,
        };
      }
      records.add(map);
      convertUs += sw.elapsedMicroseconds - before;

      if (records.length >= _batchSize) {
        final beforeInsert = sw.elapsedMicroseconds;
        await laconic.table(file.tableName).insert(records);
        insertUs += sw.elapsedMicroseconds - beforeInsert;
        processedCount += records.length;
        sendPort.send((file.name, processedCount));
        records.clear();
      }
    }

    if (records.isNotEmpty) {
      final beforeFlush = sw.elapsedMicroseconds;
      await laconic.table(file.tableName).insert(records);
      insertUs += sw.elapsedMicroseconds - beforeFlush;
      processedCount += records.length;
      sendPort.send((file.name, processedCount));
    }
  });

  return (
    done: true,
    parseUs: parseUs,
    convertUs: convertUs,
    insertUs: insertUs,
    startedAt: startedAt,
  );
}
