import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/entity/player_create_info_entity.dart';

void main() {
  test('六张 playercreateinfo 表 Entity 精确覆盖 31 个物理列', () {
    expect(const PlayerCreateInfoEntity().toJson().keys.toSet(), {
      'race',
      'class',
      'map',
      'zone',
      'position_x',
      'position_y',
      'position_z',
      'orientation',
    });
    expect(const PlayerCreateInfoActionEntity().toJson().keys.toSet(), {
      'race',
      'class',
      'button',
      'action',
      'type',
    });
    expect(const PlayerCreateInfoItemEntity().toJson().keys.toSet(), {
      'race',
      'class',
      'itemid',
      'amount',
      'Note',
    });
    expect(const PlayerCreateInfoSkillEntity().toJson().keys.toSet(), {
      'raceMask',
      'classMask',
      'skill',
      'rank',
      'comment',
    });
    expect(const PlayerCreateInfoSpellCustomEntity().toJson().keys.toSet(), {
      'racemask',
      'classmask',
      'Spell',
      'Note',
    });
    expect(const PlayerCreateInfoCastSpellEntity().toJson().keys.toSet(), {
      'raceMask',
      'classMask',
      'spell',
      'note',
    });
  });

  test('种族职业 ID 与掩码分别对应 SharedDefines', () {
    expect(kPlayerRaceOptions.keys.toList(), [1, 2, 3, 4, 5, 6, 7, 8, 10, 11]);
    expect(kPlayerClassOptions.keys.toList(), [1, 2, 3, 4, 5, 6, 7, 8, 9, 11]);
    expect(kPlayerCreateRaceMaskFlags.map((item) => item.value).toList(), [
      1,
      2,
      4,
      8,
      16,
      32,
      64,
      128,
      512,
      1024,
    ]);
    expect(kPlayerCreateClassMaskFlags.map((item) => item.value).toList(), [
      1,
      2,
      4,
      8,
      16,
      32,
      64,
      128,
      256,
      1024,
    ]);
    expect(playerCreateRaceBit(10), 512);
    expect(playerCreateClassBit(11), 1024);
    expect(kPlayerCreatePlayableRaceMask, 1791);
    expect(kPlayerCreatePlayableClassMask, 1535);
  });

  test('动作类型只包含 Player ActionButtonType', () {
    expect(kPlayerActionButtonTypeOptions.keys.toSet(), {
      0,
      1,
      32,
      64,
      65,
      128,
    });
    expect(
      () => const PlayerCreateInfoActionEntity(
        race: 1,
        class_: 1,
        button: 144,
      ).validate(),
      throwsStateError,
    );
  });

  test('技能阶数与 Mask 按 ObjectMgr loader 约束', () {
    const PlayerCreateInfoSkillEntity(
      raceMask: 0,
      classMask: 0,
      skill: 95,
      rank: 15,
    ).validate();
    expect(
      () => const PlayerCreateInfoSkillEntity(skill: 95, rank: 16).validate(),
      throwsStateError,
    );
    expect(
      () => const PlayerCreateInfoCastSpellEntity(
        raceMask: 256,
        spell: 2457,
      ).validate(),
      throwsStateError,
    );
  });

  test('Repository 使用通配与按位父项筛选', () {
    final itemRepository = File(
      'lib/repository/player_create_info_item_repository.dart',
    ).readAsStringSync();
    final skillRepository = File(
      'lib/repository/player_create_info_skill_repository.dart',
    ).readAsStringSync();
    final customRepository = File(
      'lib/repository/player_create_info_spell_custom_repository.dart',
    ).readAsStringSync();
    final castRepository = File(
      'lib/repository/player_create_info_cast_spell_repository.dart',
    ).readAsStringSync();

    expect(itemRepository, contains('`race` = 0 OR `race` = ?'));
    expect(itemRepository, contains('`class` = 0 OR `class` = ?'));
    expect(skillRepository, contains('(`raceMask` & ?) <> 0'));
    expect(skillRepository, contains('(`classMask` & ?) <> 0'));
    expect(customRepository, contains('(racemask & ?) <> 0'));
    expect(castRepository, contains('(`raceMask` & ?) <> 0'));
  });

  test('详情页覆盖全部关联 Tab 并使用精确字段组件', () {
    final detail = File(
      'lib/page/player_create_info/player_create_info_detail_page.dart',
    ).readAsStringSync();
    final mainView = File(
      'lib/page/player_create_info/player_create_info_view.dart',
    ).readAsStringSync();
    final actionView = File(
      'lib/page/player_create_info/player_create_info_action_view.dart',
    ).readAsStringSync();
    final skillView = File(
      'lib/page/player_create_info/player_create_info_skill_view.dart',
    ).readAsStringSync();

    for (final tab in ['动作按钮', '起始物品', '初始技能', '自定义法术', '登录施法']) {
      expect(detail, contains("Text('$tab')"));
    }
    expect(mainView, contains('kPlayerRaceOptions'));
    expect(mainView, contains('kPlayerClassOptions'));
    expect(mainView, contains('FoxyEntityPickerDelegates.playerCreateMap'));
    expect(mainView, contains('FoxyEntityPickerDelegates.areaTable'));
    expect(actionView, contains('kPlayerActionButtonTypeOptions'));
    expect(actionView, contains('FoxyEntityPickerDelegates.spell'));
    expect(actionView, contains('FoxyEntityPickerDelegates.itemTemplate'));
    expect(skillView, contains('FoxyEntityPickerDelegates.skillLine'));
  });

  test('出生地图 Picker 排除 ObjectMgr 不接受的实例地图', () {
    final repository = File(
      'lib/repository/map_info_repository.dart',
    ).readAsStringSync();
    final delegates = File(
      'lib/widget/foxy_entity_picker_delegates.dart',
    ).readAsStringSync();
    expect(repository, contains("whereNotIn('InstanceType', [1, 2, 3, 4])"));
    expect(delegates, contains('playerCreateMap'));
    expect(delegates, contains('nonInstanceableOnly: true'));
  });

  test('全部详情表单行由四个等宽 Expanded 构成且无数组字段管理', () {
    const views = [
      'player_create_info_view.dart',
      'player_create_info_action_view.dart',
      'player_create_info_item_view.dart',
      'player_create_info_skill_view.dart',
      'player_create_info_spell_custom_view.dart',
      'player_create_info_cast_spell_view.dart',
    ];
    for (final name in views) {
      final source = File(
        'lib/page/player_create_info/$name',
      ).readAsStringSync();
      expect(source, isNot(contains('flex:')));
    }

    final entity = File(
      'lib/entity/player_create_info_entity.dart',
    ).readAsStringSync();
    expect(entity, isNot(contains('List<')));
    expect(entity, isNot(contains('Map<int')));
  });
}
