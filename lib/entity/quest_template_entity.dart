import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'quest_template_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('localeTitle')
@FoxyBriefField.text('localeDetails')
@FoxyFullEntity(table: 'quest_template')
class QuestTemplateEntity with _QuestTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('QuestType')
  final int questType;

  @FoxyBriefField()
  @FoxyFullField('QuestLevel')
  final int questLevel;

  @FoxyBriefField()
  @FoxyFullField('MinLevel')
  final int minLevel;

  @FoxyFullField('QuestSortID')
  final int questSortId;

  @FoxyFullField('QuestInfoID')
  final int questInfoId;

  @FoxyFullField('SuggestedGroupNum')
  final int suggestedGroupNum;

  @FoxyFullField('RequiredFactionId1')
  final int requiredFactionId1;

  @FoxyFullField('RequiredFactionId2')
  final int requiredFactionId2;

  @FoxyFullField('RequiredFactionValue1')
  final int requiredFactionValue1;

  @FoxyFullField('RequiredFactionValue2')
  final int requiredFactionValue2;

  @FoxyFullField('RewardNextQuest')
  final int rewardNextQuest;

  @FoxyFullField('RewardXPDifficulty')
  final int rewardXpDifficulty;

  @FoxyFullField('RewardMoney')
  final int rewardMoney;

  @FoxyFullField('RewardMoneyDifficulty')
  final int rewardMoneyDifficulty;

  @FoxyFullField('RewardDisplaySpell')
  final int rewardDisplaySpell;

  @FoxyFullField('RewardSpell')
  final int rewardSpell;

  @FoxyFullField('RewardHonor')
  final int rewardHonor;

  @FoxyFullField('RewardKillHonor')
  final double rewardKillHonor;

  @FoxyFullField('StartItem')
  final int startItem;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyFullField('RequiredPlayerKills')
  final int requiredPlayerKills;

  @FoxyFullField('RewardItem1')
  final int rewardItem1;

  @FoxyFullField('RewardAmount1')
  final int rewardAmount1;

  @FoxyFullField('RewardItem2')
  final int rewardItem2;

  @FoxyFullField('RewardAmount2')
  final int rewardAmount2;

  @FoxyFullField('RewardItem3')
  final int rewardItem3;

  @FoxyFullField('RewardAmount3')
  final int rewardAmount3;

  @FoxyFullField('RewardItem4')
  final int rewardItem4;

  @FoxyFullField('RewardAmount4')
  final int rewardAmount4;

  @FoxyFullField('ItemDrop1')
  final int itemDrop1;

  @FoxyFullField('ItemDropQuantity1')
  final int itemDropQuantity1;

  @FoxyFullField('ItemDrop2')
  final int itemDrop2;

  @FoxyFullField('ItemDropQuantity2')
  final int itemDropQuantity2;

  @FoxyFullField('ItemDrop3')
  final int itemDrop3;

  @FoxyFullField('ItemDropQuantity3')
  final int itemDropQuantity3;

  @FoxyFullField('ItemDrop4')
  final int itemDrop4;

  @FoxyFullField('ItemDropQuantity4')
  final int itemDropQuantity4;

  @FoxyFullField('RewardChoiceItemID1')
  final int rewardChoiceItemId1;

  @FoxyFullField('RewardChoiceItemQuantity1')
  final int rewardChoiceItemQuantity1;

  @FoxyFullField('RewardChoiceItemID2')
  final int rewardChoiceItemId2;

  @FoxyFullField('RewardChoiceItemQuantity2')
  final int rewardChoiceItemQuantity2;

  @FoxyFullField('RewardChoiceItemID3')
  final int rewardChoiceItemId3;

  @FoxyFullField('RewardChoiceItemQuantity3')
  final int rewardChoiceItemQuantity3;

  @FoxyFullField('RewardChoiceItemID4')
  final int rewardChoiceItemId4;

  @FoxyFullField('RewardChoiceItemQuantity4')
  final int rewardChoiceItemQuantity4;

  @FoxyFullField('RewardChoiceItemID5')
  final int rewardChoiceItemId5;

  @FoxyFullField('RewardChoiceItemQuantity5')
  final int rewardChoiceItemQuantity5;

  @FoxyFullField('RewardChoiceItemID6')
  final int rewardChoiceItemId6;

  @FoxyFullField('RewardChoiceItemQuantity6')
  final int rewardChoiceItemQuantity6;

  @FoxyFullField('POIContinent')
  final int poiContinent;

  @FoxyFullField('POIx')
  final double poiX;

  @FoxyFullField('POIy')
  final double poiY;

  @FoxyFullField('POIPriority')
  final int poiPriority;

  @FoxyFullField('RewardTitle')
  final int rewardTitle;

  @FoxyFullField('RewardTalents')
  final int rewardTalents;

  @FoxyFullField('RewardArenaPoints')
  final int rewardArenaPoints;

  @FoxyFullField('RewardFactionID1')
  final int rewardFactionId1;

  @FoxyFullField('RewardFactionValue1')
  final int rewardFactionValue1;

  @FoxyFullField('RewardFactionOverride1')
  final int rewardFactionOverride1;

  @FoxyFullField('RewardFactionID2')
  final int rewardFactionId2;

  @FoxyFullField('RewardFactionValue2')
  final int rewardFactionValue2;

  @FoxyFullField('RewardFactionOverride2')
  final int rewardFactionOverride2;

  @FoxyFullField('RewardFactionID3')
  final int rewardFactionId3;

  @FoxyFullField('RewardFactionValue3')
  final int rewardFactionValue3;

  @FoxyFullField('RewardFactionOverride3')
  final int rewardFactionOverride3;

  @FoxyFullField('RewardFactionID4')
  final int rewardFactionId4;

  @FoxyFullField('RewardFactionValue4')
  final int rewardFactionValue4;

  @FoxyFullField('RewardFactionOverride4')
  final int rewardFactionOverride4;

  @FoxyFullField('RewardFactionID5')
  final int rewardFactionId5;

  @FoxyFullField('RewardFactionValue5')
  final int rewardFactionValue5;

  @FoxyFullField('RewardFactionOverride5')
  final int rewardFactionOverride5;

  @FoxyFullField('TimeAllowed')
  final int timeAllowed;

  @FoxyFullField('AllowableRaces')
  final int allowableRaces;

  @FoxyBriefField()
  @FoxyFullField('LogTitle')
  final String logTitle;

  @FoxyFullField('LogDescription')
  final String logDescription;

  @FoxyBriefField()
  @FoxyFullField('QuestDescription')
  final String questDescription;

  @FoxyFullField('AreaDescription')
  final String areaDescription;

  @FoxyFullField('QuestCompletionLog')
  final String questCompletionLog;

  @FoxyFullField('RequiredNpcOrGo1')
  final int requiredNpcOrGo1;

  @FoxyFullField('RequiredNpcOrGo2')
  final int requiredNpcOrGo2;

  @FoxyFullField('RequiredNpcOrGo3')
  final int requiredNpcOrGo3;

  @FoxyFullField('RequiredNpcOrGo4')
  final int requiredNpcOrGo4;

  @FoxyFullField('RequiredNpcOrGoCount1')
  final int requiredNpcOrGoCount1;

  @FoxyFullField('RequiredNpcOrGoCount2')
  final int requiredNpcOrGoCount2;

  @FoxyFullField('RequiredNpcOrGoCount3')
  final int requiredNpcOrGoCount3;

  @FoxyFullField('RequiredNpcOrGoCount4')
  final int requiredNpcOrGoCount4;

  @FoxyFullField('RequiredItemId1')
  final int requiredItemId1;

  @FoxyFullField('RequiredItemId2')
  final int requiredItemId2;

  @FoxyFullField('RequiredItemId3')
  final int requiredItemId3;

  @FoxyFullField('RequiredItemId4')
  final int requiredItemId4;

  @FoxyFullField('RequiredItemId5')
  final int requiredItemId5;

  @FoxyFullField('RequiredItemId6')
  final int requiredItemId6;

  @FoxyFullField('RequiredItemCount1')
  final int requiredItemCount1;

  @FoxyFullField('RequiredItemCount2')
  final int requiredItemCount2;

  @FoxyFullField('RequiredItemCount3')
  final int requiredItemCount3;

  @FoxyFullField('RequiredItemCount4')
  final int requiredItemCount4;

  @FoxyFullField('RequiredItemCount5')
  final int requiredItemCount5;

  @FoxyFullField('RequiredItemCount6')
  final int requiredItemCount6;

  @FoxyFullField('Unknown0')
  final int unknown0;

  @FoxyFullField('ObjectiveText1')
  final String objectiveText1;

  @FoxyFullField('ObjectiveText2')
  final String objectiveText2;

  @FoxyFullField('ObjectiveText3')
  final String objectiveText3;

  @FoxyFullField('ObjectiveText4')
  final String objectiveText4;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const QuestTemplateEntity({
    this.id = 0,
    this.questType = 2,
    this.questLevel = 1,
    this.minLevel = 0,
    this.questSortId = 0,
    this.questInfoId = 0,
    this.suggestedGroupNum = 0,
    this.requiredFactionId1 = 0,
    this.requiredFactionId2 = 0,
    this.requiredFactionValue1 = 0,
    this.requiredFactionValue2 = 0,
    this.rewardNextQuest = 0,
    this.rewardXpDifficulty = 0,
    this.rewardMoney = 0,
    this.rewardMoneyDifficulty = 0,
    this.rewardDisplaySpell = 0,
    this.rewardSpell = 0,
    this.rewardHonor = 0,
    this.rewardKillHonor = 0,
    this.startItem = 0,
    this.flags = 0,
    this.requiredPlayerKills = 0,
    this.rewardItem1 = 0,
    this.rewardAmount1 = 0,
    this.rewardItem2 = 0,
    this.rewardAmount2 = 0,
    this.rewardItem3 = 0,
    this.rewardAmount3 = 0,
    this.rewardItem4 = 0,
    this.rewardAmount4 = 0,
    this.itemDrop1 = 0,
    this.itemDropQuantity1 = 0,
    this.itemDrop2 = 0,
    this.itemDropQuantity2 = 0,
    this.itemDrop3 = 0,
    this.itemDropQuantity3 = 0,
    this.itemDrop4 = 0,
    this.itemDropQuantity4 = 0,
    this.rewardChoiceItemId1 = 0,
    this.rewardChoiceItemQuantity1 = 0,
    this.rewardChoiceItemId2 = 0,
    this.rewardChoiceItemQuantity2 = 0,
    this.rewardChoiceItemId3 = 0,
    this.rewardChoiceItemQuantity3 = 0,
    this.rewardChoiceItemId4 = 0,
    this.rewardChoiceItemQuantity4 = 0,
    this.rewardChoiceItemId5 = 0,
    this.rewardChoiceItemQuantity5 = 0,
    this.rewardChoiceItemId6 = 0,
    this.rewardChoiceItemQuantity6 = 0,
    this.poiContinent = 0,
    this.poiX = 0,
    this.poiY = 0,
    this.poiPriority = 0,
    this.rewardTitle = 0,
    this.rewardTalents = 0,
    this.rewardArenaPoints = 0,
    this.rewardFactionId1 = 0,
    this.rewardFactionValue1 = 0,
    this.rewardFactionOverride1 = 0,
    this.rewardFactionId2 = 0,
    this.rewardFactionValue2 = 0,
    this.rewardFactionOverride2 = 0,
    this.rewardFactionId3 = 0,
    this.rewardFactionValue3 = 0,
    this.rewardFactionOverride3 = 0,
    this.rewardFactionId4 = 0,
    this.rewardFactionValue4 = 0,
    this.rewardFactionOverride4 = 0,
    this.rewardFactionId5 = 0,
    this.rewardFactionValue5 = 0,
    this.rewardFactionOverride5 = 0,
    this.timeAllowed = 0,
    this.allowableRaces = 0,
    this.logTitle = '',
    this.logDescription = '',
    this.questDescription = '',
    this.areaDescription = '',
    this.questCompletionLog = '',
    this.requiredNpcOrGo1 = 0,
    this.requiredNpcOrGo2 = 0,
    this.requiredNpcOrGo3 = 0,
    this.requiredNpcOrGo4 = 0,
    this.requiredNpcOrGoCount1 = 0,
    this.requiredNpcOrGoCount2 = 0,
    this.requiredNpcOrGoCount3 = 0,
    this.requiredNpcOrGoCount4 = 0,
    this.requiredItemId1 = 0,
    this.requiredItemId2 = 0,
    this.requiredItemId3 = 0,
    this.requiredItemId4 = 0,
    this.requiredItemId5 = 0,
    this.requiredItemId6 = 0,
    this.requiredItemCount1 = 0,
    this.requiredItemCount2 = 0,
    this.requiredItemCount3 = 0,
    this.requiredItemCount4 = 0,
    this.requiredItemCount5 = 0,
    this.requiredItemCount6 = 0,
    this.unknown0 = 0,
    this.objectiveText1 = '',
    this.objectiveText2 = '',
    this.objectiveText3 = '',
    this.objectiveText4 = '',
    this.verifiedBuild = 0,
  });

  factory QuestTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _QuestTemplateEntityMixin.fromJson(json);
}

extension BriefQuestTemplateEntityDisplay on BriefQuestTemplateEntity {
  String get displayDescription =>
      localeDetails.isNotEmpty ? localeDetails : questDescription;

  String get displayTitle => localeTitle.isNotEmpty ? localeTitle : logTitle;
}
