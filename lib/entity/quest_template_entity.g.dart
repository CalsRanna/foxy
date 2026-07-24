// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_entity.dart';

mixin _QuestTemplateEntityMixin {
  static QuestTemplateEntity fromJson(Map<String, dynamic> json) {
    return QuestTemplateEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      questType: (json['QuestType'] as num?)?.toInt() ?? 2,
      questLevel: (json['QuestLevel'] as num?)?.toInt() ?? 1,
      minLevel: (json['MinLevel'] as num?)?.toInt() ?? 0,
      questSortId: (json['QuestSortID'] as num?)?.toInt() ?? 0,
      questInfoId: (json['QuestInfoID'] as num?)?.toInt() ?? 0,
      suggestedGroupNum: (json['SuggestedGroupNum'] as num?)?.toInt() ?? 0,
      requiredFactionId1: (json['RequiredFactionId1'] as num?)?.toInt() ?? 0,
      requiredFactionId2: (json['RequiredFactionId2'] as num?)?.toInt() ?? 0,
      requiredFactionValue1:
          (json['RequiredFactionValue1'] as num?)?.toInt() ?? 0,
      requiredFactionValue2:
          (json['RequiredFactionValue2'] as num?)?.toInt() ?? 0,
      rewardNextQuest: (json['RewardNextQuest'] as num?)?.toInt() ?? 0,
      rewardXpDifficulty: (json['RewardXPDifficulty'] as num?)?.toInt() ?? 0,
      rewardMoney: (json['RewardMoney'] as num?)?.toInt() ?? 0,
      rewardMoneyDifficulty:
          (json['RewardMoneyDifficulty'] as num?)?.toInt() ?? 0,
      rewardDisplaySpell: (json['RewardDisplaySpell'] as num?)?.toInt() ?? 0,
      rewardSpell: (json['RewardSpell'] as num?)?.toInt() ?? 0,
      rewardHonor: (json['RewardHonor'] as num?)?.toInt() ?? 0,
      rewardKillHonor: (json['RewardKillHonor'] as num?)?.toDouble() ?? 0.0,
      startItem: (json['StartItem'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      requiredPlayerKills: (json['RequiredPlayerKills'] as num?)?.toInt() ?? 0,
      rewardItem1: (json['RewardItem1'] as num?)?.toInt() ?? 0,
      rewardAmount1: (json['RewardAmount1'] as num?)?.toInt() ?? 0,
      rewardItem2: (json['RewardItem2'] as num?)?.toInt() ?? 0,
      rewardAmount2: (json['RewardAmount2'] as num?)?.toInt() ?? 0,
      rewardItem3: (json['RewardItem3'] as num?)?.toInt() ?? 0,
      rewardAmount3: (json['RewardAmount3'] as num?)?.toInt() ?? 0,
      rewardItem4: (json['RewardItem4'] as num?)?.toInt() ?? 0,
      rewardAmount4: (json['RewardAmount4'] as num?)?.toInt() ?? 0,
      itemDrop1: (json['ItemDrop1'] as num?)?.toInt() ?? 0,
      itemDropQuantity1: (json['ItemDropQuantity1'] as num?)?.toInt() ?? 0,
      itemDrop2: (json['ItemDrop2'] as num?)?.toInt() ?? 0,
      itemDropQuantity2: (json['ItemDropQuantity2'] as num?)?.toInt() ?? 0,
      itemDrop3: (json['ItemDrop3'] as num?)?.toInt() ?? 0,
      itemDropQuantity3: (json['ItemDropQuantity3'] as num?)?.toInt() ?? 0,
      itemDrop4: (json['ItemDrop4'] as num?)?.toInt() ?? 0,
      itemDropQuantity4: (json['ItemDropQuantity4'] as num?)?.toInt() ?? 0,
      rewardChoiceItemId1: (json['RewardChoiceItemID1'] as num?)?.toInt() ?? 0,
      rewardChoiceItemQuantity1:
          (json['RewardChoiceItemQuantity1'] as num?)?.toInt() ?? 0,
      rewardChoiceItemId2: (json['RewardChoiceItemID2'] as num?)?.toInt() ?? 0,
      rewardChoiceItemQuantity2:
          (json['RewardChoiceItemQuantity2'] as num?)?.toInt() ?? 0,
      rewardChoiceItemId3: (json['RewardChoiceItemID3'] as num?)?.toInt() ?? 0,
      rewardChoiceItemQuantity3:
          (json['RewardChoiceItemQuantity3'] as num?)?.toInt() ?? 0,
      rewardChoiceItemId4: (json['RewardChoiceItemID4'] as num?)?.toInt() ?? 0,
      rewardChoiceItemQuantity4:
          (json['RewardChoiceItemQuantity4'] as num?)?.toInt() ?? 0,
      rewardChoiceItemId5: (json['RewardChoiceItemID5'] as num?)?.toInt() ?? 0,
      rewardChoiceItemQuantity5:
          (json['RewardChoiceItemQuantity5'] as num?)?.toInt() ?? 0,
      rewardChoiceItemId6: (json['RewardChoiceItemID6'] as num?)?.toInt() ?? 0,
      rewardChoiceItemQuantity6:
          (json['RewardChoiceItemQuantity6'] as num?)?.toInt() ?? 0,
      poiContinent: (json['POIContinent'] as num?)?.toInt() ?? 0,
      poiX: (json['POIx'] as num?)?.toDouble() ?? 0.0,
      poiY: (json['POIy'] as num?)?.toDouble() ?? 0.0,
      poiPriority: (json['POIPriority'] as num?)?.toInt() ?? 0,
      rewardTitle: (json['RewardTitle'] as num?)?.toInt() ?? 0,
      rewardTalents: (json['RewardTalents'] as num?)?.toInt() ?? 0,
      rewardArenaPoints: (json['RewardArenaPoints'] as num?)?.toInt() ?? 0,
      rewardFactionId1: (json['RewardFactionID1'] as num?)?.toInt() ?? 0,
      rewardFactionValue1: (json['RewardFactionValue1'] as num?)?.toInt() ?? 0,
      rewardFactionOverride1:
          (json['RewardFactionOverride1'] as num?)?.toInt() ?? 0,
      rewardFactionId2: (json['RewardFactionID2'] as num?)?.toInt() ?? 0,
      rewardFactionValue2: (json['RewardFactionValue2'] as num?)?.toInt() ?? 0,
      rewardFactionOverride2:
          (json['RewardFactionOverride2'] as num?)?.toInt() ?? 0,
      rewardFactionId3: (json['RewardFactionID3'] as num?)?.toInt() ?? 0,
      rewardFactionValue3: (json['RewardFactionValue3'] as num?)?.toInt() ?? 0,
      rewardFactionOverride3:
          (json['RewardFactionOverride3'] as num?)?.toInt() ?? 0,
      rewardFactionId4: (json['RewardFactionID4'] as num?)?.toInt() ?? 0,
      rewardFactionValue4: (json['RewardFactionValue4'] as num?)?.toInt() ?? 0,
      rewardFactionOverride4:
          (json['RewardFactionOverride4'] as num?)?.toInt() ?? 0,
      rewardFactionId5: (json['RewardFactionID5'] as num?)?.toInt() ?? 0,
      rewardFactionValue5: (json['RewardFactionValue5'] as num?)?.toInt() ?? 0,
      rewardFactionOverride5:
          (json['RewardFactionOverride5'] as num?)?.toInt() ?? 0,
      timeAllowed: (json['TimeAllowed'] as num?)?.toInt() ?? 0,
      allowableRaces: (json['AllowableRaces'] as num?)?.toInt() ?? 0,
      logTitle: json['LogTitle']?.toString() ?? '',
      logDescription: json['LogDescription']?.toString() ?? '',
      questDescription: json['QuestDescription']?.toString() ?? '',
      areaDescription: json['AreaDescription']?.toString() ?? '',
      questCompletionLog: json['QuestCompletionLog']?.toString() ?? '',
      requiredNpcOrGo1: (json['RequiredNpcOrGo1'] as num?)?.toInt() ?? 0,
      requiredNpcOrGo2: (json['RequiredNpcOrGo2'] as num?)?.toInt() ?? 0,
      requiredNpcOrGo3: (json['RequiredNpcOrGo3'] as num?)?.toInt() ?? 0,
      requiredNpcOrGo4: (json['RequiredNpcOrGo4'] as num?)?.toInt() ?? 0,
      requiredNpcOrGoCount1:
          (json['RequiredNpcOrGoCount1'] as num?)?.toInt() ?? 0,
      requiredNpcOrGoCount2:
          (json['RequiredNpcOrGoCount2'] as num?)?.toInt() ?? 0,
      requiredNpcOrGoCount3:
          (json['RequiredNpcOrGoCount3'] as num?)?.toInt() ?? 0,
      requiredNpcOrGoCount4:
          (json['RequiredNpcOrGoCount4'] as num?)?.toInt() ?? 0,
      requiredItemId1: (json['RequiredItemId1'] as num?)?.toInt() ?? 0,
      requiredItemId2: (json['RequiredItemId2'] as num?)?.toInt() ?? 0,
      requiredItemId3: (json['RequiredItemId3'] as num?)?.toInt() ?? 0,
      requiredItemId4: (json['RequiredItemId4'] as num?)?.toInt() ?? 0,
      requiredItemId5: (json['RequiredItemId5'] as num?)?.toInt() ?? 0,
      requiredItemId6: (json['RequiredItemId6'] as num?)?.toInt() ?? 0,
      requiredItemCount1: (json['RequiredItemCount1'] as num?)?.toInt() ?? 0,
      requiredItemCount2: (json['RequiredItemCount2'] as num?)?.toInt() ?? 0,
      requiredItemCount3: (json['RequiredItemCount3'] as num?)?.toInt() ?? 0,
      requiredItemCount4: (json['RequiredItemCount4'] as num?)?.toInt() ?? 0,
      requiredItemCount5: (json['RequiredItemCount5'] as num?)?.toInt() ?? 0,
      requiredItemCount6: (json['RequiredItemCount6'] as num?)?.toInt() ?? 0,
      unknown0: (json['Unknown0'] as num?)?.toInt() ?? 0,
      objectiveText1: json['ObjectiveText1']?.toString() ?? '',
      objectiveText2: json['ObjectiveText2']?.toString() ?? '',
      objectiveText3: json['ObjectiveText3']?.toString() ?? '',
      objectiveText4: json['ObjectiveText4']?.toString() ?? '',
      verifiedBuild: (json['VerifiedBuild'] as num?)?.toInt() ?? 0,
    );
  }

  QuestTemplateEntity copyWith({
    int? id,
    int? questType,
    int? questLevel,
    int? minLevel,
    int? questSortId,
    int? questInfoId,
    int? suggestedGroupNum,
    int? requiredFactionId1,
    int? requiredFactionId2,
    int? requiredFactionValue1,
    int? requiredFactionValue2,
    int? rewardNextQuest,
    int? rewardXpDifficulty,
    int? rewardMoney,
    int? rewardMoneyDifficulty,
    int? rewardDisplaySpell,
    int? rewardSpell,
    int? rewardHonor,
    double? rewardKillHonor,
    int? startItem,
    int? flags,
    int? requiredPlayerKills,
    int? rewardItem1,
    int? rewardAmount1,
    int? rewardItem2,
    int? rewardAmount2,
    int? rewardItem3,
    int? rewardAmount3,
    int? rewardItem4,
    int? rewardAmount4,
    int? itemDrop1,
    int? itemDropQuantity1,
    int? itemDrop2,
    int? itemDropQuantity2,
    int? itemDrop3,
    int? itemDropQuantity3,
    int? itemDrop4,
    int? itemDropQuantity4,
    int? rewardChoiceItemId1,
    int? rewardChoiceItemQuantity1,
    int? rewardChoiceItemId2,
    int? rewardChoiceItemQuantity2,
    int? rewardChoiceItemId3,
    int? rewardChoiceItemQuantity3,
    int? rewardChoiceItemId4,
    int? rewardChoiceItemQuantity4,
    int? rewardChoiceItemId5,
    int? rewardChoiceItemQuantity5,
    int? rewardChoiceItemId6,
    int? rewardChoiceItemQuantity6,
    int? poiContinent,
    double? poiX,
    double? poiY,
    int? poiPriority,
    int? rewardTitle,
    int? rewardTalents,
    int? rewardArenaPoints,
    int? rewardFactionId1,
    int? rewardFactionValue1,
    int? rewardFactionOverride1,
    int? rewardFactionId2,
    int? rewardFactionValue2,
    int? rewardFactionOverride2,
    int? rewardFactionId3,
    int? rewardFactionValue3,
    int? rewardFactionOverride3,
    int? rewardFactionId4,
    int? rewardFactionValue4,
    int? rewardFactionOverride4,
    int? rewardFactionId5,
    int? rewardFactionValue5,
    int? rewardFactionOverride5,
    int? timeAllowed,
    int? allowableRaces,
    String? logTitle,
    String? logDescription,
    String? questDescription,
    String? areaDescription,
    String? questCompletionLog,
    int? requiredNpcOrGo1,
    int? requiredNpcOrGo2,
    int? requiredNpcOrGo3,
    int? requiredNpcOrGo4,
    int? requiredNpcOrGoCount1,
    int? requiredNpcOrGoCount2,
    int? requiredNpcOrGoCount3,
    int? requiredNpcOrGoCount4,
    int? requiredItemId1,
    int? requiredItemId2,
    int? requiredItemId3,
    int? requiredItemId4,
    int? requiredItemId5,
    int? requiredItemId6,
    int? requiredItemCount1,
    int? requiredItemCount2,
    int? requiredItemCount3,
    int? requiredItemCount4,
    int? requiredItemCount5,
    int? requiredItemCount6,
    int? unknown0,
    String? objectiveText1,
    String? objectiveText2,
    String? objectiveText3,
    String? objectiveText4,
    int? verifiedBuild,
  }) {
    final self = this as QuestTemplateEntity;
    return QuestTemplateEntity(
      id: id ?? self.id,
      questType: questType ?? self.questType,
      questLevel: questLevel ?? self.questLevel,
      minLevel: minLevel ?? self.minLevel,
      questSortId: questSortId ?? self.questSortId,
      questInfoId: questInfoId ?? self.questInfoId,
      suggestedGroupNum: suggestedGroupNum ?? self.suggestedGroupNum,
      requiredFactionId1: requiredFactionId1 ?? self.requiredFactionId1,
      requiredFactionId2: requiredFactionId2 ?? self.requiredFactionId2,
      requiredFactionValue1:
          requiredFactionValue1 ?? self.requiredFactionValue1,
      requiredFactionValue2:
          requiredFactionValue2 ?? self.requiredFactionValue2,
      rewardNextQuest: rewardNextQuest ?? self.rewardNextQuest,
      rewardXpDifficulty: rewardXpDifficulty ?? self.rewardXpDifficulty,
      rewardMoney: rewardMoney ?? self.rewardMoney,
      rewardMoneyDifficulty:
          rewardMoneyDifficulty ?? self.rewardMoneyDifficulty,
      rewardDisplaySpell: rewardDisplaySpell ?? self.rewardDisplaySpell,
      rewardSpell: rewardSpell ?? self.rewardSpell,
      rewardHonor: rewardHonor ?? self.rewardHonor,
      rewardKillHonor: rewardKillHonor ?? self.rewardKillHonor,
      startItem: startItem ?? self.startItem,
      flags: flags ?? self.flags,
      requiredPlayerKills: requiredPlayerKills ?? self.requiredPlayerKills,
      rewardItem1: rewardItem1 ?? self.rewardItem1,
      rewardAmount1: rewardAmount1 ?? self.rewardAmount1,
      rewardItem2: rewardItem2 ?? self.rewardItem2,
      rewardAmount2: rewardAmount2 ?? self.rewardAmount2,
      rewardItem3: rewardItem3 ?? self.rewardItem3,
      rewardAmount3: rewardAmount3 ?? self.rewardAmount3,
      rewardItem4: rewardItem4 ?? self.rewardItem4,
      rewardAmount4: rewardAmount4 ?? self.rewardAmount4,
      itemDrop1: itemDrop1 ?? self.itemDrop1,
      itemDropQuantity1: itemDropQuantity1 ?? self.itemDropQuantity1,
      itemDrop2: itemDrop2 ?? self.itemDrop2,
      itemDropQuantity2: itemDropQuantity2 ?? self.itemDropQuantity2,
      itemDrop3: itemDrop3 ?? self.itemDrop3,
      itemDropQuantity3: itemDropQuantity3 ?? self.itemDropQuantity3,
      itemDrop4: itemDrop4 ?? self.itemDrop4,
      itemDropQuantity4: itemDropQuantity4 ?? self.itemDropQuantity4,
      rewardChoiceItemId1: rewardChoiceItemId1 ?? self.rewardChoiceItemId1,
      rewardChoiceItemQuantity1:
          rewardChoiceItemQuantity1 ?? self.rewardChoiceItemQuantity1,
      rewardChoiceItemId2: rewardChoiceItemId2 ?? self.rewardChoiceItemId2,
      rewardChoiceItemQuantity2:
          rewardChoiceItemQuantity2 ?? self.rewardChoiceItemQuantity2,
      rewardChoiceItemId3: rewardChoiceItemId3 ?? self.rewardChoiceItemId3,
      rewardChoiceItemQuantity3:
          rewardChoiceItemQuantity3 ?? self.rewardChoiceItemQuantity3,
      rewardChoiceItemId4: rewardChoiceItemId4 ?? self.rewardChoiceItemId4,
      rewardChoiceItemQuantity4:
          rewardChoiceItemQuantity4 ?? self.rewardChoiceItemQuantity4,
      rewardChoiceItemId5: rewardChoiceItemId5 ?? self.rewardChoiceItemId5,
      rewardChoiceItemQuantity5:
          rewardChoiceItemQuantity5 ?? self.rewardChoiceItemQuantity5,
      rewardChoiceItemId6: rewardChoiceItemId6 ?? self.rewardChoiceItemId6,
      rewardChoiceItemQuantity6:
          rewardChoiceItemQuantity6 ?? self.rewardChoiceItemQuantity6,
      poiContinent: poiContinent ?? self.poiContinent,
      poiX: poiX ?? self.poiX,
      poiY: poiY ?? self.poiY,
      poiPriority: poiPriority ?? self.poiPriority,
      rewardTitle: rewardTitle ?? self.rewardTitle,
      rewardTalents: rewardTalents ?? self.rewardTalents,
      rewardArenaPoints: rewardArenaPoints ?? self.rewardArenaPoints,
      rewardFactionId1: rewardFactionId1 ?? self.rewardFactionId1,
      rewardFactionValue1: rewardFactionValue1 ?? self.rewardFactionValue1,
      rewardFactionOverride1:
          rewardFactionOverride1 ?? self.rewardFactionOverride1,
      rewardFactionId2: rewardFactionId2 ?? self.rewardFactionId2,
      rewardFactionValue2: rewardFactionValue2 ?? self.rewardFactionValue2,
      rewardFactionOverride2:
          rewardFactionOverride2 ?? self.rewardFactionOverride2,
      rewardFactionId3: rewardFactionId3 ?? self.rewardFactionId3,
      rewardFactionValue3: rewardFactionValue3 ?? self.rewardFactionValue3,
      rewardFactionOverride3:
          rewardFactionOverride3 ?? self.rewardFactionOverride3,
      rewardFactionId4: rewardFactionId4 ?? self.rewardFactionId4,
      rewardFactionValue4: rewardFactionValue4 ?? self.rewardFactionValue4,
      rewardFactionOverride4:
          rewardFactionOverride4 ?? self.rewardFactionOverride4,
      rewardFactionId5: rewardFactionId5 ?? self.rewardFactionId5,
      rewardFactionValue5: rewardFactionValue5 ?? self.rewardFactionValue5,
      rewardFactionOverride5:
          rewardFactionOverride5 ?? self.rewardFactionOverride5,
      timeAllowed: timeAllowed ?? self.timeAllowed,
      allowableRaces: allowableRaces ?? self.allowableRaces,
      logTitle: logTitle ?? self.logTitle,
      logDescription: logDescription ?? self.logDescription,
      questDescription: questDescription ?? self.questDescription,
      areaDescription: areaDescription ?? self.areaDescription,
      questCompletionLog: questCompletionLog ?? self.questCompletionLog,
      requiredNpcOrGo1: requiredNpcOrGo1 ?? self.requiredNpcOrGo1,
      requiredNpcOrGo2: requiredNpcOrGo2 ?? self.requiredNpcOrGo2,
      requiredNpcOrGo3: requiredNpcOrGo3 ?? self.requiredNpcOrGo3,
      requiredNpcOrGo4: requiredNpcOrGo4 ?? self.requiredNpcOrGo4,
      requiredNpcOrGoCount1:
          requiredNpcOrGoCount1 ?? self.requiredNpcOrGoCount1,
      requiredNpcOrGoCount2:
          requiredNpcOrGoCount2 ?? self.requiredNpcOrGoCount2,
      requiredNpcOrGoCount3:
          requiredNpcOrGoCount3 ?? self.requiredNpcOrGoCount3,
      requiredNpcOrGoCount4:
          requiredNpcOrGoCount4 ?? self.requiredNpcOrGoCount4,
      requiredItemId1: requiredItemId1 ?? self.requiredItemId1,
      requiredItemId2: requiredItemId2 ?? self.requiredItemId2,
      requiredItemId3: requiredItemId3 ?? self.requiredItemId3,
      requiredItemId4: requiredItemId4 ?? self.requiredItemId4,
      requiredItemId5: requiredItemId5 ?? self.requiredItemId5,
      requiredItemId6: requiredItemId6 ?? self.requiredItemId6,
      requiredItemCount1: requiredItemCount1 ?? self.requiredItemCount1,
      requiredItemCount2: requiredItemCount2 ?? self.requiredItemCount2,
      requiredItemCount3: requiredItemCount3 ?? self.requiredItemCount3,
      requiredItemCount4: requiredItemCount4 ?? self.requiredItemCount4,
      requiredItemCount5: requiredItemCount5 ?? self.requiredItemCount5,
      requiredItemCount6: requiredItemCount6 ?? self.requiredItemCount6,
      unknown0: unknown0 ?? self.unknown0,
      objectiveText1: objectiveText1 ?? self.objectiveText1,
      objectiveText2: objectiveText2 ?? self.objectiveText2,
      objectiveText3: objectiveText3 ?? self.objectiveText3,
      objectiveText4: objectiveText4 ?? self.objectiveText4,
      verifiedBuild: verifiedBuild ?? self.verifiedBuild,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as QuestTemplateEntity;
    return {
      'ID': self.id,
      'QuestType': self.questType,
      'QuestLevel': self.questLevel,
      'MinLevel': self.minLevel,
      'QuestSortID': self.questSortId,
      'QuestInfoID': self.questInfoId,
      'SuggestedGroupNum': self.suggestedGroupNum,
      'RequiredFactionId1': self.requiredFactionId1,
      'RequiredFactionId2': self.requiredFactionId2,
      'RequiredFactionValue1': self.requiredFactionValue1,
      'RequiredFactionValue2': self.requiredFactionValue2,
      'RewardNextQuest': self.rewardNextQuest,
      'RewardXPDifficulty': self.rewardXpDifficulty,
      'RewardMoney': self.rewardMoney,
      'RewardMoneyDifficulty': self.rewardMoneyDifficulty,
      'RewardDisplaySpell': self.rewardDisplaySpell,
      'RewardSpell': self.rewardSpell,
      'RewardHonor': self.rewardHonor,
      'RewardKillHonor': self.rewardKillHonor,
      'StartItem': self.startItem,
      'Flags': self.flags,
      'RequiredPlayerKills': self.requiredPlayerKills,
      'RewardItem1': self.rewardItem1,
      'RewardAmount1': self.rewardAmount1,
      'RewardItem2': self.rewardItem2,
      'RewardAmount2': self.rewardAmount2,
      'RewardItem3': self.rewardItem3,
      'RewardAmount3': self.rewardAmount3,
      'RewardItem4': self.rewardItem4,
      'RewardAmount4': self.rewardAmount4,
      'ItemDrop1': self.itemDrop1,
      'ItemDropQuantity1': self.itemDropQuantity1,
      'ItemDrop2': self.itemDrop2,
      'ItemDropQuantity2': self.itemDropQuantity2,
      'ItemDrop3': self.itemDrop3,
      'ItemDropQuantity3': self.itemDropQuantity3,
      'ItemDrop4': self.itemDrop4,
      'ItemDropQuantity4': self.itemDropQuantity4,
      'RewardChoiceItemID1': self.rewardChoiceItemId1,
      'RewardChoiceItemQuantity1': self.rewardChoiceItemQuantity1,
      'RewardChoiceItemID2': self.rewardChoiceItemId2,
      'RewardChoiceItemQuantity2': self.rewardChoiceItemQuantity2,
      'RewardChoiceItemID3': self.rewardChoiceItemId3,
      'RewardChoiceItemQuantity3': self.rewardChoiceItemQuantity3,
      'RewardChoiceItemID4': self.rewardChoiceItemId4,
      'RewardChoiceItemQuantity4': self.rewardChoiceItemQuantity4,
      'RewardChoiceItemID5': self.rewardChoiceItemId5,
      'RewardChoiceItemQuantity5': self.rewardChoiceItemQuantity5,
      'RewardChoiceItemID6': self.rewardChoiceItemId6,
      'RewardChoiceItemQuantity6': self.rewardChoiceItemQuantity6,
      'POIContinent': self.poiContinent,
      'POIx': self.poiX,
      'POIy': self.poiY,
      'POIPriority': self.poiPriority,
      'RewardTitle': self.rewardTitle,
      'RewardTalents': self.rewardTalents,
      'RewardArenaPoints': self.rewardArenaPoints,
      'RewardFactionID1': self.rewardFactionId1,
      'RewardFactionValue1': self.rewardFactionValue1,
      'RewardFactionOverride1': self.rewardFactionOverride1,
      'RewardFactionID2': self.rewardFactionId2,
      'RewardFactionValue2': self.rewardFactionValue2,
      'RewardFactionOverride2': self.rewardFactionOverride2,
      'RewardFactionID3': self.rewardFactionId3,
      'RewardFactionValue3': self.rewardFactionValue3,
      'RewardFactionOverride3': self.rewardFactionOverride3,
      'RewardFactionID4': self.rewardFactionId4,
      'RewardFactionValue4': self.rewardFactionValue4,
      'RewardFactionOverride4': self.rewardFactionOverride4,
      'RewardFactionID5': self.rewardFactionId5,
      'RewardFactionValue5': self.rewardFactionValue5,
      'RewardFactionOverride5': self.rewardFactionOverride5,
      'TimeAllowed': self.timeAllowed,
      'AllowableRaces': self.allowableRaces,
      'LogTitle': self.logTitle,
      'LogDescription': self.logDescription,
      'QuestDescription': self.questDescription,
      'AreaDescription': self.areaDescription,
      'QuestCompletionLog': self.questCompletionLog,
      'RequiredNpcOrGo1': self.requiredNpcOrGo1,
      'RequiredNpcOrGo2': self.requiredNpcOrGo2,
      'RequiredNpcOrGo3': self.requiredNpcOrGo3,
      'RequiredNpcOrGo4': self.requiredNpcOrGo4,
      'RequiredNpcOrGoCount1': self.requiredNpcOrGoCount1,
      'RequiredNpcOrGoCount2': self.requiredNpcOrGoCount2,
      'RequiredNpcOrGoCount3': self.requiredNpcOrGoCount3,
      'RequiredNpcOrGoCount4': self.requiredNpcOrGoCount4,
      'RequiredItemId1': self.requiredItemId1,
      'RequiredItemId2': self.requiredItemId2,
      'RequiredItemId3': self.requiredItemId3,
      'RequiredItemId4': self.requiredItemId4,
      'RequiredItemId5': self.requiredItemId5,
      'RequiredItemId6': self.requiredItemId6,
      'RequiredItemCount1': self.requiredItemCount1,
      'RequiredItemCount2': self.requiredItemCount2,
      'RequiredItemCount3': self.requiredItemCount3,
      'RequiredItemCount4': self.requiredItemCount4,
      'RequiredItemCount5': self.requiredItemCount5,
      'RequiredItemCount6': self.requiredItemCount6,
      'Unknown0': self.unknown0,
      'ObjectiveText1': self.objectiveText1,
      'ObjectiveText2': self.objectiveText2,
      'ObjectiveText3': self.objectiveText3,
      'ObjectiveText4': self.objectiveText4,
      'VerifiedBuild': self.verifiedBuild,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as QuestTemplateEntity;
    return identical(self, other) ||
        other is QuestTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.questType == other.questType &&
            self.questLevel == other.questLevel &&
            self.minLevel == other.minLevel &&
            self.questSortId == other.questSortId &&
            self.questInfoId == other.questInfoId &&
            self.suggestedGroupNum == other.suggestedGroupNum &&
            self.requiredFactionId1 == other.requiredFactionId1 &&
            self.requiredFactionId2 == other.requiredFactionId2 &&
            self.requiredFactionValue1 == other.requiredFactionValue1 &&
            self.requiredFactionValue2 == other.requiredFactionValue2 &&
            self.rewardNextQuest == other.rewardNextQuest &&
            self.rewardXpDifficulty == other.rewardXpDifficulty &&
            self.rewardMoney == other.rewardMoney &&
            self.rewardMoneyDifficulty == other.rewardMoneyDifficulty &&
            self.rewardDisplaySpell == other.rewardDisplaySpell &&
            self.rewardSpell == other.rewardSpell &&
            self.rewardHonor == other.rewardHonor &&
            self.rewardKillHonor == other.rewardKillHonor &&
            self.startItem == other.startItem &&
            self.flags == other.flags &&
            self.requiredPlayerKills == other.requiredPlayerKills &&
            self.rewardItem1 == other.rewardItem1 &&
            self.rewardAmount1 == other.rewardAmount1 &&
            self.rewardItem2 == other.rewardItem2 &&
            self.rewardAmount2 == other.rewardAmount2 &&
            self.rewardItem3 == other.rewardItem3 &&
            self.rewardAmount3 == other.rewardAmount3 &&
            self.rewardItem4 == other.rewardItem4 &&
            self.rewardAmount4 == other.rewardAmount4 &&
            self.itemDrop1 == other.itemDrop1 &&
            self.itemDropQuantity1 == other.itemDropQuantity1 &&
            self.itemDrop2 == other.itemDrop2 &&
            self.itemDropQuantity2 == other.itemDropQuantity2 &&
            self.itemDrop3 == other.itemDrop3 &&
            self.itemDropQuantity3 == other.itemDropQuantity3 &&
            self.itemDrop4 == other.itemDrop4 &&
            self.itemDropQuantity4 == other.itemDropQuantity4 &&
            self.rewardChoiceItemId1 == other.rewardChoiceItemId1 &&
            self.rewardChoiceItemQuantity1 == other.rewardChoiceItemQuantity1 &&
            self.rewardChoiceItemId2 == other.rewardChoiceItemId2 &&
            self.rewardChoiceItemQuantity2 == other.rewardChoiceItemQuantity2 &&
            self.rewardChoiceItemId3 == other.rewardChoiceItemId3 &&
            self.rewardChoiceItemQuantity3 == other.rewardChoiceItemQuantity3 &&
            self.rewardChoiceItemId4 == other.rewardChoiceItemId4 &&
            self.rewardChoiceItemQuantity4 == other.rewardChoiceItemQuantity4 &&
            self.rewardChoiceItemId5 == other.rewardChoiceItemId5 &&
            self.rewardChoiceItemQuantity5 == other.rewardChoiceItemQuantity5 &&
            self.rewardChoiceItemId6 == other.rewardChoiceItemId6 &&
            self.rewardChoiceItemQuantity6 == other.rewardChoiceItemQuantity6 &&
            self.poiContinent == other.poiContinent &&
            self.poiX == other.poiX &&
            self.poiY == other.poiY &&
            self.poiPriority == other.poiPriority &&
            self.rewardTitle == other.rewardTitle &&
            self.rewardTalents == other.rewardTalents &&
            self.rewardArenaPoints == other.rewardArenaPoints &&
            self.rewardFactionId1 == other.rewardFactionId1 &&
            self.rewardFactionValue1 == other.rewardFactionValue1 &&
            self.rewardFactionOverride1 == other.rewardFactionOverride1 &&
            self.rewardFactionId2 == other.rewardFactionId2 &&
            self.rewardFactionValue2 == other.rewardFactionValue2 &&
            self.rewardFactionOverride2 == other.rewardFactionOverride2 &&
            self.rewardFactionId3 == other.rewardFactionId3 &&
            self.rewardFactionValue3 == other.rewardFactionValue3 &&
            self.rewardFactionOverride3 == other.rewardFactionOverride3 &&
            self.rewardFactionId4 == other.rewardFactionId4 &&
            self.rewardFactionValue4 == other.rewardFactionValue4 &&
            self.rewardFactionOverride4 == other.rewardFactionOverride4 &&
            self.rewardFactionId5 == other.rewardFactionId5 &&
            self.rewardFactionValue5 == other.rewardFactionValue5 &&
            self.rewardFactionOverride5 == other.rewardFactionOverride5 &&
            self.timeAllowed == other.timeAllowed &&
            self.allowableRaces == other.allowableRaces &&
            self.logTitle == other.logTitle &&
            self.logDescription == other.logDescription &&
            self.questDescription == other.questDescription &&
            self.areaDescription == other.areaDescription &&
            self.questCompletionLog == other.questCompletionLog &&
            self.requiredNpcOrGo1 == other.requiredNpcOrGo1 &&
            self.requiredNpcOrGo2 == other.requiredNpcOrGo2 &&
            self.requiredNpcOrGo3 == other.requiredNpcOrGo3 &&
            self.requiredNpcOrGo4 == other.requiredNpcOrGo4 &&
            self.requiredNpcOrGoCount1 == other.requiredNpcOrGoCount1 &&
            self.requiredNpcOrGoCount2 == other.requiredNpcOrGoCount2 &&
            self.requiredNpcOrGoCount3 == other.requiredNpcOrGoCount3 &&
            self.requiredNpcOrGoCount4 == other.requiredNpcOrGoCount4 &&
            self.requiredItemId1 == other.requiredItemId1 &&
            self.requiredItemId2 == other.requiredItemId2 &&
            self.requiredItemId3 == other.requiredItemId3 &&
            self.requiredItemId4 == other.requiredItemId4 &&
            self.requiredItemId5 == other.requiredItemId5 &&
            self.requiredItemId6 == other.requiredItemId6 &&
            self.requiredItemCount1 == other.requiredItemCount1 &&
            self.requiredItemCount2 == other.requiredItemCount2 &&
            self.requiredItemCount3 == other.requiredItemCount3 &&
            self.requiredItemCount4 == other.requiredItemCount4 &&
            self.requiredItemCount5 == other.requiredItemCount5 &&
            self.requiredItemCount6 == other.requiredItemCount6 &&
            self.unknown0 == other.unknown0 &&
            self.objectiveText1 == other.objectiveText1 &&
            self.objectiveText2 == other.objectiveText2 &&
            self.objectiveText3 == other.objectiveText3 &&
            self.objectiveText4 == other.objectiveText4 &&
            self.verifiedBuild == other.verifiedBuild;
  }

  @override
  int get hashCode {
    final self = this as QuestTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.questType,
      self.questLevel,
      self.minLevel,
      self.questSortId,
      self.questInfoId,
      self.suggestedGroupNum,
      self.requiredFactionId1,
      self.requiredFactionId2,
      self.requiredFactionValue1,
      self.requiredFactionValue2,
      self.rewardNextQuest,
      self.rewardXpDifficulty,
      self.rewardMoney,
      self.rewardMoneyDifficulty,
      self.rewardDisplaySpell,
      self.rewardSpell,
      self.rewardHonor,
      self.rewardKillHonor,
      self.startItem,
      self.flags,
      self.requiredPlayerKills,
      self.rewardItem1,
      self.rewardAmount1,
      self.rewardItem2,
      self.rewardAmount2,
      self.rewardItem3,
      self.rewardAmount3,
      self.rewardItem4,
      self.rewardAmount4,
      self.itemDrop1,
      self.itemDropQuantity1,
      self.itemDrop2,
      self.itemDropQuantity2,
      self.itemDrop3,
      self.itemDropQuantity3,
      self.itemDrop4,
      self.itemDropQuantity4,
      self.rewardChoiceItemId1,
      self.rewardChoiceItemQuantity1,
      self.rewardChoiceItemId2,
      self.rewardChoiceItemQuantity2,
      self.rewardChoiceItemId3,
      self.rewardChoiceItemQuantity3,
      self.rewardChoiceItemId4,
      self.rewardChoiceItemQuantity4,
      self.rewardChoiceItemId5,
      self.rewardChoiceItemQuantity5,
      self.rewardChoiceItemId6,
      self.rewardChoiceItemQuantity6,
      self.poiContinent,
      self.poiX,
      self.poiY,
      self.poiPriority,
      self.rewardTitle,
      self.rewardTalents,
      self.rewardArenaPoints,
      self.rewardFactionId1,
      self.rewardFactionValue1,
      self.rewardFactionOverride1,
      self.rewardFactionId2,
      self.rewardFactionValue2,
      self.rewardFactionOverride2,
      self.rewardFactionId3,
      self.rewardFactionValue3,
      self.rewardFactionOverride3,
      self.rewardFactionId4,
      self.rewardFactionValue4,
      self.rewardFactionOverride4,
      self.rewardFactionId5,
      self.rewardFactionValue5,
      self.rewardFactionOverride5,
      self.timeAllowed,
      self.allowableRaces,
      self.logTitle,
      self.logDescription,
      self.questDescription,
      self.areaDescription,
      self.questCompletionLog,
      self.requiredNpcOrGo1,
      self.requiredNpcOrGo2,
      self.requiredNpcOrGo3,
      self.requiredNpcOrGo4,
      self.requiredNpcOrGoCount1,
      self.requiredNpcOrGoCount2,
      self.requiredNpcOrGoCount3,
      self.requiredNpcOrGoCount4,
      self.requiredItemId1,
      self.requiredItemId2,
      self.requiredItemId3,
      self.requiredItemId4,
      self.requiredItemId5,
      self.requiredItemId6,
      self.requiredItemCount1,
      self.requiredItemCount2,
      self.requiredItemCount3,
      self.requiredItemCount4,
      self.requiredItemCount5,
      self.requiredItemCount6,
      self.unknown0,
      self.objectiveText1,
      self.objectiveText2,
      self.objectiveText3,
      self.objectiveText4,
      self.verifiedBuild,
    ]);
  }

  @override
  String toString() {
    final self = this as QuestTemplateEntity;
    return 'QuestTemplateEntity('
        'id: ${self.id}, '
        'questType: ${self.questType}, '
        'questLevel: ${self.questLevel}, '
        'minLevel: ${self.minLevel}, '
        'questSortId: ${self.questSortId}, '
        'questInfoId: ${self.questInfoId}, '
        'suggestedGroupNum: ${self.suggestedGroupNum}, '
        'requiredFactionId1: ${self.requiredFactionId1}, '
        'requiredFactionId2: ${self.requiredFactionId2}, '
        'requiredFactionValue1: ${self.requiredFactionValue1}, '
        'requiredFactionValue2: ${self.requiredFactionValue2}, '
        'rewardNextQuest: ${self.rewardNextQuest}, '
        'rewardXpDifficulty: ${self.rewardXpDifficulty}, '
        'rewardMoney: ${self.rewardMoney}, '
        'rewardMoneyDifficulty: ${self.rewardMoneyDifficulty}, '
        'rewardDisplaySpell: ${self.rewardDisplaySpell}, '
        'rewardSpell: ${self.rewardSpell}, '
        'rewardHonor: ${self.rewardHonor}, '
        'rewardKillHonor: ${self.rewardKillHonor}, '
        'startItem: ${self.startItem}, '
        'flags: ${self.flags}, '
        'requiredPlayerKills: ${self.requiredPlayerKills}, '
        'rewardItem1: ${self.rewardItem1}, '
        'rewardAmount1: ${self.rewardAmount1}, '
        'rewardItem2: ${self.rewardItem2}, '
        'rewardAmount2: ${self.rewardAmount2}, '
        'rewardItem3: ${self.rewardItem3}, '
        'rewardAmount3: ${self.rewardAmount3}, '
        'rewardItem4: ${self.rewardItem4}, '
        'rewardAmount4: ${self.rewardAmount4}, '
        'itemDrop1: ${self.itemDrop1}, '
        'itemDropQuantity1: ${self.itemDropQuantity1}, '
        'itemDrop2: ${self.itemDrop2}, '
        'itemDropQuantity2: ${self.itemDropQuantity2}, '
        'itemDrop3: ${self.itemDrop3}, '
        'itemDropQuantity3: ${self.itemDropQuantity3}, '
        'itemDrop4: ${self.itemDrop4}, '
        'itemDropQuantity4: ${self.itemDropQuantity4}, '
        'rewardChoiceItemId1: ${self.rewardChoiceItemId1}, '
        'rewardChoiceItemQuantity1: ${self.rewardChoiceItemQuantity1}, '
        'rewardChoiceItemId2: ${self.rewardChoiceItemId2}, '
        'rewardChoiceItemQuantity2: ${self.rewardChoiceItemQuantity2}, '
        'rewardChoiceItemId3: ${self.rewardChoiceItemId3}, '
        'rewardChoiceItemQuantity3: ${self.rewardChoiceItemQuantity3}, '
        'rewardChoiceItemId4: ${self.rewardChoiceItemId4}, '
        'rewardChoiceItemQuantity4: ${self.rewardChoiceItemQuantity4}, '
        'rewardChoiceItemId5: ${self.rewardChoiceItemId5}, '
        'rewardChoiceItemQuantity5: ${self.rewardChoiceItemQuantity5}, '
        'rewardChoiceItemId6: ${self.rewardChoiceItemId6}, '
        'rewardChoiceItemQuantity6: ${self.rewardChoiceItemQuantity6}, '
        'poiContinent: ${self.poiContinent}, '
        'poiX: ${self.poiX}, '
        'poiY: ${self.poiY}, '
        'poiPriority: ${self.poiPriority}, '
        'rewardTitle: ${self.rewardTitle}, '
        'rewardTalents: ${self.rewardTalents}, '
        'rewardArenaPoints: ${self.rewardArenaPoints}, '
        'rewardFactionId1: ${self.rewardFactionId1}, '
        'rewardFactionValue1: ${self.rewardFactionValue1}, '
        'rewardFactionOverride1: ${self.rewardFactionOverride1}, '
        'rewardFactionId2: ${self.rewardFactionId2}, '
        'rewardFactionValue2: ${self.rewardFactionValue2}, '
        'rewardFactionOverride2: ${self.rewardFactionOverride2}, '
        'rewardFactionId3: ${self.rewardFactionId3}, '
        'rewardFactionValue3: ${self.rewardFactionValue3}, '
        'rewardFactionOverride3: ${self.rewardFactionOverride3}, '
        'rewardFactionId4: ${self.rewardFactionId4}, '
        'rewardFactionValue4: ${self.rewardFactionValue4}, '
        'rewardFactionOverride4: ${self.rewardFactionOverride4}, '
        'rewardFactionId5: ${self.rewardFactionId5}, '
        'rewardFactionValue5: ${self.rewardFactionValue5}, '
        'rewardFactionOverride5: ${self.rewardFactionOverride5}, '
        'timeAllowed: ${self.timeAllowed}, '
        'allowableRaces: ${self.allowableRaces}, '
        'logTitle: ${self.logTitle}, '
        'logDescription: ${self.logDescription}, '
        'questDescription: ${self.questDescription}, '
        'areaDescription: ${self.areaDescription}, '
        'questCompletionLog: ${self.questCompletionLog}, '
        'requiredNpcOrGo1: ${self.requiredNpcOrGo1}, '
        'requiredNpcOrGo2: ${self.requiredNpcOrGo2}, '
        'requiredNpcOrGo3: ${self.requiredNpcOrGo3}, '
        'requiredNpcOrGo4: ${self.requiredNpcOrGo4}, '
        'requiredNpcOrGoCount1: ${self.requiredNpcOrGoCount1}, '
        'requiredNpcOrGoCount2: ${self.requiredNpcOrGoCount2}, '
        'requiredNpcOrGoCount3: ${self.requiredNpcOrGoCount3}, '
        'requiredNpcOrGoCount4: ${self.requiredNpcOrGoCount4}, '
        'requiredItemId1: ${self.requiredItemId1}, '
        'requiredItemId2: ${self.requiredItemId2}, '
        'requiredItemId3: ${self.requiredItemId3}, '
        'requiredItemId4: ${self.requiredItemId4}, '
        'requiredItemId5: ${self.requiredItemId5}, '
        'requiredItemId6: ${self.requiredItemId6}, '
        'requiredItemCount1: ${self.requiredItemCount1}, '
        'requiredItemCount2: ${self.requiredItemCount2}, '
        'requiredItemCount3: ${self.requiredItemCount3}, '
        'requiredItemCount4: ${self.requiredItemCount4}, '
        'requiredItemCount5: ${self.requiredItemCount5}, '
        'requiredItemCount6: ${self.requiredItemCount6}, '
        'unknown0: ${self.unknown0}, '
        'objectiveText1: ${self.objectiveText1}, '
        'objectiveText2: ${self.objectiveText2}, '
        'objectiveText3: ${self.objectiveText3}, '
        'objectiveText4: ${self.objectiveText4}, '
        'verifiedBuild: ${self.verifiedBuild}'
        ')';
  }
}

final class BriefQuestTemplateEntity {
  final int id;
  final int questType;
  final int questLevel;
  final int minLevel;
  final String logTitle;
  final String questDescription;
  final String localeTitle;
  final String localeDetails;

  const BriefQuestTemplateEntity({
    this.id = 0,
    this.questType = 2,
    this.questLevel = 1,
    this.minLevel = 0,
    this.logTitle = '',
    this.questDescription = '',
    this.localeTitle = '',
    this.localeDetails = '',
  });

  factory BriefQuestTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefQuestTemplateEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      questType: (json['QuestType'] as num?)?.toInt() ?? 2,
      questLevel: (json['QuestLevel'] as num?)?.toInt() ?? 1,
      minLevel: (json['MinLevel'] as num?)?.toInt() ?? 0,
      logTitle: json['LogTitle']?.toString() ?? '',
      questDescription: json['QuestDescription']?.toString() ?? '',
      localeTitle: json['localeTitle']?.toString() ?? '',
      localeDetails: json['localeDetails']?.toString() ?? '',
    );
  }

  int get key => id;
}
