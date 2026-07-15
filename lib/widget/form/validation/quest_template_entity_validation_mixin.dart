import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin QuestTemplateValidationMixin on ViewModelValidationMixin {
  void validateQuestTemplateFields(QuestTemplateEntity value) =>
      value._validateFields();
}

extension on QuestTemplateEntity {
  void _validateFields() {
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
    _validatePair('RewardItem1', rewardItem1, rewardAmount1);
    _validatePair('RewardItem2', rewardItem2, rewardAmount2);
    _validatePair('RewardItem3', rewardItem3, rewardAmount3);
    _validatePair('RewardItem4', rewardItem4, rewardAmount4);
    _validateOptionalCount('ItemDrop1', itemDrop1, itemDropQuantity1);
    _validateOptionalCount('ItemDrop2', itemDrop2, itemDropQuantity2);
    _validateOptionalCount('ItemDrop3', itemDrop3, itemDropQuantity3);
    _validateOptionalCount('ItemDrop4', itemDrop4, itemDropQuantity4);
    _validatePair(
      'RewardChoiceItemID1',
      rewardChoiceItemId1,
      rewardChoiceItemQuantity1,
    );
    _validatePair(
      'RewardChoiceItemID2',
      rewardChoiceItemId2,
      rewardChoiceItemQuantity2,
    );
    _validatePair(
      'RewardChoiceItemID3',
      rewardChoiceItemId3,
      rewardChoiceItemQuantity3,
    );
    _validatePair(
      'RewardChoiceItemID4',
      rewardChoiceItemId4,
      rewardChoiceItemQuantity4,
    );
    _validatePair(
      'RewardChoiceItemID5',
      rewardChoiceItemId5,
      rewardChoiceItemQuantity5,
    );
    _validatePair(
      'RewardChoiceItemID6',
      rewardChoiceItemId6,
      rewardChoiceItemQuantity6,
    );
    _validatePair('RequiredNpcOrGo1', requiredNpcOrGo1, requiredNpcOrGoCount1);
    _validatePair('RequiredNpcOrGo2', requiredNpcOrGo2, requiredNpcOrGoCount2);
    _validatePair('RequiredNpcOrGo3', requiredNpcOrGo3, requiredNpcOrGoCount3);
    _validatePair('RequiredNpcOrGo4', requiredNpcOrGo4, requiredNpcOrGoCount4);
    _validatePair('RequiredItemId1', requiredItemId1, requiredItemCount1);
    _validatePair('RequiredItemId2', requiredItemId2, requiredItemCount2);
    _validatePair('RequiredItemId3', requiredItemId3, requiredItemCount3);
    _validatePair('RequiredItemId4', requiredItemId4, requiredItemCount4);
    _validatePair('RequiredItemId5', requiredItemId5, requiredItemCount5);
    _validatePair('RequiredItemId6', requiredItemId6, requiredItemCount6);
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
    _validateRewardFaction(
      'RewardFaction1',
      rewardFactionId1,
      rewardFactionValue1,
      rewardFactionOverride1,
    );
    _validateRewardFaction(
      'RewardFaction2',
      rewardFactionId2,
      rewardFactionValue2,
      rewardFactionOverride2,
    );
    _validateRewardFaction(
      'RewardFaction3',
      rewardFactionId3,
      rewardFactionValue3,
      rewardFactionOverride3,
    );
    _validateRewardFaction(
      'RewardFaction4',
      rewardFactionId4,
      rewardFactionValue4,
      rewardFactionOverride4,
    );
    _validateRewardFaction(
      'RewardFaction5',
      rewardFactionId5,
      rewardFactionValue5,
      rewardFactionOverride5,
    );
  }

  void _validatePair(String field, int id, int count) {
    if ((id == 0) != (count == 0)) {
      throw ArgumentError('$field 与对应数量必须同时为 0 或同时非 0');
    }
  }

  void _validateOptionalCount(String field, int id, int count) {
    if (id == 0 && count != 0) {
      throw ArgumentError('$field 为 0 时对应数量也必须为 0');
    }
  }

  void _validateRewardFaction(
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
}
