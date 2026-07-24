import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('GossipMenuKey 与 Brief 完整覆盖 MenuID + TextID', () {
    const key = GossipMenuKey(menuId: 7, textId: 8);
    expect(key, const GossipMenuKey(menuId: 7, textId: 8));
    expect(key.hashCode, const GossipMenuKey(menuId: 7, textId: 8).hashCode);
    expect(
      GossipMenuKey.fromEntity(const GossipMenuEntity(menuId: 7, textId: 8)),
      key,
    );
    expect(const BriefGossipMenuEntity(menuId: 7, textId: 8).key, key);
  });

  test('Repository 使用原 key、完整 candidate 和单表写入边界', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/gossip_menu_repository.dart',
    );
    expect(source, contains('GossipMenuKey originalKey'));
    expect(source, contains(').update(json)'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveGossipMenu(')));
  });

  test('详情路由只携带 typed key 且列表传 brief.key', () {
    final page = File(
      'lib/page/gossip_menu/gossip_menu_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/gossip_menu/gossip_menu_list_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/gossip_menu/gossip_menu_view.dart',
    ).readAsStringSync();
    expect(page, contains('final GossipMenuKey? gossipMenuKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('_navigateToDetail(key: item.key'));
    expect(view, isNot(contains('readOnly: true')));
  });
}
