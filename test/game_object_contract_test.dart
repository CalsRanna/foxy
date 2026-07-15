import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/game_object_constants.dart';
import 'package:foxy/entity/cinematic_sequence_entity.dart';
import 'package:foxy/entity/destructible_model_data_entity.dart';
import 'package:foxy/entity/game_object_art_kit_entity.dart';
import 'package:foxy/entity/game_object_display_info_entity.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/entity/game_object_template_locale_entity.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/spell_focus_object_entity.dart';
import 'package:foxy/entity/taxi_path_entity.dart';
import 'package:foxy/widget/foxy_locale_picker_delegates.dart';

void main() {
  test('gameobject_template Entity 覆盖 35 个物理列且无聚合字段', () {
    final json = const GameObjectTemplateEntity().toJson();
    expect(json, hasLength(35));
    expect(json.keys.where((key) => key.startsWith('Data')), hasLength(24));
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json['size'], isA<double>());
  });

  test('3 个关联 Tab 与 locale Entity 只写出各自物理列', () {
    expect(const GameObjectTemplateAddonEntity().toJson().keys.toSet(), {
      'entry',
      'faction',
      'flags',
      'mingold',
      'maxgold',
      'artkit0',
      'artkit1',
      'artkit2',
      'artkit3',
    });
    expect(const GameObjectQuestItemEntity().toJson().keys.toSet(), {
      'GameObjectEntry',
      'Idx',
      'ItemId',
      'VerifiedBuild',
    });
    expect(const GameObjectTemplateLocaleEntity().toJson(), hasLength(5));
    expect(const LootTemplateEntity().toJson(), hasLength(10));
  });

  test('GameobjectTypes 完整覆盖 AzerothCore 0..35', () {
    expect(kGameObjectTypeOptions.keys.toSet(), {
      for (var type = 0; type <= 35; type++) type,
    });
  });

  test('GameObjectFlags 只包含服务端定义的 9 个数据库位', () {
    expect(kGameObjectFlagItems.map((item) => item.value).toSet(), {
      0x00000001,
      0x00000002,
      0x00000004,
      0x00000008,
      0x00000010,
      0x00000020,
      0x00000040,
      0x00000200,
      0x00000400,
    });
  });

  test('Data0..Data23 可编辑槽位与 GameObjectData.h 联合体一致', () {
    final expected = <int, Set<int>>{
      0: _range(0, 6),
      1: _range(0, 8),
      2: _range(0, 9),
      3: _range(0, 16),
      4: {},
      5: _range(0, 5),
      6: _range(0, 14),
      7: _range(0, 3),
      8: _range(0, 6),
      9: _range(0, 3),
      10: _range(0, 20),
      11: _range(0, 4),
      12: _range(0, 7),
      13: _range(0, 3),
      14: {},
      15: _range(0, 8),
      16: {},
      17: {},
      18: _range(0, 7),
      19: {},
      20: {},
      21: _range(0, 1),
      22: _range(0, 4),
      23: _range(0, 2),
      24: _range(0, 7),
      25: _range(0, 4),
      26: _range(0, 4),
      27: {0},
      28: {},
      29: _range(0, 21),
      30: _range(0, 6),
      31: _range(0, 1),
      32: _range(0, 1),
      33: {0, 1, 2, 3, 4, 5, 9, 10, 14, 16, 18, 19, 22},
      34: {},
      35: _range(0, 2),
    };

    for (var type = 0; type <= 35; type++) {
      final actual = <int>{};
      for (var index = 0; index < 24; index++) {
        if (gameObjectDataFieldConfig(type, index).editable) actual.add(index);
      }
      expect(actual, expected[type], reason: 'GameObject type $type');
    }
  });

  test('关键 Data 外键指向精确 Store 或世界表', () {
    expect(
      gameObjectDataFieldConfig(8, 0).reference,
      GameObjectDataReference.spellFocusObject,
    );
    expect(
      gameObjectDataFieldConfig(13, 1).reference,
      GameObjectDataReference.cinematicSequence,
    );
    expect(
      gameObjectDataFieldConfig(15, 0).reference,
      GameObjectDataReference.taxiPath,
    );
    expect(
      gameObjectDataFieldConfig(33, 18).reference,
      GameObjectDataReference.destructibleModelData,
    );
    expect(
      gameObjectDataFieldConfig(33, 4).reference,
      GameObjectDataReference.gameObjectDisplayInfo,
    );
    expect(
      gameObjectDataFieldConfig(3, 1).reference,
      GameObjectDataReference.gameObjectLoot,
    );
  });

  test('新增 GameObject DBC Entity 全部使用独立标量字段', () {
    final rows = <Map<String, dynamic>>[
      const CinematicSequenceEntity().toJson(),
      const DestructibleModelDataEntity().toJson(),
      const GameObjectArtKitEntity().toJson(),
      const GameObjectDisplayInfoEntity().toJson(),
      const SpellFocusObjectEntity().toJson(),
      const TaxiPathEntity().toJson(),
    ];
    expect(rows.map((row) => row.length), [10, 19, 8, 19, 18, 4]);
    for (final row in rows) {
      expect(row.values.whereType<List<Object?>>(), isEmpty);
    }
    expect(
      requiredDbcTableNames.toSet(),
      containsAll({
        'dbc_cinematic_sequences',
        'dbc_destructible_model_data',
        'dbc_game_object_art_kit',
        'dbc_game_object_display_info',
        'dbc_spell_focus_object',
        'dbc_taxi_path',
      }),
    );
  });

  test('关键跨字段和任务物品槽位约束会拒绝非法值', () {
    expect(
      () => const GameObjectTemplateEntity(
        type: 23,
        data0: 80,
        data1: 60,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const GameObjectTemplateAddonEntity(
        entry: 1,
        minGold: 2,
        maxGold: 1,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const GameObjectQuestItemEntity(
        gameObjectEntry: 1,
        idx: 6,
        itemId: 1,
      ).validate(),
      throwsArgumentError,
    );
  });

  test('gameobject_template_locale 两个编辑器写入各自物理列', () {
    expect(FoxyLocalePickerDelegates.gameObjectName.fields, ['locale', 'name']);
    expect(FoxyLocalePickerDelegates.gameObjectCaption.fields, [
      'locale',
      'castBarCaption',
    ]);
  });

  test('主表 UI 和 ViewModel 不使用循环或数组管理 Data 字段', () {
    final view = File(
      'lib/page/game_object/game_object_template_view.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/game_object/game_object_template_detail_view_model.dart',
    ).readAsStringSync();
    expect(view, isNot(contains('for (')));
    expect(view, isNot(contains('dataController(')));
    expect(viewModel, isNot(contains('dataController(')));
  });
}

Set<int> _range(int start, int end) => {
  for (var value = start; value <= end; value++) value,
};
