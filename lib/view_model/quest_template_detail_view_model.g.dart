// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_detail_view_model.dart';

mixin _QuestTemplateDetailViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final questTypeController = registerController(
    SelectFieldController<int>(fallback: 2),
  );
  late final questLevelController = registerController(IntFieldController());
  late final minLevelController = registerController(IntFieldController());
  late final questSortIdController = registerController(IntFieldController());
  late final questInfoIdController = registerController(IntFieldController());
  late final suggestedGroupNumController = registerController(
    IntFieldController(),
  );
  late final requiredFactionId1Controller = registerController(
    IntFieldController(),
  );
  late final requiredFactionId2Controller = registerController(
    IntFieldController(),
  );
  late final requiredFactionValue1Controller = registerController(
    IntFieldController(),
  );
  late final requiredFactionValue2Controller = registerController(
    IntFieldController(),
  );
  late final rewardNextQuestController = registerController(
    IntFieldController(),
  );
  late final rewardXpDifficultyController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final rewardMoneyController = registerController(IntFieldController());
  late final rewardMoneyDifficultyController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final rewardDisplaySpellController = registerController(
    IntFieldController(),
  );
  late final rewardSpellController = registerController(IntFieldController());
  late final rewardHonorController = registerController(IntFieldController());
  late final rewardKillHonorController = registerController(
    DoubleFieldController(),
  );
  late final startItemController = registerController(IntFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final requiredPlayerKillsController = registerController(
    IntFieldController(),
  );
  late final rewardItem1Controller = registerController(IntFieldController());
  late final rewardAmount1Controller = registerController(IntFieldController());
  late final rewardItem2Controller = registerController(IntFieldController());
  late final rewardAmount2Controller = registerController(IntFieldController());
  late final rewardItem3Controller = registerController(IntFieldController());
  late final rewardAmount3Controller = registerController(IntFieldController());
  late final rewardItem4Controller = registerController(IntFieldController());
  late final rewardAmount4Controller = registerController(IntFieldController());
  late final itemDrop1Controller = registerController(IntFieldController());
  late final itemDropQuantity1Controller = registerController(
    IntFieldController(),
  );
  late final itemDrop2Controller = registerController(IntFieldController());
  late final itemDropQuantity2Controller = registerController(
    IntFieldController(),
  );
  late final itemDrop3Controller = registerController(IntFieldController());
  late final itemDropQuantity3Controller = registerController(
    IntFieldController(),
  );
  late final itemDrop4Controller = registerController(IntFieldController());
  late final itemDropQuantity4Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemId1Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemQuantity1Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemId2Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemQuantity2Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemId3Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemQuantity3Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemId4Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemQuantity4Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemId5Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemQuantity5Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemId6Controller = registerController(
    IntFieldController(),
  );
  late final rewardChoiceItemQuantity6Controller = registerController(
    IntFieldController(),
  );
  late final poiContinentController = registerController(IntFieldController());
  late final poiXController = registerController(DoubleFieldController());
  late final poiYController = registerController(DoubleFieldController());
  late final poiPriorityController = registerController(IntFieldController());
  late final rewardTitleController = registerController(IntFieldController());
  late final rewardTalentsController = registerController(IntFieldController());
  late final rewardArenaPointsController = registerController(
    IntFieldController(),
  );
  late final rewardFactionId1Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionValue1Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionOverride1Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionId2Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionValue2Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionOverride2Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionId3Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionValue3Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionOverride3Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionId4Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionValue4Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionOverride4Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionId5Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionValue5Controller = registerController(
    IntFieldController(),
  );
  late final rewardFactionOverride5Controller = registerController(
    IntFieldController(),
  );
  late final timeAllowedController = registerController(IntFieldController());
  late final allowableRacesController = registerController(
    FlagFieldController(),
  );
  late final logTitleController = registerController(StringFieldController());
  late final logDescriptionController = registerController(
    StringFieldController(),
  );
  late final questDescriptionController = registerController(
    StringFieldController(),
  );
  late final areaDescriptionController = registerController(
    StringFieldController(),
  );
  late final questCompletionLogController = registerController(
    StringFieldController(),
  );
  late final requiredNpcOrGo1Controller = registerController(
    IntFieldController(),
  );
  late final requiredNpcOrGo2Controller = registerController(
    IntFieldController(),
  );
  late final requiredNpcOrGo3Controller = registerController(
    IntFieldController(),
  );
  late final requiredNpcOrGo4Controller = registerController(
    IntFieldController(),
  );
  late final requiredNpcOrGoCount1Controller = registerController(
    IntFieldController(),
  );
  late final requiredNpcOrGoCount2Controller = registerController(
    IntFieldController(),
  );
  late final requiredNpcOrGoCount3Controller = registerController(
    IntFieldController(),
  );
  late final requiredNpcOrGoCount4Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemId1Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemId2Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemId3Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemId4Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemId5Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemId6Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemCount1Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemCount2Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemCount3Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemCount4Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemCount5Controller = registerController(
    IntFieldController(),
  );
  late final requiredItemCount6Controller = registerController(
    IntFieldController(),
  );
  late final unknown0Controller = registerController(IntFieldController());
  late final objectiveText1Controller = registerController(
    StringFieldController(),
  );
  late final objectiveText2Controller = registerController(
    StringFieldController(),
  );
  late final objectiveText3Controller = registerController(
    StringFieldController(),
  );
  late final objectiveText4Controller = registerController(
    StringFieldController(),
  );
  late final verifiedBuildController = registerController(IntFieldController());

  QuestTemplateEntity _collectCandidate() {
    return QuestTemplateEntity(
      id: idController.collect(),
      questType: questTypeController.collect(),
      questLevel: questLevelController.collect(),
      minLevel: minLevelController.collect(),
      questSortId: questSortIdController.collect(),
      questInfoId: questInfoIdController.collect(),
      suggestedGroupNum: suggestedGroupNumController.collect(),
      requiredFactionId1: requiredFactionId1Controller.collect(),
      requiredFactionId2: requiredFactionId2Controller.collect(),
      requiredFactionValue1: requiredFactionValue1Controller.collect(),
      requiredFactionValue2: requiredFactionValue2Controller.collect(),
      rewardNextQuest: rewardNextQuestController.collect(),
      rewardXpDifficulty: rewardXpDifficultyController.collect(),
      rewardMoney: rewardMoneyController.collect(),
      rewardMoneyDifficulty: rewardMoneyDifficultyController.collect(),
      rewardDisplaySpell: rewardDisplaySpellController.collect(),
      rewardSpell: rewardSpellController.collect(),
      rewardHonor: rewardHonorController.collect(),
      rewardKillHonor: rewardKillHonorController.collect(),
      startItem: startItemController.collect(),
      flags: flagsController.collect(),
      requiredPlayerKills: requiredPlayerKillsController.collect(),
      rewardItem1: rewardItem1Controller.collect(),
      rewardAmount1: rewardAmount1Controller.collect(),
      rewardItem2: rewardItem2Controller.collect(),
      rewardAmount2: rewardAmount2Controller.collect(),
      rewardItem3: rewardItem3Controller.collect(),
      rewardAmount3: rewardAmount3Controller.collect(),
      rewardItem4: rewardItem4Controller.collect(),
      rewardAmount4: rewardAmount4Controller.collect(),
      itemDrop1: itemDrop1Controller.collect(),
      itemDropQuantity1: itemDropQuantity1Controller.collect(),
      itemDrop2: itemDrop2Controller.collect(),
      itemDropQuantity2: itemDropQuantity2Controller.collect(),
      itemDrop3: itemDrop3Controller.collect(),
      itemDropQuantity3: itemDropQuantity3Controller.collect(),
      itemDrop4: itemDrop4Controller.collect(),
      itemDropQuantity4: itemDropQuantity4Controller.collect(),
      rewardChoiceItemId1: rewardChoiceItemId1Controller.collect(),
      rewardChoiceItemQuantity1: rewardChoiceItemQuantity1Controller.collect(),
      rewardChoiceItemId2: rewardChoiceItemId2Controller.collect(),
      rewardChoiceItemQuantity2: rewardChoiceItemQuantity2Controller.collect(),
      rewardChoiceItemId3: rewardChoiceItemId3Controller.collect(),
      rewardChoiceItemQuantity3: rewardChoiceItemQuantity3Controller.collect(),
      rewardChoiceItemId4: rewardChoiceItemId4Controller.collect(),
      rewardChoiceItemQuantity4: rewardChoiceItemQuantity4Controller.collect(),
      rewardChoiceItemId5: rewardChoiceItemId5Controller.collect(),
      rewardChoiceItemQuantity5: rewardChoiceItemQuantity5Controller.collect(),
      rewardChoiceItemId6: rewardChoiceItemId6Controller.collect(),
      rewardChoiceItemQuantity6: rewardChoiceItemQuantity6Controller.collect(),
      poiContinent: poiContinentController.collect(),
      poiX: poiXController.collect(),
      poiY: poiYController.collect(),
      poiPriority: poiPriorityController.collect(),
      rewardTitle: rewardTitleController.collect(),
      rewardTalents: rewardTalentsController.collect(),
      rewardArenaPoints: rewardArenaPointsController.collect(),
      rewardFactionId1: rewardFactionId1Controller.collect(),
      rewardFactionValue1: rewardFactionValue1Controller.collect(),
      rewardFactionOverride1: rewardFactionOverride1Controller.collect(),
      rewardFactionId2: rewardFactionId2Controller.collect(),
      rewardFactionValue2: rewardFactionValue2Controller.collect(),
      rewardFactionOverride2: rewardFactionOverride2Controller.collect(),
      rewardFactionId3: rewardFactionId3Controller.collect(),
      rewardFactionValue3: rewardFactionValue3Controller.collect(),
      rewardFactionOverride3: rewardFactionOverride3Controller.collect(),
      rewardFactionId4: rewardFactionId4Controller.collect(),
      rewardFactionValue4: rewardFactionValue4Controller.collect(),
      rewardFactionOverride4: rewardFactionOverride4Controller.collect(),
      rewardFactionId5: rewardFactionId5Controller.collect(),
      rewardFactionValue5: rewardFactionValue5Controller.collect(),
      rewardFactionOverride5: rewardFactionOverride5Controller.collect(),
      timeAllowed: timeAllowedController.collect(),
      allowableRaces: allowableRacesController.collect(),
      logTitle: logTitleController.collect(),
      logDescription: logDescriptionController.collect(),
      questDescription: questDescriptionController.collect(),
      areaDescription: areaDescriptionController.collect(),
      questCompletionLog: questCompletionLogController.collect(),
      requiredNpcOrGo1: requiredNpcOrGo1Controller.collect(),
      requiredNpcOrGo2: requiredNpcOrGo2Controller.collect(),
      requiredNpcOrGo3: requiredNpcOrGo3Controller.collect(),
      requiredNpcOrGo4: requiredNpcOrGo4Controller.collect(),
      requiredNpcOrGoCount1: requiredNpcOrGoCount1Controller.collect(),
      requiredNpcOrGoCount2: requiredNpcOrGoCount2Controller.collect(),
      requiredNpcOrGoCount3: requiredNpcOrGoCount3Controller.collect(),
      requiredNpcOrGoCount4: requiredNpcOrGoCount4Controller.collect(),
      requiredItemId1: requiredItemId1Controller.collect(),
      requiredItemId2: requiredItemId2Controller.collect(),
      requiredItemId3: requiredItemId3Controller.collect(),
      requiredItemId4: requiredItemId4Controller.collect(),
      requiredItemId5: requiredItemId5Controller.collect(),
      requiredItemId6: requiredItemId6Controller.collect(),
      requiredItemCount1: requiredItemCount1Controller.collect(),
      requiredItemCount2: requiredItemCount2Controller.collect(),
      requiredItemCount3: requiredItemCount3Controller.collect(),
      requiredItemCount4: requiredItemCount4Controller.collect(),
      requiredItemCount5: requiredItemCount5Controller.collect(),
      requiredItemCount6: requiredItemCount6Controller.collect(),
      unknown0: unknown0Controller.collect(),
      objectiveText1: objectiveText1Controller.collect(),
      objectiveText2: objectiveText2Controller.collect(),
      objectiveText3: objectiveText3Controller.collect(),
      objectiveText4: objectiveText4Controller.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _applyCandidate(QuestTemplateEntity questTemplate) {
    idController.init(questTemplate.id);
    questTypeController.init(questTemplate.questType);
    questLevelController.init(questTemplate.questLevel);
    minLevelController.init(questTemplate.minLevel);
    questSortIdController.init(questTemplate.questSortId);
    questInfoIdController.init(questTemplate.questInfoId);
    suggestedGroupNumController.init(questTemplate.suggestedGroupNum);
    requiredFactionId1Controller.init(questTemplate.requiredFactionId1);
    requiredFactionId2Controller.init(questTemplate.requiredFactionId2);
    requiredFactionValue1Controller.init(questTemplate.requiredFactionValue1);
    requiredFactionValue2Controller.init(questTemplate.requiredFactionValue2);
    rewardNextQuestController.init(questTemplate.rewardNextQuest);
    rewardXpDifficultyController.init(questTemplate.rewardXpDifficulty);
    rewardMoneyController.init(questTemplate.rewardMoney);
    rewardMoneyDifficultyController.init(questTemplate.rewardMoneyDifficulty);
    rewardDisplaySpellController.init(questTemplate.rewardDisplaySpell);
    rewardSpellController.init(questTemplate.rewardSpell);
    rewardHonorController.init(questTemplate.rewardHonor);
    rewardKillHonorController.init(questTemplate.rewardKillHonor);
    startItemController.init(questTemplate.startItem);
    flagsController.init(questTemplate.flags);
    requiredPlayerKillsController.init(questTemplate.requiredPlayerKills);
    rewardItem1Controller.init(questTemplate.rewardItem1);
    rewardAmount1Controller.init(questTemplate.rewardAmount1);
    rewardItem2Controller.init(questTemplate.rewardItem2);
    rewardAmount2Controller.init(questTemplate.rewardAmount2);
    rewardItem3Controller.init(questTemplate.rewardItem3);
    rewardAmount3Controller.init(questTemplate.rewardAmount3);
    rewardItem4Controller.init(questTemplate.rewardItem4);
    rewardAmount4Controller.init(questTemplate.rewardAmount4);
    itemDrop1Controller.init(questTemplate.itemDrop1);
    itemDropQuantity1Controller.init(questTemplate.itemDropQuantity1);
    itemDrop2Controller.init(questTemplate.itemDrop2);
    itemDropQuantity2Controller.init(questTemplate.itemDropQuantity2);
    itemDrop3Controller.init(questTemplate.itemDrop3);
    itemDropQuantity3Controller.init(questTemplate.itemDropQuantity3);
    itemDrop4Controller.init(questTemplate.itemDrop4);
    itemDropQuantity4Controller.init(questTemplate.itemDropQuantity4);
    rewardChoiceItemId1Controller.init(questTemplate.rewardChoiceItemId1);
    rewardChoiceItemQuantity1Controller.init(
      questTemplate.rewardChoiceItemQuantity1,
    );
    rewardChoiceItemId2Controller.init(questTemplate.rewardChoiceItemId2);
    rewardChoiceItemQuantity2Controller.init(
      questTemplate.rewardChoiceItemQuantity2,
    );
    rewardChoiceItemId3Controller.init(questTemplate.rewardChoiceItemId3);
    rewardChoiceItemQuantity3Controller.init(
      questTemplate.rewardChoiceItemQuantity3,
    );
    rewardChoiceItemId4Controller.init(questTemplate.rewardChoiceItemId4);
    rewardChoiceItemQuantity4Controller.init(
      questTemplate.rewardChoiceItemQuantity4,
    );
    rewardChoiceItemId5Controller.init(questTemplate.rewardChoiceItemId5);
    rewardChoiceItemQuantity5Controller.init(
      questTemplate.rewardChoiceItemQuantity5,
    );
    rewardChoiceItemId6Controller.init(questTemplate.rewardChoiceItemId6);
    rewardChoiceItemQuantity6Controller.init(
      questTemplate.rewardChoiceItemQuantity6,
    );
    poiContinentController.init(questTemplate.poiContinent);
    poiXController.init(questTemplate.poiX);
    poiYController.init(questTemplate.poiY);
    poiPriorityController.init(questTemplate.poiPriority);
    rewardTitleController.init(questTemplate.rewardTitle);
    rewardTalentsController.init(questTemplate.rewardTalents);
    rewardArenaPointsController.init(questTemplate.rewardArenaPoints);
    rewardFactionId1Controller.init(questTemplate.rewardFactionId1);
    rewardFactionValue1Controller.init(questTemplate.rewardFactionValue1);
    rewardFactionOverride1Controller.init(questTemplate.rewardFactionOverride1);
    rewardFactionId2Controller.init(questTemplate.rewardFactionId2);
    rewardFactionValue2Controller.init(questTemplate.rewardFactionValue2);
    rewardFactionOverride2Controller.init(questTemplate.rewardFactionOverride2);
    rewardFactionId3Controller.init(questTemplate.rewardFactionId3);
    rewardFactionValue3Controller.init(questTemplate.rewardFactionValue3);
    rewardFactionOverride3Controller.init(questTemplate.rewardFactionOverride3);
    rewardFactionId4Controller.init(questTemplate.rewardFactionId4);
    rewardFactionValue4Controller.init(questTemplate.rewardFactionValue4);
    rewardFactionOverride4Controller.init(questTemplate.rewardFactionOverride4);
    rewardFactionId5Controller.init(questTemplate.rewardFactionId5);
    rewardFactionValue5Controller.init(questTemplate.rewardFactionValue5);
    rewardFactionOverride5Controller.init(questTemplate.rewardFactionOverride5);
    timeAllowedController.init(questTemplate.timeAllowed);
    allowableRacesController.init(questTemplate.allowableRaces);
    logTitleController.init(questTemplate.logTitle);
    logDescriptionController.init(questTemplate.logDescription);
    questDescriptionController.init(questTemplate.questDescription);
    areaDescriptionController.init(questTemplate.areaDescription);
    questCompletionLogController.init(questTemplate.questCompletionLog);
    requiredNpcOrGo1Controller.init(questTemplate.requiredNpcOrGo1);
    requiredNpcOrGo2Controller.init(questTemplate.requiredNpcOrGo2);
    requiredNpcOrGo3Controller.init(questTemplate.requiredNpcOrGo3);
    requiredNpcOrGo4Controller.init(questTemplate.requiredNpcOrGo4);
    requiredNpcOrGoCount1Controller.init(questTemplate.requiredNpcOrGoCount1);
    requiredNpcOrGoCount2Controller.init(questTemplate.requiredNpcOrGoCount2);
    requiredNpcOrGoCount3Controller.init(questTemplate.requiredNpcOrGoCount3);
    requiredNpcOrGoCount4Controller.init(questTemplate.requiredNpcOrGoCount4);
    requiredItemId1Controller.init(questTemplate.requiredItemId1);
    requiredItemId2Controller.init(questTemplate.requiredItemId2);
    requiredItemId3Controller.init(questTemplate.requiredItemId3);
    requiredItemId4Controller.init(questTemplate.requiredItemId4);
    requiredItemId5Controller.init(questTemplate.requiredItemId5);
    requiredItemId6Controller.init(questTemplate.requiredItemId6);
    requiredItemCount1Controller.init(questTemplate.requiredItemCount1);
    requiredItemCount2Controller.init(questTemplate.requiredItemCount2);
    requiredItemCount3Controller.init(questTemplate.requiredItemCount3);
    requiredItemCount4Controller.init(questTemplate.requiredItemCount4);
    requiredItemCount5Controller.init(questTemplate.requiredItemCount5);
    requiredItemCount6Controller.init(questTemplate.requiredItemCount6);
    unknown0Controller.init(questTemplate.unknown0);
    objectiveText1Controller.init(questTemplate.objectiveText1);
    objectiveText2Controller.init(questTemplate.objectiveText2);
    objectiveText3Controller.init(questTemplate.objectiveText3);
    objectiveText4Controller.init(questTemplate.objectiveText4);
    verifiedBuildController.init(questTemplate.verifiedBuild);
    _afterApplyCandidate(questTemplate);
  }

  void _afterApplyCandidate(QuestTemplateEntity questTemplate) {}
}
