import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/item_visuals_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 41;
    expect((const ItemVisualsEntity(id: 41)).id, first);
    expect(const BriefItemVisualsEntity(id: 41).key, first);
  });

  test('ItemVisuals Repository 使用原始键且写入只触及自身表', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/item_visuals_repository.dart',
    );
    expect(source, contains('Future<int> copyItemVisual('));
    expect(source, contains('Future<void> storeItemVisuals('));
    expect(source, contains('insert([json])'));
    expect(source, isNot(contains('Future<int> storeItemVisuals')));
    expect(source, isNot(contains('saveItemVisual(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(json)'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('foxy.dbc_spell_item_enchantment')));
  });
}
