import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/quest_enums.dart';
import 'package:foxy/constant/quest_flags.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/entity/quest_offer_reward_entity.dart';
import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';

const _questTemplateColumns = {
  'ID',
  'QuestType',
  'QuestLevel',
  'MinLevel',
  'QuestSortID',
  'QuestInfoID',
  'SuggestedGroupNum',
  'RequiredFactionId1',
  'RequiredFactionId2',
  'RequiredFactionValue1',
  'RequiredFactionValue2',
  'RewardNextQuest',
  'RewardXPDifficulty',
  'RewardMoney',
  'RewardMoneyDifficulty',
  'RewardDisplaySpell',
  'RewardSpell',
  'RewardHonor',
  'RewardKillHonor',
  'StartItem',
  'Flags',
  'RequiredPlayerKills',
  'RewardItem1',
  'RewardAmount1',
  'RewardItem2',
  'RewardAmount2',
  'RewardItem3',
  'RewardAmount3',
  'RewardItem4',
  'RewardAmount4',
  'ItemDrop1',
  'ItemDropQuantity1',
  'ItemDrop2',
  'ItemDropQuantity2',
  'ItemDrop3',
  'ItemDropQuantity3',
  'ItemDrop4',
  'ItemDropQuantity4',
  'RewardChoiceItemID1',
  'RewardChoiceItemQuantity1',
  'RewardChoiceItemID2',
  'RewardChoiceItemQuantity2',
  'RewardChoiceItemID3',
  'RewardChoiceItemQuantity3',
  'RewardChoiceItemID4',
  'RewardChoiceItemQuantity4',
  'RewardChoiceItemID5',
  'RewardChoiceItemQuantity5',
  'RewardChoiceItemID6',
  'RewardChoiceItemQuantity6',
  'POIContinent',
  'POIx',
  'POIy',
  'POIPriority',
  'RewardTitle',
  'RewardTalents',
  'RewardArenaPoints',
  'RewardFactionID1',
  'RewardFactionValue1',
  'RewardFactionOverride1',
  'RewardFactionID2',
  'RewardFactionValue2',
  'RewardFactionOverride2',
  'RewardFactionID3',
  'RewardFactionValue3',
  'RewardFactionOverride3',
  'RewardFactionID4',
  'RewardFactionValue4',
  'RewardFactionOverride4',
  'RewardFactionID5',
  'RewardFactionValue5',
  'RewardFactionOverride5',
  'TimeAllowed',
  'AllowableRaces',
  'LogTitle',
  'LogDescription',
  'QuestDescription',
  'AreaDescription',
  'QuestCompletionLog',
  'RequiredNpcOrGo1',
  'RequiredNpcOrGo2',
  'RequiredNpcOrGo3',
  'RequiredNpcOrGo4',
  'RequiredNpcOrGoCount1',
  'RequiredNpcOrGoCount2',
  'RequiredNpcOrGoCount3',
  'RequiredNpcOrGoCount4',
  'RequiredItemId1',
  'RequiredItemId2',
  'RequiredItemId3',
  'RequiredItemId4',
  'RequiredItemId5',
  'RequiredItemId6',
  'RequiredItemCount1',
  'RequiredItemCount2',
  'RequiredItemCount3',
  'RequiredItemCount4',
  'RequiredItemCount5',
  'RequiredItemCount6',
  'Unknown0',
  'ObjectiveText1',
  'ObjectiveText2',
  'ObjectiveText3',
  'ObjectiveText4',
  'VerifiedBuild',
};

