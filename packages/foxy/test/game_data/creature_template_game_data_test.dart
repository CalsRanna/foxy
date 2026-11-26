import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_default_trainer_entity.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/page/creature_template/creature_template_detail_page.dart';
import 'package:foxy/repository/creature_loot_template_repository.dart';
import 'package:foxy/repository/creature_template_resistance_repository.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/repository/dbc_item_repository.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/repository/pickpocketing_loot_template_repository.dart';
import 'package:foxy/repository/skinning_loot_template_repository.dart';

void main() {
  test('Entities for all 11 related tabs serialize the target SQL columns', () {
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
    expect(const CreatureLootTemplateEntity().toJson().keys.toSet(), {
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

  test(
    'Related tables use the same composite primary keys as AzerothCore SQL',
    () {
      expect(NpcVendorRepository.primaryKeyColumns, {
        'entry',
        'item',
        'ExtendedCost',
      });
      expect(NpcTrainerRepository.primaryKeyColumns, {'TrainerId', 'SpellId'});
      expect(CreatureLootTemplateRepository.primaryKeyColumns, {
        'Entry',
        'Item',
        'Reference',
        'GroupId',
      });
      expect(PickpocketingLootTemplateRepository.primaryKeyColumns, {
        'Entry',
        'Item',
      });
      expect(SkinningLootTemplateRepository.primaryKeyColumns, {
        'Entry',
        'Item',
      });
    },
  );

  test('New loot rows do not auto-assign an item foreign key', () async {
    final repository = CreatureLootTemplateRepository();
    final loot = await repository.createCreatureLootTemplate(123);
    expect(loot.entry, 123);
    expect(loot.item, 0);
  });

  test('The equipment template Item.dbc picker allows only server-supported wield slots', () {
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

  test('Resistance schools and spell slots allocate only unused server-supported values', () {
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
      throwsA(isA<ValidationException>()),
    );
    expect(CreatureTemplateSpellRepository.nextAvailableIndex({0, 1, 3}), 2);
    expect(
      () => CreatureTemplateSpellRepository.nextAvailableIndex({
        for (var index = 0; index <= 7; index++) index,
      }),
      throwsA(isA<ValidationException>()),
    );
  });

  test(
    'All 11 related tabs are disabled until the main record is persisted',
    () {
      expect(CreatureTemplateDetailPage.disabledTabIndexes(null, 12), {
        for (var index = 1; index < 12; index++) index,
      });
      expect(CreatureTemplateDetailPage.disabledTabIndexes(0, 12), {
        for (var index = 1; index < 12; index++) index,
      });
      expect(CreatureTemplateDetailPage.disabledTabIndexes(1, 12), isEmpty);
    },
  );
}
