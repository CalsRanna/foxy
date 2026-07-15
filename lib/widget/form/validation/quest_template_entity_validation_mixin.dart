import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin QuestTemplateValidationMixin on ViewModelValidationMixin {
  void validateQuestTemplateFields(QuestTemplateEntity value) {
    final questType = value.questType;
    final rewardXpDifficulty = value.rewardXpDifficulty;
    final rewardMoneyDifficulty = value.rewardMoneyDifficulty;
    final flags = value.flags;
    final rewardItem1 = value.rewardItem1;
    final rewardAmount1 = value.rewardAmount1;
    final rewardItem2 = value.rewardItem2;
    final rewardAmount2 = value.rewardAmount2;
    final rewardItem3 = value.rewardItem3;
    final rewardAmount3 = value.rewardAmount3;
    final rewardItem4 = value.rewardItem4;
    final rewardAmount4 = value.rewardAmount4;
    final itemDrop1 = value.itemDrop1;
    final itemDropQuantity1 = value.itemDropQuantity1;
    final itemDrop2 = value.itemDrop2;
    final itemDropQuantity2 = value.itemDropQuantity2;
    final itemDrop3 = value.itemDrop3;
    final itemDropQuantity3 = value.itemDropQuantity3;
    final itemDrop4 = value.itemDrop4;
    final itemDropQuantity4 = value.itemDropQuantity4;
    final rewardChoiceItemId1 = value.rewardChoiceItemId1;
    final rewardChoiceItemQuantity1 = value.rewardChoiceItemQuantity1;
    final rewardChoiceItemId2 = value.rewardChoiceItemId2;
    final rewardChoiceItemQuantity2 = value.rewardChoiceItemQuantity2;
    final rewardChoiceItemId3 = value.rewardChoiceItemId3;
    final rewardChoiceItemQuantity3 = value.rewardChoiceItemQuantity3;
    final rewardChoiceItemId4 = value.rewardChoiceItemId4;
    final rewardChoiceItemQuantity4 = value.rewardChoiceItemQuantity4;
    final rewardChoiceItemId5 = value.rewardChoiceItemId5;
    final rewardChoiceItemQuantity5 = value.rewardChoiceItemQuantity5;
    final rewardChoiceItemId6 = value.rewardChoiceItemId6;
    final rewardChoiceItemQuantity6 = value.rewardChoiceItemQuantity6;
    final rewardFactionId1 = value.rewardFactionId1;
    final rewardFactionValue1 = value.rewardFactionValue1;
    final rewardFactionOverride1 = value.rewardFactionOverride1;
    final rewardFactionId2 = value.rewardFactionId2;
    final rewardFactionValue2 = value.rewardFactionValue2;
    final rewardFactionOverride2 = value.rewardFactionOverride2;
    final rewardFactionId3 = value.rewardFactionId3;
    final rewardFactionValue3 = value.rewardFactionValue3;
    final rewardFactionOverride3 = value.rewardFactionOverride3;
    final rewardFactionId4 = value.rewardFactionId4;
    final rewardFactionValue4 = value.rewardFactionValue4;
    final rewardFactionOverride4 = value.rewardFactionOverride4;
    final rewardFactionId5 = value.rewardFactionId5;
    final rewardFactionValue5 = value.rewardFactionValue5;
    final rewardFactionOverride5 = value.rewardFactionOverride5;
    final requiredNpcOrGo1 = value.requiredNpcOrGo1;
    final requiredNpcOrGo2 = value.requiredNpcOrGo2;
    final requiredNpcOrGo3 = value.requiredNpcOrGo3;
    final requiredNpcOrGo4 = value.requiredNpcOrGo4;
    final requiredNpcOrGoCount1 = value.requiredNpcOrGoCount1;
    final requiredNpcOrGoCount2 = value.requiredNpcOrGoCount2;
    final requiredNpcOrGoCount3 = value.requiredNpcOrGoCount3;
    final requiredNpcOrGoCount4 = value.requiredNpcOrGoCount4;
    final requiredItemId1 = value.requiredItemId1;
    final requiredItemId2 = value.requiredItemId2;
    final requiredItemId3 = value.requiredItemId3;
    final requiredItemId4 = value.requiredItemId4;
    final requiredItemId5 = value.requiredItemId5;
    final requiredItemId6 = value.requiredItemId6;
    final requiredItemCount1 = value.requiredItemCount1;
    final requiredItemCount2 = value.requiredItemCount2;
    final requiredItemCount3 = value.requiredItemCount3;
    final requiredItemCount4 = value.requiredItemCount4;
    final requiredItemCount5 = value.requiredItemCount5;
    final requiredItemCount6 = value.requiredItemCount6;

    void validatePair(String field, int id, int count) {
      if ((id == 0) != (count == 0)) {
        throw ArgumentError('$field 与对应数量必须同时为 0 或同时非 0');
      }
    }

    void validateOptionalCount(String field, int id, int count) {
      if (id == 0 && count != 0) {
        throw ArgumentError('$field 为 0 时对应数量也必须为 0');
      }
    }

    void validateRewardFaction(
      String field,
      int factionId,
      int value,
      int override,
    ) {
      if (factionId != 0 && (value < -9 || value > 9)) {
        throw ArgumentError('$field 的声望值索引必须在 -9 到 9 之间');
      }
      if (factionId == 0 && override != 0) {
        throw ArgumentError('$field 的阵营为 0 时不能设置声望覆盖值');
      }
    }

    if (questType < 0 || questType > 2) {
      throw ArgumentError.value(questType, 'QuestType', '只允许 0、1、2');
    }
    if (rewardXpDifficulty < 0 || rewardXpDifficulty >= 10) {
      throw ArgumentError.value(
        rewardXpDifficulty,
        'RewardXPDifficulty',
        '必须在 0 到 9 之间',
      );
    }
    if (rewardMoneyDifficulty < 0 || rewardMoneyDifficulty >= 10) {
      throw ArgumentError.value(
        rewardMoneyDifficulty,
        'RewardMoneyDifficulty',
        '必须在 0 到 9 之间',
      );
    }
    if ((flags & ~0x000FFFFF) != 0) {
      throw ArgumentError.value(flags, 'Flags', '包含 3.3.5a 未定义的标志位');
    }
    if ((flags & 0x00001000) != 0 && (flags & 0x00008000) != 0) {
      throw ArgumentError('Flags 不能同时包含日常和每周标志');
    }
    validatePair('RewardItem1', rewardItem1, rewardAmount1);
    validatePair('RewardItem2', rewardItem2, rewardAmount2);
    validatePair('RewardItem3', rewardItem3, rewardAmount3);
    validatePair('RewardItem4', rewardItem4, rewardAmount4);
    validateOptionalCount('ItemDrop1', itemDrop1, itemDropQuantity1);
    validateOptionalCount('ItemDrop2', itemDrop2, itemDropQuantity2);
    validateOptionalCount('ItemDrop3', itemDrop3, itemDropQuantity3);
    validateOptionalCount('ItemDrop4', itemDrop4, itemDropQuantity4);
    validatePair(
      'RewardChoiceItemID1',
      rewardChoiceItemId1,
      rewardChoiceItemQuantity1,
    );
    validatePair(
      'RewardChoiceItemID2',
      rewardChoiceItemId2,
      rewardChoiceItemQuantity2,
    );
    validatePair(
      'RewardChoiceItemID3',
      rewardChoiceItemId3,
      rewardChoiceItemQuantity3,
    );
    validatePair(
      'RewardChoiceItemID4',
      rewardChoiceItemId4,
      rewardChoiceItemQuantity4,
    );
    validatePair(
      'RewardChoiceItemID5',
      rewardChoiceItemId5,
      rewardChoiceItemQuantity5,
    );
    validatePair(
      'RewardChoiceItemID6',
      rewardChoiceItemId6,
      rewardChoiceItemQuantity6,
    );
    validatePair('RequiredNpcOrGo1', requiredNpcOrGo1, requiredNpcOrGoCount1);
    validatePair('RequiredNpcOrGo2', requiredNpcOrGo2, requiredNpcOrGoCount2);
    validatePair('RequiredNpcOrGo3', requiredNpcOrGo3, requiredNpcOrGoCount3);
    validatePair('RequiredNpcOrGo4', requiredNpcOrGo4, requiredNpcOrGoCount4);
    validatePair('RequiredItemId1', requiredItemId1, requiredItemCount1);
    validatePair('RequiredItemId2', requiredItemId2, requiredItemCount2);
    validatePair('RequiredItemId3', requiredItemId3, requiredItemCount3);
    validatePair('RequiredItemId4', requiredItemId4, requiredItemCount4);
    validatePair('RequiredItemId5', requiredItemId5, requiredItemCount5);
    validatePair('RequiredItemId6', requiredItemId6, requiredItemCount6);
    if (rewardItem1 == 0 &&
        (rewardItem2 != 0 || rewardItem3 != 0 || rewardItem4 != 0)) {
      throw ArgumentError('固定奖励物品槽位必须从 RewardItem1 连续填写');
    }
    if (rewardItem2 == 0 && (rewardItem3 != 0 || rewardItem4 != 0)) {
      throw ArgumentError('固定奖励物品槽位必须从 RewardItem1 连续填写');
    }
    if (rewardItem3 == 0 && rewardItem4 != 0) {
      throw ArgumentError('固定奖励物品槽位必须从 RewardItem1 连续填写');
    }
    validateRewardFaction(
      'RewardFaction1',
      rewardFactionId1,
      rewardFactionValue1,
      rewardFactionOverride1,
    );
    validateRewardFaction(
      'RewardFaction2',
      rewardFactionId2,
      rewardFactionValue2,
      rewardFactionOverride2,
    );
    validateRewardFaction(
      'RewardFaction3',
      rewardFactionId3,
      rewardFactionValue3,
      rewardFactionOverride3,
    );
    validateRewardFaction(
      'RewardFaction4',
      rewardFactionId4,
      rewardFactionValue4,
      rewardFactionOverride4,
    );
    validateRewardFaction(
      'RewardFaction5',
      rewardFactionId5,
      rewardFactionValue5,
      rewardFactionOverride5,
    );
  }
}
