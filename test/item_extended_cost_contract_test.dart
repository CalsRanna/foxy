import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_purchase_group_entity.dart';

void main() {
  test('ItemExtendedCost Entity 精确覆盖 16 个物理列且全部为标量', () {
    final json = const ItemExtendedCostEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'HonorPoints',
      'ArenaPoints',
      'ArenaBracket',
      'ItemID0',
      'ItemID1',
      'ItemID2',
      'ItemID3',
      'ItemID4',
      'ItemCount0',
      'ItemCount1',
      'ItemCount2',
      'ItemCount3',
      'ItemCount4',
      'RequiredArenaRating',
      'ItemPurchaseGroup',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('ItemPurchaseGroup DBC 精确覆盖 26 个独立物理列', () {
    final json = const ItemPurchaseGroupEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'ItemID0',
      'ItemID1',
      'ItemID2',
      'ItemID3',
      'ItemID4',
      'ItemID5',
      'ItemID6',
      'ItemID7',
      'Name_lang_enUS',
      'Name_lang_koKR',
      'Name_lang_frFR',
      'Name_lang_deDE',
      'Name_lang_zhCN',
      'Name_lang_zhTW',
      'Name_lang_esES',
      'Name_lang_esMX',
      'Name_lang_ruRU',
      'Name_lang_jaJP',
      'Name_lang_ptPT',
      'Name_lang_ptBR',
      'Name_lang_itIT',
      'Name_lang_unk1',
      'Name_lang_unk2',
      'Name_lang_unk3',
      'Name_lang_Flags',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);

    final definition = dbcDefinitionByTable['dbc_item_purchase_group']!;
    expect(definition.fileName, 'ItemPurchaseGroup.dbc');
    expect(definition.schema.format, 'niiiiiiiissssssssssssssssi');
    expect(definition.schema.fields, hasLength(26));
    expect(
      DbcLocaleFields.itemPurchaseGroupName.tableName,
      'dbc_item_purchase_group',
    );
    expect(DbcLocaleFields.itemPurchaseGroupName.columnPrefix, 'Name_lang');
  });
}
