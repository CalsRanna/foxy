import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/page/setting/setting_view_model.dart';

void main() {
  test('ScaffoldViewModel 源码不持有导出相关状态字段', () async {
    final source = await File(
      'lib/page/scaffold/scaffold_view_model.dart',
    ).readAsString();
    // 导出状态应在 SettingViewModel，不在 Scaffold。
    expect(source.contains('dbcExport'), isFalse);
    expect(source.contains('exportDbc'), isFalse);
    expect(source.contains('DbcExport'), isFalse);
  });

  test('SettingPage 只通过 SettingViewModel 管理 DBC', () async {
    final source = await File(
      'lib/page/setting/setting_page.dart',
    ).readAsString();
    expect(source.contains('ScaffoldViewModel'), isFalse);
    expect(source.contains('FoxyViewModel'), isFalse);
    expect(source.contains('foxy_view_model'), isFalse);
    expect(source.contains('scaffold_view_model'), isFalse);
    expect(source.contains('SettingViewModel'), isTrue);
    expect(source.contains('DbcImportDialog'), isTrue);
    expect(source.contains('DbcExportDialog'), isTrue);
    expect(source.contains('DatabaseSetting'), isFalse);
    expect(source.contains('localeEnabled'), isFalse);
  });

  test('DbcExportItem 与 SettingViewModel 选择语义可组合', () {
    expect(DbcExportItem, isNotNull);
    expect(SettingViewModel, isNotNull);
    expect(ScaffoldViewModel, isNotNull);
  });
}
