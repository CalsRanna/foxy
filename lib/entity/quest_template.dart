// QuestTemplate 模型
//
// BriefQuestTemplate — 列表展示用的精简模型，fromJson 兼容 LEFT JOIN
// quest_template_locale 的附加字段（localeTitle），displayTitle getter 优先
// locale > 英文。
// QuestTemplate — 全字段模型（104 字段），用于详情页编辑，fromJson / toJson
// 保留 DB 列名大小写。

class BriefQuestTemplate {
  final int id;
  final String logTitle;
  // 来自 LEFT JOIN quest_template_locale
  final String localeTitle;
  final String questDescription;
  // 来自 LEFT JOIN quest_template_locale
  final String localeDetails;
  final int questType;
  final int questLevel;
  final int minLevel;

  const BriefQuestTemplate({
    this.id = 0,
    this.logTitle = '',
    this.localeTitle = '',
    this.questDescription = '',
    this.localeDetails = '',
    this.questType = 2,
    this.questLevel = 1,
    this.minLevel = 0,
  });

  factory BriefQuestTemplate.fromJson(Map<String, dynamic> json) {
    return BriefQuestTemplate(
      id: json['ID'] ?? json['id'] ?? 0,
      logTitle: json['LogTitle']?.toString() ?? '',
      localeTitle: json['Title']?.toString() ?? '',
      questDescription: json['QuestDescription']?.toString() ?? '',
      localeDetails: json['Details']?.toString() ?? '',
      questType: json['QuestType'] ?? 2,
      questLevel: json['QuestLevel'] ?? 1,
      minLevel: json['MinLevel'] ?? 0,
    );
  }

  /// 优先本地化标题 > 英文标题
  String get displayTitle => localeTitle.isNotEmpty ? localeTitle : logTitle;

  /// 优先本地化描述 > 英文描述
  String get displayDescription =>
      localeDetails.isNotEmpty ? localeDetails : questDescription;

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'LogTitle': logTitle,
      'Title': localeTitle,
      'QuestDescription': questDescription,
      'Details': localeDetails,
      'QuestType': questType,
      'QuestLevel': questLevel,
      'MinLevel': minLevel,
    };
  }
}

class QuestTemplate {
  final int id;
  final int questType;
  final int questLevel;
  final int minLevel;
  final int questSortId;
  final int questInfoId;
  final int suggestedGroupNum;
  final int requiredFactionId1;
  final int requiredFactionId2;
  final int requiredFactionValue1;
  final int requiredFactionValue2;
  final int rewardNextQuest;
  final int rewardXpDifficulty;
  final int rewardMoney;
  final int rewardMoneyDifficulty;
  final int rewardDisplaySpell;
  final int rewardSpell;
  final int rewardHonor;
  final double rewardKillHonor;
  final int startItem;
  final int flags;
  final int requiredPlayerKills;
  final int rewardItem1;
  final int rewardAmount1;
  final int rewardItem2;
  final int rewardAmount2;
  final int rewardItem3;
  final int rewardAmount3;
  final int rewardItem4;
  final int rewardAmount4;
  final int itemDrop1;
  final int itemDropQuantity1;
  final int itemDrop2;
  final int itemDropQuantity2;
  final int itemDrop3;
  final int itemDropQuantity3;
  final int itemDrop4;
  final int itemDropQuantity4;
  final int rewardChoiceItemId1;
  final int rewardChoiceItemQuantity1;
  final int rewardChoiceItemId2;
  final int rewardChoiceItemQuantity2;
  final int rewardChoiceItemId3;
  final int rewardChoiceItemQuantity3;
  final int rewardChoiceItemId4;
  final int rewardChoiceItemQuantity4;
  final int rewardChoiceItemId5;
  final int rewardChoiceItemQuantity5;
  final int rewardChoiceItemId6;
  final int rewardChoiceItemQuantity6;
  final int poiContinent;
  final double poiX;
  final double poiY;
  final int poiPriority;
  final int rewardTitle;
  final int rewardTalents;
  final int rewardArenaPoints;
  final int rewardFactionId1;
  final int rewardFactionValue1;
  final int rewardFactionOverride1;
  final int rewardFactionId2;
  final int rewardFactionValue2;
  final int rewardFactionOverride2;
  final int rewardFactionId3;
  final int rewardFactionValue3;
  final int rewardFactionOverride3;
  final int rewardFactionId4;
  final int rewardFactionValue4;
  final int rewardFactionOverride4;
  final int rewardFactionId5;
  final int rewardFactionValue5;
  final int rewardFactionOverride5;
  final int timeAllowed;
  final int allowableRaces;
  final String logTitle;
  final String logDescription;
  final String questDescription;
  final String areaDescription;
  final String questCompletionLog;
  final int requiredNpcOrGo1;
  final int requiredNpcOrGo2;
  final int requiredNpcOrGo3;
  final int requiredNpcOrGo4;
  final int requiredNpcOrGoCount1;
  final int requiredNpcOrGoCount2;
  final int requiredNpcOrGoCount3;
  final int requiredNpcOrGoCount4;
  final int requiredItemId1;
  final int requiredItemId2;
  final int requiredItemId3;
  final int requiredItemId4;
  final int requiredItemId5;
  final int requiredItemId6;
  final int requiredItemCount1;
  final int requiredItemCount2;
  final int requiredItemCount3;
  final int requiredItemCount4;
  final int requiredItemCount5;
  final int requiredItemCount6;
  final int unknown0;
  final String objectiveText1;
  final String objectiveText2;
  final String objectiveText3;
  final String objectiveText4;
  final int? verifiedBuild;

