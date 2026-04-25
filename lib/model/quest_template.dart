// QuestTemplate 模型
//
// BriefQuestTemplate — 列表展示用的精简模型，fromJson 兼容 LEFT JOIN
// quest_template_locale 的附加字段（localeTitle），displayTitle getter 优先
// locale > 英文。
// QuestTemplate — 全字段模型（104 字段），用于详情页编辑，fromJson / toJson
// 保留 DB 列名大小写。

class BriefQuestTemplate {
  int id = 0;
  String logTitle = '';
  // 来自 LEFT JOIN quest_template_locale
  String localeTitle = '';
  String questDescription = '';
  // 来自 LEFT JOIN quest_template_locale
  String localeDetails = '';
  int questType = 2;
  int questLevel = 1;
  int minLevel = 0;

  BriefQuestTemplate();

  BriefQuestTemplate.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    logTitle = json['LogTitle']?.toString() ?? '';
    localeTitle = json['Title']?.toString() ?? '';
    questDescription = json['QuestDescription']?.toString() ?? '';
    localeDetails = json['Details']?.toString() ?? '';
    questType = json['QuestType'] ?? 2;
    questLevel = json['QuestLevel'] ?? 1;
    minLevel = json['MinLevel'] ?? 0;
  }

  /// 优先本地化标题 > 英文标题
  String get displayTitle =>
      localeTitle.isNotEmpty ? localeTitle : logTitle;

  /// 优先本地化描述 > 英文描述
  String get displayDescription =>
      localeDetails.isNotEmpty ? localeDetails : questDescription;
}

class QuestTemplate {
  int id = 0;
  int questType = 2;
  int questLevel = 1;
  int minLevel = 0;
  int questSortId = 0;
  int questInfoId = 0;
  int suggestedGroupNum = 0;
  int requiredFactionId1 = 0;
  int requiredFactionId2 = 0;
  int requiredFactionValue1 = 0;
  int requiredFactionValue2 = 0;
  int rewardNextQuest = 0;
  int rewardXpDifficulty = 0;
  int rewardMoney = 0;
  int rewardMoneyDifficulty = 0;
  int rewardDisplaySpell = 0;
  int rewardSpell = 0;
  int rewardHonor = 0;
  double rewardKillHonor = 0;
  int startItem = 0;
  int flags = 0;
  int requiredPlayerKills = 0;
  int rewardItem1 = 0;
  int rewardAmount1 = 0;
  int rewardItem2 = 0;
  int rewardAmount2 = 0;
  int rewardItem3 = 0;
  int rewardAmount3 = 0;
  int rewardItem4 = 0;
  int rewardAmount4 = 0;
  int itemDrop1 = 0;
  int itemDropQuantity1 = 0;
  int itemDrop2 = 0;
  int itemDropQuantity2 = 0;
  int itemDrop3 = 0;
  int itemDropQuantity3 = 0;
  int itemDrop4 = 0;
  int itemDropQuantity4 = 0;
  int rewardChoiceItemId1 = 0;
  int rewardChoiceItemQuantity1 = 0;
  int rewardChoiceItemId2 = 0;
  int rewardChoiceItemQuantity2 = 0;
  int rewardChoiceItemId3 = 0;
  int rewardChoiceItemQuantity3 = 0;
  int rewardChoiceItemId4 = 0;
  int rewardChoiceItemQuantity4 = 0;
  int rewardChoiceItemId5 = 0;
  int rewardChoiceItemQuantity5 = 0;
  int rewardChoiceItemId6 = 0;
  int rewardChoiceItemQuantity6 = 0;
  int poiContinent = 0;
  double poiX = 0;
  double poiY = 0;
  int poiPriority = 0;
  int rewardTitle = 0;
  int rewardTalents = 0;
  int rewardArenaPoints = 0;
  int rewardFactionId1 = 0;
  int rewardFactionValue1 = 0;
  int rewardFactionOverride1 = 0;
  int rewardFactionId2 = 0;
  int rewardFactionValue2 = 0;
  int rewardFactionOverride2 = 0;
  int rewardFactionId3 = 0;
  int rewardFactionValue3 = 0;
  int rewardFactionOverride3 = 0;
  int rewardFactionId4 = 0;
  int rewardFactionValue4 = 0;
  int rewardFactionOverride4 = 0;
  int rewardFactionId5 = 0;
  int rewardFactionValue5 = 0;
  int rewardFactionOverride5 = 0;
  int timeAllowed = 0;
  int allowableRaces = 0;
  String logTitle = '';
  String logDescription = '';
  String questDescription = '';
  String areaDescription = '';
  String questCompletionLog = '';
  int requiredNpcOrGo1 = 0;
  int requiredNpcOrGo2 = 0;
  int requiredNpcOrGo3 = 0;
  int requiredNpcOrGo4 = 0;
  int requiredNpcOrGoCount1 = 0;
  int requiredNpcOrGoCount2 = 0;
  int requiredNpcOrGoCount3 = 0;
  int requiredNpcOrGoCount4 = 0;
  int requiredItemId1 = 0;
  int requiredItemId2 = 0;
  int requiredItemId3 = 0;
  int requiredItemId4 = 0;
  int requiredItemId5 = 0;
  int requiredItemId6 = 0;
  int requiredItemCount1 = 0;
  int requiredItemCount2 = 0;
  int requiredItemCount3 = 0;
  int requiredItemCount4 = 0;
  int requiredItemCount5 = 0;
  int requiredItemCount6 = 0;
  int unknown0 = 0;
  String objectiveText1 = '';
  String objectiveText2 = '';
  String objectiveText3 = '';
  String objectiveText4 = '';
  int? verifiedBuild;

