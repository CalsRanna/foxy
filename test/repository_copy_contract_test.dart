import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Repository 不暴露读取源记录后静默返回的 copy API', () {
    final silentCopyPattern = RegExp(
      r'Future<void>\s+copy\w+\([^)]*\)\s+async\s*\{'
      r'.*?if\s*\(source\s*==\s*null\)\s*return;\s*\}',
      dotAll: true,
    );
    final offenders = Directory('lib/repository')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .where((file) => silentCopyPattern.hasMatch(file.readAsStringSync()))
        .map((file) => file.path)
        .toList();

    expect(offenders, isEmpty, reason: 'copy API 必须实际写入或明确拒绝操作');
  });

  test('对话选项 locale 批量复制仍会写入目标 OptionID', () {
    final source = File(
      'lib/repository/gossip_menu_option_locale_repository.dart',
    ).readAsStringSync();
    expect(source, contains('copyGossipMenuOptionLocales('));
    expect(source, contains("json['MenuID'] = targetKey.menuId"));
    expect(source, contains("json['OptionID'] = targetKey.optionId"));
    expect(source, contains('table(_table).insert(jsons)'));
  });
}
