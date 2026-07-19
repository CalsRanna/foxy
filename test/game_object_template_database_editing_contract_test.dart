import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_game_object_template_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';

void main() {
  test('Brief key 返回物理 entry 标量', () {
    const key = 7;
    expect((const GameObjectTemplateEntity(entry: 7)).entry, key);
    expect(const BriefGameObjectTemplateEntity(entry: 7).key, key);
  });

  test('Repository 使用原 key、完整 candidate 和单表写入边界', () {
    final source = File(
      'lib/repository/game_object_template_repository.dart',
    ).readAsStringSync();

    expect(source, contains('int originalKey'));
    expect(source, contains(').update(template.toJson())'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveGameObjectTemplate(')));
    expect(source, isNot(contains("json.remove('entry')")));
  });

  test('详情路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/game_object/game_object_template_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/game_object/game_object_template_list_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/game_object/game_object_template_view.dart',
    ).readAsStringSync();

    expect(page, contains('final int? gameObjectTemplateKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('templates[row].key'));
    expect(view, contains('viewModel.persistedKey.value'));
    expect(view, isNot(contains('readOnly: true')));
  });

  test('BriefGameObjectTemplate 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_game_object_template_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
