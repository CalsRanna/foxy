import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/item_purchase_group_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefItemPurchaseGroupEntity(id: 7).key, key);
  });

  test('ItemPurchaseGroup Repository 使用显式键和单表边界', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/item_purchase_group_repository.dart',
    );
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeItemPurchaseGroup('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(json)'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveItemPurchaseGroupLocales('));
    expect(source, isNot(contains('saveItemPurchaseGroup(')));
    expect(source, isNot(contains("table('foxy.dbc_item_extended_cost')")));
    expect(source, isNot(contains("remove('ID')")));
  });
}
