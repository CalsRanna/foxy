import 'dart:io';

import 'package:foxy/util/logger_util.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:yaml/yaml.dart';

/// 数据库检查工具
///
/// 用法：
///   dart run tool/db_inspect.dart                          # 列出 foxy 库所有表
///   dart run tool/db_inspect.dart foxy.dbc_spell            # 查看指定表结构
///   dart run tool/db_inspect.dart acore_world.spell_dbc     # 查看 acore_world 库表
///   dart run tool/db_inspect.dart foxy.dbc_spell --diff     # 对比模型与数据库字段

Future<void> main(List<String> args) async {
  final config = _loadConfig();
  final laconic = Laconic(MysqlDriver(config));

  try {
    if (args.isEmpty) {
      await _listTables(laconic);
    } else {
      final table = args[0];
      final showDiff = args.contains('--diff');
      await _describeTable(laconic, table, showDiff: showDiff);
    }
  } finally {
    await laconic.close();
  }
}

MysqlConfig _loadConfig() {
  final path = '${Directory.current.path}/config.yaml';
  final file = File(path);
  if (!file.existsSync()) {
    logger.i('config.yaml 不存在: $path');
    exit(1);
  }
  final yaml = loadYaml(file.readAsStringSync()) as Map;
  return MysqlConfig(
    host: (yaml['host'] as String?) ?? '127.0.0.1',
    port: int.tryParse((yaml['port'] as String?) ?? '3306') ?? 3306,
    database: (yaml['database'] as String?) ?? 'acore_world',
    username: (yaml['username'] as String?) ?? 'root',
    password: (yaml['password'] as String?) ?? 'root',
  );
}

Future<void> _listTables(Laconic laconic) async {
  logger.i('=== foxy 库中的 DBC 表 ===');
  var results = await laconic.select(
    "SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'foxy' ORDER BY TABLE_NAME",
  );
  if (results.isEmpty) {
    logger.i('(无 DBC 表，可能尚未导入)');
  } else {
    for (final row in results) {
      logger.i('  ${row['TABLE_NAME']}');
    }
  }

  logger.i('\n=== acore_world 库中的表（前 30） ===');
  results = await laconic.select(
    "SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'acore_world' ORDER BY TABLE_NAME LIMIT 30",
  );
  for (final row in results) {
    logger.i('  ${row['TABLE_NAME']}');
  }

  final count = await laconic.select(
    "SELECT COUNT(*) AS cnt FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'acore_world'",
  );
  final total = count.first['cnt'];
  logger.i('  ... 共 $total 张表');
}

Future<void> _describeTable(
  Laconic laconic,
  String table, {
  bool showDiff = false,
}) async {
  // 解析 schema.table 格式
  final parts = table.split('.');
  final tableName = parts.length > 1 ? parts[1] : parts[0];

  logger.i('=== $table 表结构 ===\n');

  final results = await laconic.select('DESCRIBE $table');

  if (results.isEmpty) {
    logger.i('表不存在或为空');
    return;
  }

  // 格式化输出
  final rows = results
      .map(
        (r) => (
          field: r['Field'] as String,
          type: r['Type'] as String,
          nullable: r['Null'] as String,
          key: r['Key'] as String,
          default_: r['Default'],
          extra: r['Extra'] as String,
        ),
      )
      .toList();

  final fieldWidth = rows.fold<int>(
    8,
    (w, r) => w > r.field.length ? w : r.field.length,
  );
  final typeWidth = rows.fold<int>(
    4,
    (w, r) => w > r.type.length ? w : r.type.length,
  );

  logger.i(
    '${'Field'.padRight(fieldWidth)}  ${'Type'.padRight(typeWidth)}  Null  Key  Default  Extra',
  );
  logger.i(
    '${'-' * fieldWidth}  ${'-' * typeWidth}  ----  ---  -------  -----',
  );

  for (final row in rows) {
    logger.i(
      '${row.field.padRight(fieldWidth)}  ${row.type.padRight(typeWidth)}  ${row.nullable.padRight(4)}  ${row.key.padRight(3)}  ${'${row.default_ ?? ''}'.padRight(7)}  ${row.extra}',
    );
  }
  logger.i('\n共 ${rows.length} 列\n');

  if (showDiff) {
    // 尝试加载对应模型并进行对比
    await _compareWithModel(tableName, rows.map((r) => r.field).toList());
  }
}

Future<void> _compareWithModel(String tableName, List<String> dbFields) async {
  // 将表名转换为可能的模型类名
  final modelName = _tableToModelName(tableName);
  final modelFile = File('${Directory.current.path}/lib/model/$modelName.dart');

  if (!modelFile.existsSync()) {
    logger.i('未找到对应模型文件: lib/model/$modelName.dart，跳过对比');
    return;
  }

  logger.i('尝试解析模型字段...');
  final content = modelFile.readAsStringSync();

  // 粗略提取 fromJson 中的 JSON key 作为模型字段名
  final modelFields = <String>[];
  final keyRegex = RegExp(r"""json\['(\w+)'\]""");
  for (final match in keyRegex.allMatches(content)) {
    final key = match.group(1)!;
    if (!modelFields.contains(key)) modelFields.add(key);
  }

  // 排除 toJson 中的 key（只考虑 fromJson 中的）
  final toJsonKeys = <String>[];
  final toJsonRegex = RegExp(r"""'(\w+)':""");
  // 找 toJson 方法体
  final toJsonMatch = RegExp(
    r"Map<String, dynamic> toJson\(\) \{[^}]+\}",
  ).firstMatch(content);
  if (toJsonMatch != null) {
    for (final match in toJsonRegex.allMatches(toJsonMatch.group(0)!)) {
      toJsonKeys.add(match.group(1)!);
    }
  }

  logger.i('\n--- 对比结果 ---');

  final dbSet = dbFields.toSet();
  final modelSet = modelFields.toSet();

  // DB有但模型没有
  final missingInModel = dbSet.difference(modelSet);
  if (missingInModel.isNotEmpty) {
    logger.e('DB 中存在但模型 fromJson 中缺失:');
    for (final f in missingInModel) {
      logger.e('   - $f');
    }
  }

  // 模型有但DB没有
  final extraInModel = modelSet.difference(dbSet);
  if (extraInModel.isNotEmpty) {
    logger.w('模型 fromJson 中存在但 DB 中没有:');
    for (final f in extraInModel) {
      logger.w('   - $f');
    }
  }

  // toJson 中有但DB没有（写回会报错）
  final toJsonExtra = toJsonKeys.toSet().difference(dbSet);
  if (toJsonExtra.isNotEmpty) {
    logger.e('toJson 输出 DB 中不存在的字段（写回可能报错）:');
    for (final f in toJsonExtra) {
      logger.e('   - $f');
    }
  }

  if (missingInModel.isEmpty && extraInModel.isEmpty) {
    logger.i('模型字段与数据库完全匹配');
  }
}

String _tableToModelName(String table) {
  // 去掉 dbc_ 前缀
  var name = table;
  if (name.startsWith('dbc_')) name = name.substring(4);

  // 下划线转驼峰
  return name.split('_').map((part) {
    if (part.isEmpty) return '';
    return part[0].toUpperCase() + part.substring(1);
  }).join();
}
