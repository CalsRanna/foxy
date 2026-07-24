import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/constant/item_extended_cost_constants.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_purchase_group_entity.dart';
import 'support/local_dart_library_source.dart';

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

  test('竞技场字段使用 ArenaSlot 0..2 而不是 ArenaTeamTypes 2/3/5', () {
    expect(kItemExtendedCostArenaSlotOptions.keys, [0, 1, 2]);
    expect(
      const ItemExtendedCostEntity(id: 1, arenaBracket: 2).validate,
      returnsNormally,
    );
    expect(
      () => const ItemExtendedCostEntity(id: 1, arenaBracket: 3).validate(),
      throwsStateError,
    );
  });

  test('物品 ID 非零时要求正数量，空槽保留服务端忽略的原始计数', () {
    expect(
      const ItemExtendedCostEntity(id: 1, itemCount4: 7).validate,
      returnsNormally,
    );
    expect(
      () => const ItemExtendedCostEntity(id: 1, itemID0: 25).validate(),
      throwsStateError,
    );
    expect(
      () => const ItemExtendedCostEntity(id: 1, honorPoints: -1).validate(),
      throwsStateError,
    );
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

  test('Entity 和 ViewModel 不用数组、Map 或循环管理重复槽位', () {
    final entity = File(
      'lib/entity/item_extended_cost_entity.dart',
    ).readAsStringSync();
    final purchaseGroup = File(
      'lib/entity/item_purchase_group_entity.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/item_extended_cost/item_extended_cost_detail_view_model.dart',
    ).readAsStringSync();
    for (final source in [entity, purchaseGroup, viewModel]) {
      expect(source, isNot(contains('final List<')));
      expect(source, isNot(contains('final Map<')));
      expect(source, isNot(contains('final ids = [')));
      expect(source, isNot(contains('for (')));
    }
    expect(viewModel, contains('itemID0Controller.collect()'));
    expect(viewModel, contains('itemID4Controller.collect()'));
    expect(viewModel, contains('itemCount0Controller.init('));
    expect(viewModel, contains('itemCount4Controller.init('));
  });

  test('详情页使用准确 Picker 且所有表单行均为四列等宽', () {
    final view = File(
      'lib/page/item_extended_cost/item_extended_cost_view.dart',
    ).readAsStringSync();
    expect(
      'FoxyEntityPickerDelegates.itemTemplate'.allMatches(view),
      hasLength(5),
    );
    expect(view, contains('FoxyEntityPickerDelegates.itemPurchaseGroup'));
    expect(view, contains('kItemExtendedCostArenaSlotOptions'));
    expect(view, isNot(contains('flex:')));
    expect('Expanded(child:'.allMatches(view), hasLength(20));
    expect(view, isNot(contains('readOnly: true')));
  });

  test('Repository 使用原始键、完整 candidate 和单表边界', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/item_extended_cost_repository.dart',
    );
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(json)'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains("table('item_template')")));
    expect(source, isNot(contains("table('foxy.dbc_item_purchase_group')")));
    expect(source, isNot(contains("table('npc_vendor')")));
    expect(source, isNot(contains("table('game_event_npc_vendor')")));
    expect(source, isNot(contains("remove('ID')")));

    final viewModel = File(
      'lib/page/item_extended_cost/item_extended_cost_detail_view_model.dart',
    ).readAsStringSync();
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(
      viewModel,
      contains('updateItemExtendedCost(originalKey, candidate)'),
    );
    expect(viewModel, contains('persistedKey.value = candidate.id'));
  });
}
