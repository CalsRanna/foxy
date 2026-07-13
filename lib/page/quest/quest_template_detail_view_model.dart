import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestTemplateDetailViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<QuestTemplateRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final template = signal(QuestTemplateEntity());

  /// Basic (ints)
  late final idController = registerController(IntFieldController());
  late final questTypeController = registerController(IntFieldController());
  late final questLevelController = registerController(IntFieldController());
  late final minLevelController = registerController(IntFieldController());
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

  /// Basic (selector controllers)
  late final questSortIdController = registerController(IntFieldController());
  late final questInfoIdController = registerController(IntFieldController());

  /// Reward (ints + double)
  late final rewardNextQuestController = registerController(
    IntFieldController(),
  );
  late final rewardXpDifficultyController = registerController(
    IntFieldController(),
  );
  late final rewardMoneyController = registerController(IntFieldController());
  late final rewardMoneyDifficultyController = registerController(
    IntFieldController(),
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
  late final flagsController = registerController(IntFieldController());
  late final requiredPlayerKillsController = registerController(
    IntFieldController(),
  );

  /// RewardItem (ints)
  late final rewardItem1Controller = registerController(IntFieldController());
  late final rewardAmount1Controller = registerController(IntFieldController());
  late final rewardItem2Controller = registerController(IntFieldController());
  late final rewardAmount2Controller = registerController(IntFieldController());
  late final rewardItem3Controller = registerController(IntFieldController());
  late final rewardAmount3Controller = registerController(IntFieldController());
  late final rewardItem4Controller = registerController(IntFieldController());
  late final rewardAmount4Controller = registerController(IntFieldController());

  /// ItemDrop (ints)
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

  /// RewardChoiceItem (ints)
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

  /// POI (ints + doubles)
  late final poiContinentController = registerController(IntFieldController());
  late final poiXController = registerController(DoubleFieldController());
  late final poiYController = registerController(DoubleFieldController());
  late final poiPriorityController = registerController(IntFieldController());

  /// RewardTitle / Talents (ints)
  late final rewardTitleController = registerController(IntFieldController());
  late final rewardTalentsController = registerController(IntFieldController());
  late final rewardArenaPointsController = registerController(
    IntFieldController(),
  );

  /// RewardFaction (ints)
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

  /// Other int
  late final timeAllowedController = registerController(IntFieldController());
  late final allowableRacesController = registerController(
    IntFieldController(),
  );

  /// Text (string controllers)
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

  /// RequiredNpcOrGo (ints)
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

  /// RequiredItem (ints)
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

  /// Misc
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
    disposeControllers();
  }
}
