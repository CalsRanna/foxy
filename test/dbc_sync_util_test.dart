import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/util/dbc_sync_progress.dart';
import 'package:foxy/util/dbc_sync_util.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  test('DBC 导入 worker 失败时发出唯一结果并关闭流', () async {
    final util = DbcSyncUtil();
    final missingDirectory =
        '${Directory.systemTemp.path}/foxy_missing_${DateTime.now().microsecondsSinceEpoch}';

    final events = await util
        .import(
          directory: missingDirectory,
          mysqlConfig: const MysqlConfig(
            database: 'unused',
            username: 'unused',
            password: 'unused',
          ),
        )
        .toList()
        .timeout(const Duration(seconds: 5));

    final results = events.whereType<DbcSyncResult>().toList();
    expect(results, hasLength(1));
    expect(results.single.success, isFalse);
    expect(results.single.errors.single.message, contains('目录不存在'));
    expect(util.isRunning, isFalse);
    expect(util.operation, isNull);
  });
}