  QuestTemplate();

  QuestTemplate.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    questType = json['QuestType'] ?? 2;
    questLevel = json['QuestLevel'] ?? 1;
    minLevel = json['MinLevel'] ?? 0;
    questSortId = json['QuestSortID'] ?? 0;
    questInfoId = json['QuestInfoID'] ?? 0;
    suggestedGroupNum = json['SuggestedGroupNum'] ?? 0;
    requiredFactionId1 = json['RequiredFactionId1'] ?? 0;
    requiredFactionId2 = json['RequiredFactionId2'] ?? 0;
    requiredFactionValue1 = json['RequiredFactionValue1'] ?? 0;
    requiredFactionValue2 = json['RequiredFactionValue2'] ?? 0;
    rewardNextQuest = json['RewardNextQuest'] ?? 0;
    rewardXpDifficulty = json['RewardXPDifficulty'] ?? 0;
    rewardMoney = json['RewardMoney'] ?? 0;
    rewardMoneyDifficulty = json['RewardMoneyDifficulty'] ?? 0;
    rewardDisplaySpell = json['RewardDisplaySpell'] ?? 0;
    rewardSpell = json['RewardSpell'] ?? 0;
    rewardHonor = json['RewardHonor'] ?? 0;
    rewardKillHonor = json['RewardKillHonor'] ?? 0;
    startItem = json['StartItem'] ?? 0;
    flags = json['Flags'] ?? 0;
    requiredPlayerKills = json['RequiredPlayerKills'] ?? 0;
    rewardItem1 = json['RewardItem1'] ?? 0;
    rewardAmount1 = json['RewardAmount1'] ?? 0;
    rewardItem2 = json['RewardItem2'] ?? 0;
    rewardAmount2 = json['RewardAmount2'] ?? 0;
    rewardItem3 = json['RewardItem3'] ?? 0;
    rewardAmount3 = json['RewardAmount3'] ?? 0;
    rewardItem4 = json['RewardItem4'] ?? 0;
    rewardAmount4 = json['RewardAmount4'] ?? 0;
    itemDrop1 = json['ItemDrop1'] ?? 0;
    itemDropQuantity1 = json['ItemDropQuantity1'] ?? 0;
    itemDrop2 = json['ItemDrop2'] ?? 0;
    itemDropQuantity2 = json['ItemDropQuantity2'] ?? 0;
    itemDrop3 = json['ItemDrop3'] ?? 0;
    itemDropQuantity3 = json['ItemDropQuantity3'] ?? 0;
    itemDrop4 = json['ItemDrop4'] ?? 0;
    itemDropQuantity4 = json['ItemDropQuantity4'] ?? 0;
    rewardChoiceItemId1 = json['RewardChoiceItemID1'] ?? 0;
    rewardChoiceItemQuantity1 = json['RewardChoiceItemQuantity1'] ?? 0;
    rewardChoiceItemId2 = json['RewardChoiceItemID2'] ?? 0;
    rewardChoiceItemQuantity2 = json['RewardChoiceItemQuantity2'] ?? 0;
    rewardChoiceItemId3 = json['RewardChoiceItemID3'] ?? 0;
    rewardChoiceItemQuantity3 = json['RewardChoiceItemQuantity3'] ?? 0;
    rewardChoiceItemId4 = json['RewardChoiceItemID4'] ?? 0;
    rewardChoiceItemQuantity4 = json['RewardChoiceItemQuantity4'] ?? 0;
    rewardChoiceItemId5 = json['RewardChoiceItemID5'] ?? 0;
    rewardChoiceItemQuantity5 = json['RewardChoiceItemQuantity5'] ?? 0;
    rewardChoiceItemId6 = json['RewardChoiceItemID6'] ?? 0;
    rewardChoiceItemQuantity6 = json['RewardChoiceItemQuantity6'] ?? 0;
    poiContinent = json['POIContinent'] ?? 0;
    poiX = json['POIx'] ?? 0;
    poiY = json['POIy'] ?? 0;
    poiPriority = json['POIPriority'] ?? 0;
    rewardTitle = json['RewardTitle'] ?? 0;
    rewardTalents = json['RewardTalents'] ?? 0;
    rewardArenaPoints = json['RewardArenaPoints'] ?? 0;
    rewardFactionId1 = json['RewardFactionID1'] ?? 0;
    rewardFactionValue1 = json['RewardFactionValue1'] ?? 0;
    rewardFactionOverride1 = json['RewardFactionOverride1'] ?? 0;
    rewardFactionId2 = json['RewardFactionID2'] ?? 0;
    rewardFactionValue2 = json['RewardFactionValue2'] ?? 0;
    rewardFactionOverride2 = json['RewardFactionOverride2'] ?? 0;
    rewardFactionId3 = json['RewardFactionID3'] ?? 0;
    rewardFactionValue3 = json['RewardFactionValue3'] ?? 0;
    rewardFactionOverride3 = json['RewardFactionOverride3'] ?? 0;
    rewardFactionId4 = json['RewardFactionID4'] ?? 0;
    rewardFactionValue4 = json['RewardFactionValue4'] ?? 0;
    rewardFactionOverride4 = json['RewardFactionOverride4'] ?? 0;
    rewardFactionId5 = json['RewardFactionID5'] ?? 0;
    rewardFactionValue5 = json['RewardFactionValue5'] ?? 0;
    rewardFactionOverride5 = json['RewardFactionOverride5'] ?? 0;
    timeAllowed = json['TimeAllowed'] ?? 0;
    allowableRaces = json['AllowableRaces'] ?? 0;
    logTitle = json['LogTitle']?.toString() ?? '';
    logDescription = json['LogDescription']?.toString() ?? '';
    questDescription = json['QuestDescription']?.toString() ?? '';
    areaDescription = json['AreaDescription']?.toString() ?? '';
    questCompletionLog = json['QuestCompletionLog']?.toString() ?? '';
    requiredNpcOrGo1 = json['RequiredNpcOrGo1'] ?? 0;
    requiredNpcOrGo2 = json['RequiredNpcOrGo2'] ?? 0;
    requiredNpcOrGo3 = json['RequiredNpcOrGo3'] ?? 0;
    requiredNpcOrGo4 = json['RequiredNpcOrGo4'] ?? 0;
    requiredNpcOrGoCount1 = json['RequiredNpcOrGoCount1'] ?? 0;
    requiredNpcOrGoCount2 = json['RequiredNpcOrGoCount2'] ?? 0;
    requiredNpcOrGoCount3 = json['RequiredNpcOrGoCount3'] ?? 0;
    requiredNpcOrGoCount4 = json['RequiredNpcOrGoCount4'] ?? 0;
    requiredItemId1 = json['RequiredItemId1'] ?? 0;
    requiredItemId2 = json['RequiredItemId2'] ?? 0;
    requiredItemId3 = json['RequiredItemId3'] ?? 0;
    requiredItemId4 = json['RequiredItemId4'] ?? 0;
    requiredItemId5 = json['RequiredItemId5'] ?? 0;
    requiredItemId6 = json['RequiredItemId6'] ?? 0;
    requiredItemCount1 = json['RequiredItemCount1'] ?? 0;
    requiredItemCount2 = json['RequiredItemCount2'] ?? 0;
    requiredItemCount3 = json['RequiredItemCount3'] ?? 0;
    requiredItemCount4 = json['RequiredItemCount4'] ?? 0;
    requiredItemCount5 = json['RequiredItemCount5'] ?? 0;
    requiredItemCount6 = json['RequiredItemCount6'] ?? 0;
    unknown0 = json['Unknown0'] ?? 0;
    objectiveText1 = json['ObjectiveText1']?.toString() ?? '';
    objectiveText2 = json['ObjectiveText2']?.toString() ?? '';
    objectiveText3 = json['ObjectiveText3']?.toString() ?? '';
    objectiveText4 = json['ObjectiveText4']?.toString() ?? '';
    verifiedBuild = json['VerifiedBuild'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'QuestType': questType,
      'QuestLevel': questLevel,
      'MinLevel': minLevel,
      'QuestSortID': questSortId,
      'QuestInfoID': questInfoId,
      'SuggestedGroupNum': suggestedGroupNum,
      'RequiredFactionId1': requiredFactionId1,
      'RequiredFactionId2': requiredFactionId2,
      'RequiredFactionValue1': requiredFactionValue1,
      'RequiredFactionValue2': requiredFactionValue2,
      'RewardNextQuest': rewardNextQuest,
      'RewardXPDifficulty': rewardXpDifficulty,
      'RewardMoney': rewardMoney,
      'RewardMoneyDifficulty': rewardMoneyDifficulty,
      'RewardDisplaySpell': rewardDisplaySpell,
      'RewardSpell': rewardSpell,
      'RewardHonor': rewardHonor,
      'RewardKillHonor': rewardKillHonor,
      'StartItem': startItem,
      'Flags': flags,
      'RequiredPlayerKills': requiredPlayerKills,
      'RewardItem1': rewardItem1,
      'RewardAmount1': rewardAmount1,
      'RewardItem2': rewardItem2,
      'RewardAmount2': rewardAmount2,
      'RewardItem3': rewardItem3,
      'RewardAmount3': rewardAmount3,
      'RewardItem4': rewardItem4,
      'RewardAmount4': rewardAmount4,
      'ItemDrop1': itemDrop1,
      'ItemDropQuantity1': itemDropQuantity1,
      'ItemDrop2': itemDrop2,
      'ItemDropQuantity2': itemDropQuantity2,
      'ItemDrop3': itemDrop3,
      'ItemDropQuantity3': itemDropQuantity3,
      'ItemDrop4': itemDrop4,
      'ItemDropQuantity4': itemDropQuantity4,
      'RewardChoiceItemID1': rewardChoiceItemId1,
      'RewardChoiceItemQuantity1': rewardChoiceItemQuantity1,
      'RewardChoiceItemID2': rewardChoiceItemId2,
      'RewardChoiceItemQuantity2': rewardChoiceItemQuantity2,
      'RewardChoiceItemID3': rewardChoiceItemId3,
      'RewardChoiceItemQuantity3': rewardChoiceItemQuantity3,
      'RewardChoiceItemID4': rewardChoiceItemId4,
      'RewardChoiceItemQuantity4': rewardChoiceItemQuantity4,
      'RewardChoiceItemID5': rewardChoiceItemId5,
      'RewardChoiceItemQuantity5': rewardChoiceItemQuantity5,
      'RewardChoiceItemID6': rewardChoiceItemId6,
      'RewardChoiceItemQuantity6': rewardChoiceItemQuantity6,
      'POIContinent': poiContinent,
      'POIx': poiX,
      'POIy': poiY,
      'POIPriority': poiPriority,
      'RewardTitle': rewardTitle,
      'RewardTalents': rewardTalents,
      'RewardArenaPoints': rewardArenaPoints,
      'RewardFactionID1': rewardFactionId1,
      'RewardFactionValue1': rewardFactionValue1,
      'RewardFactionOverride1': rewardFactionOverride1,
      'RewardFactionID2': rewardFactionId2,
      'RewardFactionValue2': rewardFactionValue2,
      'RewardFactionOverride2': rewardFactionOverride2,
      'RewardFactionID3': rewardFactionId3,
      'RewardFactionValue3': rewardFactionValue3,
      'RewardFactionOverride3': rewardFactionOverride3,
      'RewardFactionID4': rewardFactionId4,
      'RewardFactionValue4': rewardFactionValue4,
      'RewardFactionOverride4': rewardFactionOverride4,
      'RewardFactionID5': rewardFactionId5,
      'RewardFactionValue5': rewardFactionValue5,
      'RewardFactionOverride5': rewardFactionOverride5,
      'TimeAllowed': timeAllowed,
      'AllowableRaces': allowableRaces,
      'LogTitle': logTitle,
      'LogDescription': logDescription,
      'QuestDescription': questDescription,
      'AreaDescription': areaDescription,
      'QuestCompletionLog': questCompletionLog,
      'RequiredNpcOrGo1': requiredNpcOrGo1,
      'RequiredNpcOrGo2': requiredNpcOrGo2,
      'RequiredNpcOrGo3': requiredNpcOrGo3,
      'RequiredNpcOrGo4': requiredNpcOrGo4,
      'RequiredNpcOrGoCount1': requiredNpcOrGoCount1,
      'RequiredNpcOrGoCount2': requiredNpcOrGoCount2,
      'RequiredNpcOrGoCount3': requiredNpcOrGoCount3,
      'RequiredNpcOrGoCount4': requiredNpcOrGoCount4,
      'RequiredItemId1': requiredItemId1,
      'RequiredItemId2': requiredItemId2,
      'RequiredItemId3': requiredItemId3,
      'RequiredItemId4': requiredItemId4,
      'RequiredItemId5': requiredItemId5,
      'RequiredItemId6': requiredItemId6,
      'RequiredItemCount1': requiredItemCount1,
      'RequiredItemCount2': requiredItemCount2,
      'RequiredItemCount3': requiredItemCount3,
      'RequiredItemCount4': requiredItemCount4,
      'RequiredItemCount5': requiredItemCount5,
      'RequiredItemCount6': requiredItemCount6,
      'Unknown0': unknown0,
      'ObjectiveText1': objectiveText1,
      'ObjectiveText2': objectiveText2,
      'ObjectiveText3': objectiveText3,
      'ObjectiveText4': objectiveText4,
      'VerifiedBuild': verifiedBuild,
    };
  }
}