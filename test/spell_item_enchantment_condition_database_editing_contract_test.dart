import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefSpellItemEnchantmentConditionEntity(id: 7).key, key);
  });

  test('SpellItemEnchantmentCondition Repository 使用显式键和单表边界', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/spell_item_enchantment_condition_repository.dart',
    );
    expect(source, contains('int key'));
    expect(
      source,
      contains('Future<void> storeSpellItemEnchantmentCondition('),
    );
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(entity.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSpellItemEnchantmentCondition(')));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, isNot(contains("table('foxy.dbc_spell_item_enchantment')")));
  });
}