  const QuestTemplate({
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
    this.verifiedBuild,
  });

  factory QuestTemplate.fromJson(Map<String, dynamic> json) {
    return QuestTemplate(
      id: json['ID'] ?? json['id'] ?? 0,
      questType: json['QuestType'] ?? 2,
      questLevel: json['QuestLevel'] ?? 1,
      minLevel: json['MinLevel'] ?? 0,
      questSortId: json['QuestSortID'] ?? 0,
      questInfoId: json['QuestInfoID'] ?? 0,
      suggestedGroupNum: json['SuggestedGroupNum'] ?? 0,
      requiredFactionId1: json['RequiredFactionId1'] ?? 0,
      requiredFactionId2: json['RequiredFactionId2'] ?? 0,
      requiredFactionValue1: json['RequiredFactionValue1'] ?? 0,
      requiredFactionValue2: json['RequiredFactionValue2'] ?? 0,
      rewardNextQuest: json['RewardNextQuest'] ?? 0,
      rewardXpDifficulty: json['RewardXPDifficulty'] ?? 0,
      rewardMoney: json['RewardMoney'] ?? 0,
      rewardMoneyDifficulty: json['RewardMoneyDifficulty'] ?? 0,
      rewardDisplaySpell: json['RewardDisplaySpell'] ?? 0,
      rewardSpell: json['RewardSpell'] ?? 0,
      rewardHonor: json['RewardHonor'] ?? 0,
      rewardKillHonor: json['RewardKillHonor'] ?? 0,
      startItem: json['StartItem'] ?? 0,
      flags: json['Flags'] ?? 0,
      requiredPlayerKills: json['RequiredPlayerKills'] ?? 0,
      rewardItem1: json['RewardItem1'] ?? 0,
      rewardAmount1: json['RewardAmount1'] ?? 0,
      rewardItem2: json['RewardItem2'] ?? 0,
      rewardAmount2: json['RewardAmount2'] ?? 0,
      rewardItem3: json['RewardItem3'] ?? 0,
      rewardAmount3: json['RewardAmount3'] ?? 0,
      rewardItem4: json['RewardItem4'] ?? 0,
      rewardAmount4: json['RewardAmount4'] ?? 0,
      itemDrop1: json['ItemDrop1'] ?? 0,
      itemDropQuantity1: json['ItemDropQuantity1'] ?? 0,
      itemDrop2: json['ItemDrop2'] ?? 0,
      itemDropQuantity2: json['ItemDropQuantity2'] ?? 0,
      itemDrop3: json['ItemDrop3'] ?? 0,
      itemDropQuantity3: json['ItemDropQuantity3'] ?? 0,
      itemDrop4: json['ItemDrop4'] ?? 0,
      itemDropQuantity4: json['ItemDropQuantity4'] ?? 0,
      rewardChoiceItemId1: json['RewardChoiceItemID1'] ?? 0,
      rewardChoiceItemQuantity1: json['RewardChoiceItemQuantity1'] ?? 0,
      rewardChoiceItemId2: json['RewardChoiceItemID2'] ?? 0,
      rewardChoiceItemQuantity2: json['RewardChoiceItemQuantity2'] ?? 0,
      rewardChoiceItemId3: json['RewardChoiceItemID3'] ?? 0,
      rewardChoiceItemQuantity3: json['RewardChoiceItemQuantity3'] ?? 0,
      rewardChoiceItemId4: json['RewardChoiceItemID4'] ?? 0,
      rewardChoiceItemQuantity4: json['RewardChoiceItemQuantity4'] ?? 0,
      rewardChoiceItemId5: json['RewardChoiceItemID5'] ?? 0,
      rewardChoiceItemQuantity5: json['RewardChoiceItemQuantity5'] ?? 0,
      rewardChoiceItemId6: json['RewardChoiceItemID6'] ?? 0,
      rewardChoiceItemQuantity6: json['RewardChoiceItemQuantity6'] ?? 0,
      poiContinent: json['POIContinent'] ?? 0,
      poiX: json['POIx'] ?? 0,
      poiY: json['POIy'] ?? 0,
      poiPriority: json['POIPriority'] ?? 0,
      rewardTitle: json['RewardTitle'] ?? 0,
      rewardTalents: json['RewardTalents'] ?? 0,
      rewardArenaPoints: json['RewardArenaPoints'] ?? 0,
      rewardFactionId1: json['RewardFactionID1'] ?? 0,
      rewardFactionValue1: json['RewardFactionValue1'] ?? 0,
      rewardFactionOverride1: json['RewardFactionOverride1'] ?? 0,
      rewardFactionId2: json['RewardFactionID2'] ?? 0,
      rewardFactionValue2: json['RewardFactionValue2'] ?? 0,
      rewardFactionOverride2: json['RewardFactionOverride2'] ?? 0,
      rewardFactionId3: json['RewardFactionID3'] ?? 0,
      rewardFactionValue3: json['RewardFactionValue3'] ?? 0,
      rewardFactionOverride3: json['RewardFactionOverride3'] ?? 0,
      rewardFactionId4: json['RewardFactionID4'] ?? 0,
      rewardFactionValue4: json['RewardFactionValue4'] ?? 0,
      rewardFactionOverride4: json['RewardFactionOverride4'] ?? 0,
      rewardFactionId5: json['RewardFactionID5'] ?? 0,
      rewardFactionValue5: json['RewardFactionValue5'] ?? 0,
      rewardFactionOverride5: json['RewardFactionOverride5'] ?? 0,
      timeAllowed: json['TimeAllowed'] ?? 0,
      allowableRaces: json['AllowableRaces'] ?? 0,
      logTitle: json['LogTitle']?.toString() ?? '',
      logDescription: json['LogDescription']?.toString() ?? '',
      questDescription: json['QuestDescription']?.toString() ?? '',
      areaDescription: json['AreaDescription']?.toString() ?? '',
      questCompletionLog: json['QuestCompletionLog']?.toString() ?? '',
      requiredNpcOrGo1: json['RequiredNpcOrGo1'] ?? 0,
      requiredNpcOrGo2: json['RequiredNpcOrGo2'] ?? 0,
      requiredNpcOrGo3: json['RequiredNpcOrGo3'] ?? 0,
      requiredNpcOrGo4: json['RequiredNpcOrGo4'] ?? 0,
      requiredNpcOrGoCount1: json['RequiredNpcOrGoCount1'] ?? 0,
      requiredNpcOrGoCount2: json['RequiredNpcOrGoCount2'] ?? 0,
      requiredNpcOrGoCount3: json['RequiredNpcOrGoCount3'] ?? 0,
      requiredNpcOrGoCount4: json['RequiredNpcOrGoCount4'] ?? 0,
      requiredItemId1: json['RequiredItemId1'] ?? 0,
      requiredItemId2: json['RequiredItemId2'] ?? 0,
      requiredItemId3: json['RequiredItemId3'] ?? 0,
      requiredItemId4: json['RequiredItemId4'] ?? 0,
      requiredItemId5: json['RequiredItemId5'] ?? 0,
      requiredItemId6: json['RequiredItemId6'] ?? 0,
      requiredItemCount1: json['RequiredItemCount1'] ?? 0,
      requiredItemCount2: json['RequiredItemCount2'] ?? 0,
      requiredItemCount3: json['RequiredItemCount3'] ?? 0,
      requiredItemCount4: json['RequiredItemCount4'] ?? 0,
      requiredItemCount5: json['RequiredItemCount5'] ?? 0,
      requiredItemCount6: json['RequiredItemCount6'] ?? 0,
      unknown0: json['Unknown0'] ?? 0,
      objectiveText1: json['ObjectiveText1']?.toString() ?? '',
      objectiveText2: json['ObjectiveText2']?.toString() ?? '',
      objectiveText3: json['ObjectiveText3']?.toString() ?? '',
      objectiveText4: json['ObjectiveText4']?.toString() ?? '',
      verifiedBuild: json['VerifiedBuild'],
    );
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
