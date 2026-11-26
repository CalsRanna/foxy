import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/model/dbc/dbc_sync_progress.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';

void main() {
  test(
    'Schema incompatibilities show the corresponding title and list details',
    () {
      final message = DbcImportWorkflowViewModel.formatBlockingMessage([
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
    },
  );

  test('Query errors alone use the check-failed title', () {
    final message = DbcImportWorkflowViewModel.formatBlockingMessage([
      const DbcTableCheckResult(
        tableName: 'dbc_spell',
        state: DbcTableState.error,
        message: 'access denied',
      ),
    ]);

    expect(message, startsWith('DBC 表检查失败'));
    expect(message, contains('access denied'));
  });

  test('More than five entries adds an omission notice', () {
    final blocking = List.generate(
      6,
      (index) => DbcTableCheckResult(
        tableName: 'dbc_table_$index',
        state: DbcTableState.error,
        message: 'e$index',
      ),
    );
    final message = DbcImportWorkflowViewModel.formatBlockingMessage(blocking);

    expect(message, contains('...等 6 张表'));
    expect(message, isNot(contains('dbc_table_5:')));
  });
}