void main() {
  test('quest_template Entity 精确覆盖 core 的 105 个物理列', () {
    final entity = const QuestTemplateEntity();
    expect(entity.toJson().keys.toSet(), _questTemplateColumns);
    expect(
      QuestTemplateEntity.fromJson(entity.toJson()).toJson(),
      entity.toJson(),
    );
    expect(_questTemplateColumns, hasLength(105));
    expect(entity.questType, 2);
    expect(entity.questLevel, 1);
  });

  test('全部一对一关联 Entity 精确覆盖物理列', () {
    expect(const QuestTemplateAddonEntity().toJson().keys.toSet(), {
      'ID',
      'MaxLevel',
      'AllowableClasses',
      'SourceSpellID',
      'PrevQuestID',
      'NextQuestID',
      'ExclusiveGroup',
      'BreadcrumbForQuestId',
      'RewardMailTemplateID',
      'RewardMailDelay',
      'RequiredSkillID',
      'RequiredSkillPoints',
      'RequiredMinRepFaction',
      'RequiredMaxRepFaction',
      'RequiredMinRepValue',
      'RequiredMaxRepValue',
      'ProvidedItemCount',
      'SpecialFlags',
    });
    expect(const QuestRequestItemsEntity().toJson().keys.toSet(), {
      'ID',
      'EmoteOnComplete',
      'EmoteOnIncomplete',
      'CompletionText',
      'VerifiedBuild',
    });
    expect(const QuestOfferRewardEntity().toJson().keys.toSet(), {
      'ID',
      'Emote1',
      'Emote2',
      'Emote3',
      'Emote4',
      'EmoteDelay1',
      'EmoteDelay2',
      'EmoteDelay3',
      'EmoteDelay4',
      'RewardText',
      'VerifiedBuild',
    });
    final addon = const QuestTemplateAddonEntity(breadcrumbForQuestId: 12);
    expect(
      QuestTemplateAddonEntity.fromJson(addon.toJson()).toJson(),
      addon.toJson(),
    );
  });

  test('四张起止关系表都使用显式复合键字段', () {
    expect(const CreatureQuestStarterEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const CreatureQuestEnderEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const GameObjectQuestStarterEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
    expect(const GameObjectQuestEnderEntity().toJson().keys.toSet(), {
      'id',
      'quest',
    });
  });

  test('QuestType 使用 Method 值域而不是 QuestTypes 枚举', () {
    expect(kQuestMethodOptions.keys, orderedEquals([0, 1, 2]));
    expect(kQuestMethodOptions, isNot(contains(41)));
    expect(
      kQuestRewardDifficultyOptions.keys,
      orderedEquals(List.generate(10, (i) => i)),
    );
  });

  test('Flags 仅包含 3.3.5a 定义位，SpecialFlags 排除运行时位', () {
    final questMask = kQuestFlagOptions.fold(
      0,
      (mask, flag) => mask | flag.value,
    );
    final specialMask = kQuestSpecialFlagOptions.fold(
      0,
      (mask, flag) => mask | flag.value,
    );
    expect(questMask, kQuestFlagsAllowedMask);
    expect(specialMask, kQuestSpecialFlagsAllowedMask);
    expect(specialMask & 0x3E00, 0);
  });

  test('主表保存约束与 AzerothCore 后处理一致', () {
    expect(
      () => const QuestTemplateEntity(questType: 3).validate(),
      throwsArgumentError,
    );
    expect(
      () => const QuestTemplateEntity(rewardXpDifficulty: 10).validate(),
      throwsArgumentError,
    );
    expect(
      () => const QuestTemplateEntity(
        requiredItemId1: 100,
        requiredItemCount1: 0,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const QuestTemplateEntity(itemDrop1: 100).validate(),
      returnsNormally,
    );
    expect(
      () => const QuestTemplateEntity(flags: 0x00009000).validate(),
      throwsArgumentError,
    );
  });

  test('Addon 仅接受 DB SpecialFlags 并校验面包屑互斥字段', () {
    expect(
      () => const QuestTemplateAddonEntity(specialFlags: 0x0200).validate(),
      throwsArgumentError,
    );
    expect(
      () => const QuestTemplateAddonEntity(
        breadcrumbForQuestId: 2,
        nextQuestId: 3,
      ).validate(),
      throwsArgumentError,
    );
  });
}
