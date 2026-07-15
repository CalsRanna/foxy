import 'support/entity_validation_test_extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/entity/creature_default_trainer_entity.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/entity/creature_template_entity.dart';
import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/page/creature_template/creature_template_detail_page.dart';
import 'package:foxy/repository/creature_template_resistance_repository.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/repository/dbc_item_repository.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';

void main() {
  test('CreatureTemplateEntity 覆盖 creature_template 的 55 个字段且类型正确', () {
    final json = const CreatureTemplateEntity().toJson();
    const stringFields = {
      'AIName',
      'IconName',
      'name',
      'ScriptName',
      'subname',
    };
    const doubleFields = {
      'ArmorModifier',
      'BaseVariance',
      'DamageModifier',
      'detection_range',
      'ExperienceModifier',
      'HealthModifier',
      'HoverHeight',
      'ManaModifier',
      'RangeVariance',
      'speed_flight',
      'speed_run',
      'speed_swim',
      'speed_walk',
    };

    expect(json, hasLength(55));
    for (final entry in json.entries) {
      if (stringFields.contains(entry.key)) {
        expect(entry.value, isA<String>(), reason: entry.key);
      } else if (doubleFields.contains(entry.key)) {
        expect(entry.value, isA<double>(), reason: entry.key);
      } else {
        expect(entry.value, isA<int>(), reason: entry.key);
      }
    }
    expect(json['unit_class'], 1);
  });

  test('creature_template 枚举选项与 AzerothCore 服务端取值集一致', () {
    expect(kUnitClassOptions.keys.toSet(), {1, 2, 4, 8});
    expect(kRankOptions.keys.toSet(), {0, 1, 2, 3, 4, 5});
    expect(kCreatureTypeOptions.keys.toSet(), {
      for (var value = 0; value <= 13; value++) value,
    });
    expect(kBooleanOptions.keys.toSet(), {0, 1});
    expect(kExpansionOptions.keys.toSet(), {0, 1, 2});
    expect(kDamageSchoolOptions.keys.toSet(), {
      for (var value = 0; value <= 6; value++) value,
    });
    expect(kMovementTypeOptions.keys.toSet(), {0, 1, 2});
    expect(kVisibilityDistanceTypeOptions.keys.toSet(), {0, 1, 2, 3, 4, 5});
    expect(kCreatureFamilyOptions.keys.toSet(), {
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      15,
      16,
      17,
      19,
      20,
      21,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      37,
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45,
      46,
    });
  });

  test('creature_template 位标志选项覆盖服务端定义的全部可编辑位', () {
    expect(_valuesOf(kNpcFlagOptions), _bits(0, 26));
    expect(_valuesOf(kUnitFlagOptions), _bits(0, 31));
    expect(_valuesOf(kUnitFlag2Options), {
      ..._bits(0, 8),
      ..._bits(10, 18),
      1 << 24,
    });
    expect(_valuesOf(kCreatureTypeFlagOptions), _bits(0, 31));
    expect(_valuesOf(kDynamicFlagOptions), _bits(0, 7));
    expect(_valuesOf(kLootModeFlagOptions), {1, 2, 4, 8, 16, 32, 0x8000});

    final dbAllowedExtraFlags = _bits(0, 31)..remove(1 << 28);
    expect(_valuesOf(kFlagsExtraOptions), dbAllowedExtraFlags);
    expect(_valuesOf(kFlagsExtraOptions), isNot(contains(1 << 28)));
  });

  test('11 个关联 Tab 的 Entity 写出字段与目标 SQL 列一致', () {
    expect(const CreatureTemplateAddonEntity().toJson().keys.toSet(), {
      'entry',
      'path_id',
      'mount',
      'emote',
      'bytes1',
      'bytes2',
      'visibilityDistanceType',
      'auras',
    });
    expect(const CreatureOnKillReputationEntity().toJson().keys.toSet(), {
      'creature_id',
      'RewOnKillRepFaction1',
      'RewOnKillRepFaction2',
      'MaxStanding1',
      'MaxStanding2',
      'IsTeamAward1',
      'IsTeamAward2',
      'RewOnKillRepValue1',
      'RewOnKillRepValue2',
      'TeamDependent',
    });
    expect(const CreatureTemplateResistanceEntity().toJson().keys.toSet(), {
      'CreatureID',
      'School',
      'Resistance',
      'VerifiedBuild',
    });
    expect(const CreatureTemplateSpellEntity().toJson().keys.toSet(), {
      'CreatureID',
      'Index',
      'Spell',
      'VerifiedBuild',
    });
    expect(const CreatureEquipTemplateEntity().toJson().keys.toSet(), {
      'CreatureID',
      'ID',
      'ItemID1',
      'ItemID2',
      'ItemID3',
      'VerifiedBuild',
    });
    expect(const CreatureQuestItemEntity().toJson().keys.toSet(), {
      'CreatureEntry',
      'Idx',
      'ItemId',
      'VerifiedBuild',
    });
    expect(const NpcVendorEntity().toJson().keys.toSet(), {
      'entry',
      'slot',
      'item',
      'maxcount',
      'incrtime',
      'ExtendedCost',
      'VerifiedBuild',
    });
    expect(const NpcTrainerEntity().toJson().keys.toSet(), {
      'TrainerId',
      'SpellId',
      'MoneyCost',
      'ReqSkillLine',
      'ReqSkillRank',
      'ReqAbility1',
      'ReqAbility2',
      'ReqAbility3',
      'ReqLevel',
      'VerifiedBuild',
    });
    expect(const CreatureDefaultTrainerEntity().toJson().keys.toSet(), {
      'CreatureId',
      'TrainerId',
    });
    expect(const LootTemplateEntity().toJson().keys.toSet(), {
      'Entry',
      'Item',
      'Reference',
      'Chance',
      'QuestRequired',
      'LootMode',
      'GroupId',
      'MinCount',
      'MaxCount',
      'Comment',
    });
  });

  test('关联表复合主键与 AzerothCore SQL 一致', () {
    expect(NpcVendorRepository.primaryKeyColumns, {
      'entry',
      'item',
      'ExtendedCost',
    });
    expect(NpcTrainerRepository.primaryKeyColumns, {'TrainerId', 'SpellId'});
    expect(
      LootTemplateRepository.primaryKeyColumnsFor(LootTableType.creature),
      {'Entry', 'Item', 'Reference', 'GroupId'},
    );
    expect(
      LootTemplateRepository.primaryKeyColumnsFor(LootTableType.pickpocket),
      {'Entry', 'Item'},
    );
    expect(
      LootTemplateRepository.primaryKeyColumnsFor(LootTableType.skinning),
      {'Entry', 'Item'},
    );
  });

  test('掉落新增项不为 Item 外键自动造号', () async {
    final repository = LootTemplateRepository(LootTableType.creature);
    final loot = await repository.createLootTemplate(123);
    expect(loot.entry, 123);
    expect(loot.item, 0);
  });

  test('光环列表按服务端空格语法规范化并拒绝无效值', () {
    expect(
      CreatureTemplateAddonEntity.normalizeAuras('  123   456 '),
      '123 456',
    );
    expect(
      () => CreatureTemplateAddonEntity.normalizeAuras('123 123'),
      throwsFormatException,
    );
    expect(
      () => CreatureTemplateAddonEntity.normalizeAuras('123 abc'),
      throwsFormatException,
    );
  });

  test('掉落实体拒绝服务端会跳过或修正的值', () {
    expect(
      () => const LootTemplateEntity(lootMode: 0).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(groupId: 128).validate(),
      throwsRangeError,
    );
    expect(
      () => const LootTemplateEntity(minCount: 2, maxCount: 1).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(chance: 0, groupId: 0).validate(),
      throwsStateError,
    );
    expect(
      () => const LootTemplateEntity(item: 1, chance: 100).validate(),
      returnsNormally,
    );
  });

  test('装备模板 Item.dbc Picker 只允许服务端可持握位置', () {
    expect(DbcItemRepository.handEquippableInventoryTypes.toSet(), {
      13,
      14,
      15,
      17,
      21,
      22,
      23,
      25,
      26,
    });
  });

  test('抗性学校与技能槽只分配服务端支持的空缺值', () {
    expect(
      CreatureTemplateResistanceRepository.nextAvailableSchool({1, 3, 4}),
      2,
    );
    expect(
      () => CreatureTemplateResistanceRepository.nextAvailableSchool({
        1,
        2,
        3,
        4,
        5,
        6,
      }),
      throwsStateError,
    );
    expect(CreatureTemplateSpellRepository.nextAvailableIndex({0, 1, 3}), 2);
    expect(
      () => CreatureTemplateSpellRepository.nextAvailableIndex({
        for (var index = 0; index <= 7; index++) index,
      }),
      throwsStateError,
    );
    expect(
      () => CreatureTemplateResistanceRepository.validateSchool(0),
      throwsArgumentError,
    );
    expect(
      () => CreatureTemplateSpellRepository.validateIndex(8),
      throwsArgumentError,
    );
  });

  test('主记录落库前禁用全部 11 个关联 Tab', () {
    expect(creatureTemplateDisabledTabIndexes(null, 12), {
      for (var index = 1; index < 12; index++) index,
    });
    expect(creatureTemplateDisabledTabIndexes(0, 12), {
      for (var index = 1; index < 12; index++) index,
    });
    expect(creatureTemplateDisabledTabIndexes(1, 12), isEmpty);
  });
}

Set<int> _valuesOf(List<FlagItem> flags) =>
    flags.map((flag) => flag.value).toSet();

Set<int> _bits(int first, int last) => {
  for (var bit = first; bit <= last; bit++) 1 << bit,
};
