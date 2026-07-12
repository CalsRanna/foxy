import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestTemplateDetailViewModel {
  final _repository = GetIt.instance.get<QuestTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final template = signal(QuestTemplateEntity());

  /// Basic (ints)
  final idController = IntFieldController();
  final questTypeController = IntFieldController();
  final questLevelController = IntFieldController();
  final minLevelController = IntFieldController();
  final suggestedGroupNumController = IntFieldController();
  final requiredFactionId1Controller = IntFieldController();
  final requiredFactionId2Controller = IntFieldController();
  final requiredFactionValue1Controller = IntFieldController();
  final requiredFactionValue2Controller = IntFieldController();

  /// Basic (selector controllers)
  final questSortIdController = IntFieldController();
  final questInfoIdController = IntFieldController();

  /// Reward (ints + double)
  final rewardNextQuestController = IntFieldController();
  final rewardXpDifficultyController = IntFieldController();
  final rewardMoneyController = IntFieldController();
  final rewardMoneyDifficultyController = IntFieldController();
  final rewardDisplaySpellController = IntFieldController();
  final rewardSpellController = IntFieldController();
  final rewardHonorController = IntFieldController();
  final rewardKillHonorController = DoubleFieldController();
  final startItemController = IntFieldController();
  final flagsController = IntFieldController();
  final requiredPlayerKillsController = IntFieldController();

  /// RewardItem (ints)
  final rewardItem1Controller = IntFieldController();
  final rewardAmount1Controller = IntFieldController();
  final rewardItem2Controller = IntFieldController();
  final rewardAmount2Controller = IntFieldController();
  final rewardItem3Controller = IntFieldController();
  final rewardAmount3Controller = IntFieldController();
  final rewardItem4Controller = IntFieldController();
  final rewardAmount4Controller = IntFieldController();

  /// ItemDrop (ints)
  final itemDrop1Controller = IntFieldController();
  final itemDropQuantity1Controller = IntFieldController();
  final itemDrop2Controller = IntFieldController();
  final itemDropQuantity2Controller = IntFieldController();
  final itemDrop3Controller = IntFieldController();
  final itemDropQuantity3Controller = IntFieldController();
  final itemDrop4Controller = IntFieldController();
  final itemDropQuantity4Controller = IntFieldController();

  /// RewardChoiceItem (ints)
  final rewardChoiceItemId1Controller = IntFieldController();
  final rewardChoiceItemQuantity1Controller = IntFieldController();
  final rewardChoiceItemId2Controller = IntFieldController();
  final rewardChoiceItemQuantity2Controller = IntFieldController();
  final rewardChoiceItemId3Controller = IntFieldController();
  final rewardChoiceItemQuantity3Controller = IntFieldController();
  final rewardChoiceItemId4Controller = IntFieldController();
  final rewardChoiceItemQuantity4Controller = IntFieldController();
  final rewardChoiceItemId5Controller = IntFieldController();
  final rewardChoiceItemQuantity5Controller = IntFieldController();
  final rewardChoiceItemId6Controller = IntFieldController();
  final rewardChoiceItemQuantity6Controller = IntFieldController();

  /// POI (ints + doubles)
  final poiContinentController = IntFieldController();
  final poiXController = DoubleFieldController();
  final poiYController = DoubleFieldController();
  final poiPriorityController = IntFieldController();

  /// RewardTitle / Talents (ints)
  final rewardTitleController = IntFieldController();
  final rewardTalentsController = IntFieldController();
  final rewardArenaPointsController = IntFieldController();

  /// RewardFaction (ints)
  final rewardFactionId1Controller = IntFieldController();
  final rewardFactionValue1Controller = IntFieldController();
  final rewardFactionOverride1Controller = IntFieldController();
  final rewardFactionId2Controller = IntFieldController();
  final rewardFactionValue2Controller = IntFieldController();
  final rewardFactionOverride2Controller = IntFieldController();
  final rewardFactionId3Controller = IntFieldController();
  final rewardFactionValue3Controller = IntFieldController();
  final rewardFactionOverride3Controller = IntFieldController();
  final rewardFactionId4Controller = IntFieldController();
  final rewardFactionValue4Controller = IntFieldController();
  final rewardFactionOverride4Controller = IntFieldController();
  final rewardFactionId5Controller = IntFieldController();
  final rewardFactionValue5Controller = IntFieldController();
  final rewardFactionOverride5Controller = IntFieldController();

  /// Other int
  final timeAllowedController = IntFieldController();
  final allowableRacesController = IntFieldController();

  /// Text (string controllers)
  final logTitleController = StringFieldController();
  final logDescriptionController = StringFieldController();
  final questDescriptionController = StringFieldController();
  final areaDescriptionController = StringFieldController();
  final questCompletionLogController = StringFieldController();

  /// RequiredNpcOrGo (ints)
  final requiredNpcOrGo1Controller = IntFieldController();
  final requiredNpcOrGo2Controller = IntFieldController();
  final requiredNpcOrGo3Controller = IntFieldController();
  final requiredNpcOrGo4Controller = IntFieldController();
  final requiredNpcOrGoCount1Controller = IntFieldController();
  final requiredNpcOrGoCount2Controller = IntFieldController();
  final requiredNpcOrGoCount3Controller = IntFieldController();
  final requiredNpcOrGoCount4Controller = IntFieldController();

  /// RequiredItem (ints)
  final requiredItemId1Controller = IntFieldController();
  final requiredItemId2Controller = IntFieldController();
  final requiredItemId3Controller = IntFieldController();
  final requiredItemId4Controller = IntFieldController();
  final requiredItemId5Controller = IntFieldController();
  final requiredItemId6Controller = IntFieldController();
  final requiredItemCount1Controller = IntFieldController();
  final requiredItemCount2Controller = IntFieldController();
  final requiredItemCount3Controller = IntFieldController();
  final requiredItemCount4Controller = IntFieldController();
  final requiredItemCount5Controller = IntFieldController();
  final requiredItemCount6Controller = IntFieldController();

  /// Misc
  final unknown0Controller = IntFieldController();
  final objectiveText1Controller = StringFieldController();
  final objectiveText2Controller = StringFieldController();
  final objectiveText3Controller = StringFieldController();
  final objectiveText4Controller = StringFieldController();
  final verifiedBuildController = IntFieldController();

  late final _controllers = <FieldController>[
    idController,
    questTypeController,
    questLevelController,
    minLevelController,
    suggestedGroupNumController,
    requiredFactionId1Controller,
    requiredFactionId2Controller,
    requiredFactionValue1Controller,
    requiredFactionValue2Controller,
    questSortIdController,
    questInfoIdController,
    rewardNextQuestController,
    rewardXpDifficultyController,
    rewardMoneyController,
    rewardMoneyDifficultyController,
    rewardDisplaySpellController,
    rewardSpellController,
    rewardHonorController,
    rewardKillHonorController,
    startItemController,
    flagsController,
    requiredPlayerKillsController,
    rewardItem1Controller,
    rewardAmount1Controller,
    rewardItem2Controller,
    rewardAmount2Controller,
    rewardItem3Controller,
    rewardAmount3Controller,
    rewardItem4Controller,
    rewardAmount4Controller,
    itemDrop1Controller,
    itemDropQuantity1Controller,
    itemDrop2Controller,
    itemDropQuantity2Controller,
    itemDrop3Controller,
    itemDropQuantity3Controller,
    itemDrop4Controller,
    itemDropQuantity4Controller,
    rewardChoiceItemId1Controller,
    rewardChoiceItemQuantity1Controller,
    rewardChoiceItemId2Controller,
    rewardChoiceItemQuantity2Controller,
    rewardChoiceItemId3Controller,
    rewardChoiceItemQuantity3Controller,
    rewardChoiceItemId4Controller,
    rewardChoiceItemQuantity4Controller,
    rewardChoiceItemId5Controller,
    rewardChoiceItemQuantity5Controller,
    rewardChoiceItemId6Controller,
    rewardChoiceItemQuantity6Controller,
    poiContinentController,
    poiXController,
    poiYController,
    poiPriorityController,
    rewardTitleController,
    rewardTalentsController,
    rewardArenaPointsController,
    rewardFactionId1Controller,
    rewardFactionValue1Controller,
    rewardFactionOverride1Controller,
    rewardFactionId2Controller,
    rewardFactionValue2Controller,
    rewardFactionOverride2Controller,
    rewardFactionId3Controller,
    rewardFactionValue3Controller,
    rewardFactionOverride3Controller,
    rewardFactionId4Controller,
    rewardFactionValue4Controller,
    rewardFactionOverride4Controller,
    rewardFactionId5Controller,
    rewardFactionValue5Controller,
    rewardFactionOverride5Controller,
    timeAllowedController,
    allowableRacesController,
    logTitleController,
    logDescriptionController,
    questDescriptionController,
    areaDescriptionController,
    questCompletionLogController,
    requiredNpcOrGo1Controller,
    requiredNpcOrGo2Controller,
    requiredNpcOrGo3Controller,
    requiredNpcOrGo4Controller,
    requiredNpcOrGoCount1Controller,
    requiredNpcOrGoCount2Controller,
    requiredNpcOrGoCount3Controller,
    requiredNpcOrGoCount4Controller,
    requiredItemId1Controller,
    requiredItemId2Controller,
    requiredItemId3Controller,
    requiredItemId4Controller,
    requiredItemId5Controller,
    requiredItemId6Controller,
    requiredItemCount1Controller,
    requiredItemCount2Controller,
    requiredItemCount3Controller,
    requiredItemCount4Controller,
    requiredItemCount5Controller,
    requiredItemCount6Controller,
    unknown0Controller,
    objectiveText1Controller,
    objectiveText2Controller,
    objectiveText3Controller,
    objectiveText4Controller,
    verifiedBuildController,
  ];

  Future<void> save(BuildContext context) async {
    try {
      final t = _collect();
      final existed = await _repository.getQuestTemplate(t.id);
      if (existed == null) {
        final id = await _repository.storeQuestTemplate(t);
        idController.init(id);
        template.value = t.copyWith(id: id);
        entry.value = id;
        _logActivity(ActivityActionType.create, template.value);
      } else {
        await _repository.updateQuestTemplate(t);
        template.value = t;
        entry.value = t.id;
        _logActivity(ActivityActionType.update, t);
      }
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  Future<void> initSignals({int? questId}) async {
    try {
      if (questId == null || questId <= 0) {
        final blank = await _repository.createQuestTemplate();
        template.value = blank;
        entry.value = blank.id;
        _initSignals(blank);
        return;
      }
      final result = await _repository.getQuestTemplate(questId);
      if (result == null) return;
      template.value = result;
      entry.value = result.id;
      _initSignals(result);
    } catch (e) {
      LoggerUtil.instance.e('加载任务详情失败: $e');
      DialogUtil.instance.error('加载任务详情失败: $e');
    }
  }

  void _initSignals(QuestTemplateEntity t) {
    idController.init(t.id);
    questTypeController.init(t.questType);
    questLevelController.init(t.questLevel);
    minLevelController.init(t.minLevel);
    questSortIdController.init(t.questSortId);
    questInfoIdController.init(t.questInfoId);
    suggestedGroupNumController.init(t.suggestedGroupNum);
    requiredFactionId1Controller.init(t.requiredFactionId1);
    requiredFactionId2Controller.init(t.requiredFactionId2);
    requiredFactionValue1Controller.init(t.requiredFactionValue1);
    requiredFactionValue2Controller.init(t.requiredFactionValue2);

    rewardNextQuestController.init(t.rewardNextQuest);
    rewardXpDifficultyController.init(t.rewardXpDifficulty);
    rewardMoneyController.init(t.rewardMoney);
    rewardMoneyDifficultyController.init(t.rewardMoneyDifficulty);
    rewardDisplaySpellController.init(t.rewardDisplaySpell);
    rewardSpellController.init(t.rewardSpell);
    rewardHonorController.init(t.rewardHonor);
    rewardKillHonorController.init(t.rewardKillHonor);
    startItemController.init(t.startItem);
    flagsController.init(t.flags);
    requiredPlayerKillsController.init(t.requiredPlayerKills);

    rewardItem1Controller.init(t.rewardItem1);
    rewardAmount1Controller.init(t.rewardAmount1);
    rewardItem2Controller.init(t.rewardItem2);
    rewardAmount2Controller.init(t.rewardAmount2);
    rewardItem3Controller.init(t.rewardItem3);
    rewardAmount3Controller.init(t.rewardAmount3);
    rewardItem4Controller.init(t.rewardItem4);
    rewardAmount4Controller.init(t.rewardAmount4);

    itemDrop1Controller.init(t.itemDrop1);
    itemDropQuantity1Controller.init(t.itemDropQuantity1);
    itemDrop2Controller.init(t.itemDrop2);
    itemDropQuantity2Controller.init(t.itemDropQuantity2);
    itemDrop3Controller.init(t.itemDrop3);
    itemDropQuantity3Controller.init(t.itemDropQuantity3);
    itemDrop4Controller.init(t.itemDrop4);
    itemDropQuantity4Controller.init(t.itemDropQuantity4);

    rewardChoiceItemId1Controller.init(t.rewardChoiceItemId1);
    rewardChoiceItemQuantity1Controller.init(t.rewardChoiceItemQuantity1);
    rewardChoiceItemId2Controller.init(t.rewardChoiceItemId2);
    rewardChoiceItemQuantity2Controller.init(t.rewardChoiceItemQuantity2);
    rewardChoiceItemId3Controller.init(t.rewardChoiceItemId3);
    rewardChoiceItemQuantity3Controller.init(t.rewardChoiceItemQuantity3);
    rewardChoiceItemId4Controller.init(t.rewardChoiceItemId4);
    rewardChoiceItemQuantity4Controller.init(t.rewardChoiceItemQuantity4);
    rewardChoiceItemId5Controller.init(t.rewardChoiceItemId5);
    rewardChoiceItemQuantity5Controller.init(t.rewardChoiceItemQuantity5);
    rewardChoiceItemId6Controller.init(t.rewardChoiceItemId6);
    rewardChoiceItemQuantity6Controller.init(t.rewardChoiceItemQuantity6);

    poiContinentController.init(t.poiContinent);
    poiXController.init(t.poiX);
    poiYController.init(t.poiY);
    poiPriorityController.init(t.poiPriority);

    rewardTitleController.init(t.rewardTitle);
    rewardTalentsController.init(t.rewardTalents);
    rewardArenaPointsController.init(t.rewardArenaPoints);

    rewardFactionId1Controller.init(t.rewardFactionId1);
    rewardFactionValue1Controller.init(t.rewardFactionValue1);
    rewardFactionOverride1Controller.init(t.rewardFactionOverride1);
    rewardFactionId2Controller.init(t.rewardFactionId2);
    rewardFactionValue2Controller.init(t.rewardFactionValue2);
    rewardFactionOverride2Controller.init(t.rewardFactionOverride2);
    rewardFactionId3Controller.init(t.rewardFactionId3);
    rewardFactionValue3Controller.init(t.rewardFactionValue3);
    rewardFactionOverride3Controller.init(t.rewardFactionOverride3);
    rewardFactionId4Controller.init(t.rewardFactionId4);
    rewardFactionValue4Controller.init(t.rewardFactionValue4);
    rewardFactionOverride4Controller.init(t.rewardFactionOverride4);
    rewardFactionId5Controller.init(t.rewardFactionId5);
    rewardFactionValue5Controller.init(t.rewardFactionValue5);
    rewardFactionOverride5Controller.init(t.rewardFactionOverride5);

    timeAllowedController.init(t.timeAllowed);
    allowableRacesController.init(t.allowableRaces);

    logTitleController.init(t.logTitle);
    logDescriptionController.init(t.logDescription);
    questDescriptionController.init(t.questDescription);
    areaDescriptionController.init(t.areaDescription);
    questCompletionLogController.init(t.questCompletionLog);

    requiredNpcOrGo1Controller.init(t.requiredNpcOrGo1);
    requiredNpcOrGo2Controller.init(t.requiredNpcOrGo2);
    requiredNpcOrGo3Controller.init(t.requiredNpcOrGo3);
    requiredNpcOrGo4Controller.init(t.requiredNpcOrGo4);
    requiredNpcOrGoCount1Controller.init(t.requiredNpcOrGoCount1);
    requiredNpcOrGoCount2Controller.init(t.requiredNpcOrGoCount2);
    requiredNpcOrGoCount3Controller.init(t.requiredNpcOrGoCount3);
    requiredNpcOrGoCount4Controller.init(t.requiredNpcOrGoCount4);

    requiredItemId1Controller.init(t.requiredItemId1);
    requiredItemId2Controller.init(t.requiredItemId2);
    requiredItemId3Controller.init(t.requiredItemId3);
    requiredItemId4Controller.init(t.requiredItemId4);
    requiredItemId5Controller.init(t.requiredItemId5);
    requiredItemId6Controller.init(t.requiredItemId6);
    requiredItemCount1Controller.init(t.requiredItemCount1);
    requiredItemCount2Controller.init(t.requiredItemCount2);
    requiredItemCount3Controller.init(t.requiredItemCount3);
    requiredItemCount4Controller.init(t.requiredItemCount4);
    requiredItemCount5Controller.init(t.requiredItemCount5);
    requiredItemCount6Controller.init(t.requiredItemCount6);

    unknown0Controller.init(t.unknown0);
    objectiveText1Controller.init(t.objectiveText1);
    objectiveText2Controller.init(t.objectiveText2);
    objectiveText3Controller.init(t.objectiveText3);
    objectiveText4Controller.init(t.objectiveText4);
    verifiedBuildController.init(t.verifiedBuild);
  }

  QuestTemplateEntity _collect() {
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

  void _logActivity(ActivityActionType action, QuestTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_template',
      actionType: action,
      entityId: t.id,
      entityName: t.logTitle,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
