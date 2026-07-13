import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';

void main() {
  test('结构不兼容时使用对应标题并列出详情', () {
    final message = formatDbcCheckBlockingMessage([
      const DbcTableCheckResult(
        tableName: 'dbc_spell',
        state: DbcTableState.incompatible,
        message: '缺少字段: foo',
      ),
      const DbcTableCheckResult(
        tableName: 'dbc_map',
        state: DbcTableState.error,
        message: 'timeout',
      ),
    ]);

    expect(message, startsWith('DBC 表结构不兼容'));
    expect(message, contains('dbc_spell: 缺少字段: foo'));
    expect(message, contains('dbc_map: timeout'));
  });

  test('仅查询错误时使用检查失败标题', () {
    final message = formatDbcCheckBlockingMessage([
      const DbcTableCheckResult(
        tableName: 'dbc_spell',
        state: DbcTableState.error,
        message: 'access denied',
      ),
    ]);

    expect(message, startsWith('DBC 表检查失败'));
    expect(message, contains('access denied'));
  });

  test('超过 5 条时追加省略提示', () {
    final blocking = List.generate(
      6,
      (index) => DbcTableCheckResult(
        tableName: 'dbc_table_$index',
        state: DbcTableState.error,
        message: 'e$index',
      ),
    );
    final message = formatDbcCheckBlockingMessage(blocking);

    expect(message, contains('...等 6 张表'));
    expect(message, isNot(contains('dbc_table_5:')));
  });
}
