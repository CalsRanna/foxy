import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/page/feature/feature_state_view_model.dart';
import 'package:foxy/page/setting/dbc_export_workflow_view_model.dart';
import 'package:foxy/page/setting/dbc_import_workflow_view_model.dart';

void main() {
  test('FeatureStateViewModel 源码不持有 DBC 状态', () async {
    final source = await File(
      'lib/page/feature/feature_state_view_model.dart',
    ).readAsString();
    // 导出状态应在独立 workflow，不在 Scaffold。
    expect(source.contains('dbcExport'), isFalse);
    expect(source.contains('exportDbc'), isFalse);
    expect(source.contains('DbcExport'), isFalse);
  });

  test('SettingPage 只通过两个具体 WorkflowViewModel 管理 DBC', () async {
    final source = await File(
      'lib/page/setting/setting_page.dart',
    ).readAsString();
    expect(source.contains('ScaffoldViewModel'), isFalse);
    expect(source.contains('FoxyViewModel'), isFalse);
    expect(source.contains('foxy_view_model'), isFalse);
    expect(source.contains('scaffold_view_model'), isFalse);
    expect(source.contains('DbcImportWorkflowViewModel'), isTrue);
    expect(source.contains('DbcExportWorkflowViewModel'), isTrue);
    expect(source.contains('DbcImportDialog'), isTrue);
    expect(source.contains('DbcExportDialog'), isTrue);
    expect(source.contains('DatabaseSetting'), isFalse);
    expect(source.contains('localeEnabled'), isFalse);
  });

  test('导入和导出使用各自具体 WorkflowViewModel', () {
    expect(DbcExportItem, isNotNull);
    expect(DbcExportWorkflowViewModel, isNotNull);
    expect(DbcImportWorkflowViewModel, isNotNull);
    expect(FeatureStateViewModel, isNotNull);
  });
}
