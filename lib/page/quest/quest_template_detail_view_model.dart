import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
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
  final idController = TextEditingController();
  final questTypeController = TextEditingController();
  final questLevelController = TextEditingController();
  final minLevelController = TextEditingController();
  final suggestedGroupNumController = TextEditingController();
  final requiredFactionId1Controller = TextEditingController();
  final requiredFactionId2Controller = TextEditingController();
  final requiredFactionValue1Controller = TextEditingController();
  final requiredFactionValue2Controller = TextEditingController();

  /// Basic (selector controllers — KEEP)
  final questSortIdController = TextEditingController();
  final questInfoId = signal<int>(0);

  /// Reward (ints)
  final rewardNextQuestController = TextEditingController();
  final rewardXpDifficultyController = TextEditingController();
  final rewardMoneyController = TextEditingController();
  final rewardMoneyDifficultyController = TextEditingController();
  final rewardDisplaySpellController = TextEditingController();
  final rewardSpellController = TextEditingController();
  final rewardHonorController = TextEditingController();
  final rewardKillHonorController = TextEditingController();
  final startItemController = TextEditingController();
  final flagsController = TextEditingController();
  final requiredPlayerKillsController = TextEditingController();

  /// RewardItem (ints)
  final rewardItem1Controller = TextEditingController();
  final rewardAmount1Controller = TextEditingController();
  final rewardItem2Controller = TextEditingController();
  final rewardAmount2Controller = TextEditingController();
  final rewardItem3Controller = TextEditingController();
  final rewardAmount3Controller = TextEditingController();
  final rewardItem4Controller = TextEditingController();
  final rewardAmount4Controller = TextEditingController();

  /// ItemDrop (ints)
  final itemDrop1Controller = TextEditingController();
  final itemDropQuantity1Controller = TextEditingController();
  final itemDrop2Controller = TextEditingController();
  final itemDropQuantity2Controller = TextEditingController();
  final itemDrop3Controller = TextEditingController();
  final itemDropQuantity3Controller = TextEditingController();
  final itemDrop4Controller = TextEditingController();
  final itemDropQuantity4Controller = TextEditingController();

  /// RewardChoiceItem (ints)
  final rewardChoiceItemId1Controller = TextEditingController();
  final rewardChoiceItemQuantity1Controller = TextEditingController();
  final rewardChoiceItemId2Controller = TextEditingController();
  final rewardChoiceItemQuantity2Controller = TextEditingController();
  final rewardChoiceItemId3Controller = TextEditingController();
  final rewardChoiceItemQuantity3Controller = TextEditingController();
  final rewardChoiceItemId4Controller = TextEditingController();
  final rewardChoiceItemQuantity4Controller = TextEditingController();
  final rewardChoiceItemId5Controller = TextEditingController();
  final rewardChoiceItemQuantity5Controller = TextEditingController();
  final rewardChoiceItemId6Controller = TextEditingController();
  final rewardChoiceItemQuantity6Controller = TextEditingController();

  /// POI (ints + doubles)
  final poiContinentController = TextEditingController();
  final poiXController = TextEditingController();
  final poiYController = TextEditingController();
  final poiPriorityController = TextEditingController();

  /// RewardTitle (selector signal) / Talents (ints)
  final rewardTitle = signal<int>(0);
  final rewardTalentsController = TextEditingController();
  final rewardArenaPointsController = TextEditingController();

  /// RewardFaction (ints)
  final rewardFactionId1Controller = TextEditingController();
  final rewardFactionValue1Controller = TextEditingController();
  final rewardFactionOverride1Controller = TextEditingController();
  final rewardFactionId2Controller = TextEditingController();
  final rewardFactionValue2Controller = TextEditingController();
  final rewardFactionOverride2Controller = TextEditingController();
  final rewardFactionId3Controller = TextEditingController();
  final rewardFactionValue3Controller = TextEditingController();
  final rewardFactionOverride3Controller = TextEditingController();
  final rewardFactionId4Controller = TextEditingController();
  final rewardFactionValue4Controller = TextEditingController();
  final rewardFactionOverride4Controller = TextEditingController();
  final rewardFactionId5Controller = TextEditingController();
  final rewardFactionValue5Controller = TextEditingController();
  final rewardFactionOverride5Controller = TextEditingController();

  /// Other int
  final timeAllowedController = TextEditingController();
  final allowableRacesController = TextEditingController();

  /// Text (string controllers — KEEP)
  final logTitleController = TextEditingController();
  final logDescriptionController = TextEditingController();
  final questDescriptionController = TextEditingController();
  final areaDescriptionController = TextEditingController();
  final questCompletionLogController = TextEditingController();

  /// RequiredNpcOrGo (ints)
  final requiredNpcOrGo1Controller = TextEditingController();
  final requiredNpcOrGo2Controller = TextEditingController();
  final requiredNpcOrGo3Controller = TextEditingController();
  final requiredNpcOrGo4Controller = TextEditingController();
  final requiredNpcOrGoCount1Controller = TextEditingController();
  final requiredNpcOrGoCount2Controller = TextEditingController();
  final requiredNpcOrGoCount3Controller = TextEditingController();
  final requiredNpcOrGoCount4Controller = TextEditingController();

  /// RequiredItem (ints)
  final requiredItemId1Controller = TextEditingController();
  final requiredItemId2Controller = TextEditingController();
  final requiredItemId3Controller = TextEditingController();
  final requiredItemId4Controller = TextEditingController();
  final requiredItemId5Controller = TextEditingController();
  final requiredItemId6Controller = TextEditingController();
  final requiredItemCount1Controller = TextEditingController();
  final requiredItemCount2Controller = TextEditingController();
  final requiredItemCount3Controller = TextEditingController();
  final requiredItemCount4Controller = TextEditingController();
  final requiredItemCount5Controller = TextEditingController();
  final requiredItemCount6Controller = TextEditingController();

  /// Misc
  final unknown0Controller = TextEditingController();
  final objectiveText1Controller = TextEditingController();
  final objectiveText2Controller = TextEditingController();
  final objectiveText3Controller = TextEditingController();
  final objectiveText4Controller = TextEditingController();
  final verifiedBuildController = TextEditingController();

  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;
  double _pd(String t) => double.tryParse(t) ?? 0.0;

  Future<void> save(BuildContext context) async {
    try {
      final t = _collect();
      if (t.id == 0) {
        await _repository.storeQuestTemplate(t);
      } else {
        await _repository.updateQuestTemplate(t);
      }
      template.value = t;
      entry.value = t.id;
      _logActivity(
        t.id == 0 ? ActivityActionType.create : ActivityActionType.update,
        t,
      );
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
    if (questId == null) return;
    try {
      template.value = await _repository.getQuestTemplate(questId);
      _initSignals(template.value);
    } catch (e) {
      LoggerUtil.instance.e('加载任务详情失败: $e');
      DialogUtil.instance.error('加载任务详情失败: $e');
    }
  }

  void _initSignals(QuestTemplateEntity t) {
    idController.text = _fmt(t.id);
    questTypeController.text = _fmt(t.questType);
    questLevelController.text = _fmt(t.questLevel);
    minLevelController.text = _fmt(t.minLevel);
    questSortIdController.text = t.questSortId.toString();
    questInfoId.value = t.questInfoId;
    suggestedGroupNumController.text = _fmt(t.suggestedGroupNum);
    requiredFactionId1Controller.text = _fmt(t.requiredFactionId1);
    requiredFactionId2Controller.text = _fmt(t.requiredFactionId2);
    requiredFactionValue1Controller.text = _fmt(t.requiredFactionValue1);
    requiredFactionValue2Controller.text = _fmt(t.requiredFactionValue2);

    rewardNextQuestController.text = _fmt(t.rewardNextQuest);
    rewardXpDifficultyController.text = _fmt(t.rewardXpDifficulty);
    rewardMoneyController.text = _fmt(t.rewardMoney);
    rewardMoneyDifficultyController.text = _fmt(t.rewardMoneyDifficulty);
    rewardDisplaySpellController.text = _fmt(t.rewardDisplaySpell);
    rewardSpellController.text = _fmt(t.rewardSpell);
    rewardHonorController.text = _fmt(t.rewardHonor);
    rewardKillHonorController.text = _fmt(t.rewardKillHonor);
    startItemController.text = _fmt(t.startItem);
    flagsController.text = _fmt(t.flags);
    requiredPlayerKillsController.text = _fmt(t.requiredPlayerKills);

    rewardItem1Controller.text = _fmt(t.rewardItem1);
    rewardAmount1Controller.text = _fmt(t.rewardAmount1);
    rewardItem2Controller.text = _fmt(t.rewardItem2);
    rewardAmount2Controller.text = _fmt(t.rewardAmount2);
    rewardItem3Controller.text = _fmt(t.rewardItem3);
    rewardAmount3Controller.text = _fmt(t.rewardAmount3);
    rewardItem4Controller.text = _fmt(t.rewardItem4);
    rewardAmount4Controller.text = _fmt(t.rewardAmount4);

    itemDrop1Controller.text = _fmt(t.itemDrop1);
    itemDropQuantity1Controller.text = _fmt(t.itemDropQuantity1);
    itemDrop2Controller.text = _fmt(t.itemDrop2);
    itemDropQuantity2Controller.text = _fmt(t.itemDropQuantity2);
    itemDrop3Controller.text = _fmt(t.itemDrop3);
    itemDropQuantity3Controller.text = _fmt(t.itemDropQuantity3);
    itemDrop4Controller.text = _fmt(t.itemDrop4);
    itemDropQuantity4Controller.text = _fmt(t.itemDropQuantity4);

    rewardChoiceItemId1Controller.text = _fmt(t.rewardChoiceItemId1);
    rewardChoiceItemQuantity1Controller.text = _fmt(t.rewardChoiceItemQuantity1);
    rewardChoiceItemId2Controller.text = _fmt(t.rewardChoiceItemId2);
    rewardChoiceItemQuantity2Controller.text = _fmt(t.rewardChoiceItemQuantity2);
    rewardChoiceItemId3Controller.text = _fmt(t.rewardChoiceItemId3);
    rewardChoiceItemQuantity3Controller.text = _fmt(t.rewardChoiceItemQuantity3);
    rewardChoiceItemId4Controller.text = _fmt(t.rewardChoiceItemId4);
    rewardChoiceItemQuantity4Controller.text = _fmt(t.rewardChoiceItemQuantity4);
    rewardChoiceItemId5Controller.text = _fmt(t.rewardChoiceItemId5);
    rewardChoiceItemQuantity5Controller.text = _fmt(t.rewardChoiceItemQuantity5);
    rewardChoiceItemId6Controller.text = _fmt(t.rewardChoiceItemId6);
    rewardChoiceItemQuantity6Controller.text = _fmt(t.rewardChoiceItemQuantity6);

    poiContinentController.text = _fmt(t.poiContinent);
    poiXController.text = _fmt(t.poiX);
    poiYController.text = _fmt(t.poiY);
    poiPriorityController.text = _fmt(t.poiPriority);

    rewardTitle.value = t.rewardTitle;
    rewardTalentsController.text = _fmt(t.rewardTalents);
    rewardArenaPointsController.text = _fmt(t.rewardArenaPoints);

    rewardFactionId1Controller.text = _fmt(t.rewardFactionId1);
    rewardFactionValue1Controller.text = _fmt(t.rewardFactionValue1);
    rewardFactionOverride1Controller.text = _fmt(t.rewardFactionOverride1);
    rewardFactionId2Controller.text = _fmt(t.rewardFactionId2);
    rewardFactionValue2Controller.text = _fmt(t.rewardFactionValue2);
    rewardFactionOverride2Controller.text = _fmt(t.rewardFactionOverride2);
    rewardFactionId3Controller.text = _fmt(t.rewardFactionId3);
    rewardFactionValue3Controller.text = _fmt(t.rewardFactionValue3);
    rewardFactionOverride3Controller.text = _fmt(t.rewardFactionOverride3);
    rewardFactionId4Controller.text = _fmt(t.rewardFactionId4);
    rewardFactionValue4Controller.text = _fmt(t.rewardFactionValue4);
    rewardFactionOverride4Controller.text = _fmt(t.rewardFactionOverride4);
    rewardFactionId5Controller.text = _fmt(t.rewardFactionId5);
    rewardFactionValue5Controller.text = _fmt(t.rewardFactionValue5);
    rewardFactionOverride5Controller.text = _fmt(t.rewardFactionOverride5);

    timeAllowedController.text = _fmt(t.timeAllowed);
    allowableRacesController.text = _fmt(t.allowableRaces);

    logTitleController.text = t.logTitle;
    logDescriptionController.text = t.logDescription;
    questDescriptionController.text = t.questDescription;
    areaDescriptionController.text = t.areaDescription;
    questCompletionLogController.text = t.questCompletionLog;

    requiredNpcOrGo1Controller.text = _fmt(t.requiredNpcOrGo1);
    requiredNpcOrGo2Controller.text = _fmt(t.requiredNpcOrGo2);
    requiredNpcOrGo3Controller.text = _fmt(t.requiredNpcOrGo3);
    requiredNpcOrGo4Controller.text = _fmt(t.requiredNpcOrGo4);
    requiredNpcOrGoCount1Controller.text = _fmt(t.requiredNpcOrGoCount1);
    requiredNpcOrGoCount2Controller.text = _fmt(t.requiredNpcOrGoCount2);
    requiredNpcOrGoCount3Controller.text = _fmt(t.requiredNpcOrGoCount3);
    requiredNpcOrGoCount4Controller.text = _fmt(t.requiredNpcOrGoCount4);

    requiredItemId1Controller.text = _fmt(t.requiredItemId1);
    requiredItemId2Controller.text = _fmt(t.requiredItemId2);
    requiredItemId3Controller.text = _fmt(t.requiredItemId3);
    requiredItemId4Controller.text = _fmt(t.requiredItemId4);
    requiredItemId5Controller.text = _fmt(t.requiredItemId5);
    requiredItemId6Controller.text = _fmt(t.requiredItemId6);
    requiredItemCount1Controller.text = _fmt(t.requiredItemCount1);
    requiredItemCount2Controller.text = _fmt(t.requiredItemCount2);
    requiredItemCount3Controller.text = _fmt(t.requiredItemCount3);
    requiredItemCount4Controller.text = _fmt(t.requiredItemCount4);
    requiredItemCount5Controller.text = _fmt(t.requiredItemCount5);
    requiredItemCount6Controller.text = _fmt(t.requiredItemCount6);

    unknown0Controller.text = _fmt(t.unknown0);
    objectiveText1Controller.text = t.objectiveText1;
    objectiveText2Controller.text = t.objectiveText2;
    objectiveText3Controller.text = t.objectiveText3;
    objectiveText4Controller.text = t.objectiveText4;
    verifiedBuildController.text = t.verifiedBuild.toString();
  }

  QuestTemplateEntity _collect() {
    return QuestTemplateEntity(
      id: _pi(idController.text),
      questType: _pi(questTypeController.text),
      questLevel: _pi(questLevelController.text),
      minLevel: _pi(minLevelController.text),
      questSortId: _parseInt(questSortIdController.text),
      questInfoId: questInfoId.value,
      suggestedGroupNum: _pi(suggestedGroupNumController.text),
      requiredFactionId1: _pi(requiredFactionId1Controller.text),
      requiredFactionId2: _pi(requiredFactionId2Controller.text),
      requiredFactionValue1: _pi(requiredFactionValue1Controller.text),
      requiredFactionValue2: _pi(requiredFactionValue2Controller.text),
      rewardNextQuest: _pi(rewardNextQuestController.text),
      rewardXpDifficulty: _pi(rewardXpDifficultyController.text),
      rewardMoney: _pi(rewardMoneyController.text),
      rewardMoneyDifficulty: _pi(rewardMoneyDifficultyController.text),
      rewardDisplaySpell: _pi(rewardDisplaySpellController.text),
      rewardSpell: _pi(rewardSpellController.text),
      rewardHonor: _pi(rewardHonorController.text),
      rewardKillHonor: _pd(rewardKillHonorController.text),
      startItem: _pi(startItemController.text),
      flags: _pi(flagsController.text),
      requiredPlayerKills: _pi(requiredPlayerKillsController.text),
      rewardItem1: _pi(rewardItem1Controller.text),
      rewardAmount1: _pi(rewardAmount1Controller.text),
      rewardItem2: _pi(rewardItem2Controller.text),
      rewardAmount2: _pi(rewardAmount2Controller.text),
      rewardItem3: _pi(rewardItem3Controller.text),
      rewardAmount3: _pi(rewardAmount3Controller.text),
      rewardItem4: _pi(rewardItem4Controller.text),
      rewardAmount4: _pi(rewardAmount4Controller.text),
      itemDrop1: _pi(itemDrop1Controller.text),
      itemDropQuantity1: _pi(itemDropQuantity1Controller.text),
      itemDrop2: _pi(itemDrop2Controller.text),
      itemDropQuantity2: _pi(itemDropQuantity2Controller.text),
      itemDrop3: _pi(itemDrop3Controller.text),
      itemDropQuantity3: _pi(itemDropQuantity3Controller.text),
      itemDrop4: _pi(itemDrop4Controller.text),
      itemDropQuantity4: _pi(itemDropQuantity4Controller.text),
      rewardChoiceItemId1: _pi(rewardChoiceItemId1Controller.text),
      rewardChoiceItemQuantity1: _pi(rewardChoiceItemQuantity1Controller.text),
      rewardChoiceItemId2: _pi(rewardChoiceItemId2Controller.text),
      rewardChoiceItemQuantity2: _pi(rewardChoiceItemQuantity2Controller.text),
      rewardChoiceItemId3: _pi(rewardChoiceItemId3Controller.text),
      rewardChoiceItemQuantity3: _pi(rewardChoiceItemQuantity3Controller.text),
      rewardChoiceItemId4: _pi(rewardChoiceItemId4Controller.text),
      rewardChoiceItemQuantity4: _pi(rewardChoiceItemQuantity4Controller.text),
      rewardChoiceItemId5: _pi(rewardChoiceItemId5Controller.text),
      rewardChoiceItemQuantity5: _pi(rewardChoiceItemQuantity5Controller.text),
      rewardChoiceItemId6: _pi(rewardChoiceItemId6Controller.text),
      rewardChoiceItemQuantity6: _pi(rewardChoiceItemQuantity6Controller.text),
      poiContinent: _pi(poiContinentController.text),
      poiX: _pd(poiXController.text),
      poiY: _pd(poiYController.text),
      poiPriority: _pi(poiPriorityController.text),
      rewardTitle: rewardTitle.value,
      rewardTalents: _pi(rewardTalentsController.text),
      rewardArenaPoints: _pi(rewardArenaPointsController.text),
      rewardFactionId1: _pi(rewardFactionId1Controller.text),
      rewardFactionValue1: _pi(rewardFactionValue1Controller.text),
      rewardFactionOverride1: _pi(rewardFactionOverride1Controller.text),
      rewardFactionId2: _pi(rewardFactionId2Controller.text),
      rewardFactionValue2: _pi(rewardFactionValue2Controller.text),
      rewardFactionOverride2: _pi(rewardFactionOverride2Controller.text),
      rewardFactionId3: _pi(rewardFactionId3Controller.text),
      rewardFactionValue3: _pi(rewardFactionValue3Controller.text),
      rewardFactionOverride3: _pi(rewardFactionOverride3Controller.text),
      rewardFactionId4: _pi(rewardFactionId4Controller.text),
      rewardFactionValue4: _pi(rewardFactionValue4Controller.text),
      rewardFactionOverride4: _pi(rewardFactionOverride4Controller.text),
      rewardFactionId5: _pi(rewardFactionId5Controller.text),
      rewardFactionValue5: _pi(rewardFactionValue5Controller.text),
      rewardFactionOverride5: _pi(rewardFactionOverride5Controller.text),
      timeAllowed: _pi(timeAllowedController.text),
      allowableRaces: _pi(allowableRacesController.text),
      logTitle: logTitleController.text,
      logDescription: logDescriptionController.text,
      questDescription: questDescriptionController.text,
      areaDescription: areaDescriptionController.text,
      questCompletionLog: questCompletionLogController.text,
      requiredNpcOrGo1: _pi(requiredNpcOrGo1Controller.text),
      requiredNpcOrGo2: _pi(requiredNpcOrGo2Controller.text),
      requiredNpcOrGo3: _pi(requiredNpcOrGo3Controller.text),
      requiredNpcOrGo4: _pi(requiredNpcOrGo4Controller.text),
      requiredNpcOrGoCount1: _pi(requiredNpcOrGoCount1Controller.text),
      requiredNpcOrGoCount2: _pi(requiredNpcOrGoCount2Controller.text),
      requiredNpcOrGoCount3: _pi(requiredNpcOrGoCount3Controller.text),
      requiredNpcOrGoCount4: _pi(requiredNpcOrGoCount4Controller.text),
      requiredItemId1: _pi(requiredItemId1Controller.text),
      requiredItemId2: _pi(requiredItemId2Controller.text),
      requiredItemId3: _pi(requiredItemId3Controller.text),
      requiredItemId4: _pi(requiredItemId4Controller.text),
      requiredItemId5: _pi(requiredItemId5Controller.text),
      requiredItemId6: _pi(requiredItemId6Controller.text),
      requiredItemCount1: _pi(requiredItemCount1Controller.text),
      requiredItemCount2: _pi(requiredItemCount2Controller.text),
      requiredItemCount3: _pi(requiredItemCount3Controller.text),
      requiredItemCount4: _pi(requiredItemCount4Controller.text),
      requiredItemCount5: _pi(requiredItemCount5Controller.text),
      requiredItemCount6: _pi(requiredItemCount6Controller.text),
      unknown0: _pi(unknown0Controller.text),
      objectiveText1: objectiveText1Controller.text,
      objectiveText2: objectiveText2Controller.text,
      objectiveText3: objectiveText3Controller.text,
      objectiveText4: objectiveText4Controller.text,
      verifiedBuild: int.tryParse(verifiedBuildController.text) ?? 0,
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }


  void _logActivity(ActivityActionType action, QuestTemplateEntity t) {
    final log = ActivityLogEntity(
      module: 'quest_template',
      actionType: action,
      entityId: t.id,
      entityName: t.logTitle,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  void dispose() {
    allowableRacesController.dispose();
    areaDescriptionController.dispose();
    flagsController.dispose();
    idController.dispose();
    itemDrop1Controller.dispose();
    itemDrop2Controller.dispose();
    itemDrop3Controller.dispose();
    itemDrop4Controller.dispose();
    itemDropQuantity1Controller.dispose();
    itemDropQuantity2Controller.dispose();
    itemDropQuantity3Controller.dispose();
    itemDropQuantity4Controller.dispose();
    logDescriptionController.dispose();
    logTitleController.dispose();
    minLevelController.dispose();
    objectiveText1Controller.dispose();
    objectiveText2Controller.dispose();
    objectiveText3Controller.dispose();
    objectiveText4Controller.dispose();
    poiContinentController.dispose();
    poiPriorityController.dispose();
    poiXController.dispose();
    poiYController.dispose();
    questCompletionLogController.dispose();
    questDescriptionController.dispose();
    questLevelController.dispose();
    questSortIdController.dispose();
    questTypeController.dispose();
    requiredFactionId1Controller.dispose();
    requiredFactionId2Controller.dispose();
    requiredFactionValue1Controller.dispose();
    requiredFactionValue2Controller.dispose();
    requiredItemCount1Controller.dispose();
    requiredItemCount2Controller.dispose();
    requiredItemCount3Controller.dispose();
    requiredItemCount4Controller.dispose();
    requiredItemCount5Controller.dispose();
    requiredItemCount6Controller.dispose();
    requiredItemId1Controller.dispose();
    requiredItemId2Controller.dispose();
    requiredItemId3Controller.dispose();
    requiredItemId4Controller.dispose();
    requiredItemId5Controller.dispose();
    requiredItemId6Controller.dispose();
    requiredNpcOrGo1Controller.dispose();
    requiredNpcOrGo2Controller.dispose();
    requiredNpcOrGo3Controller.dispose();
    requiredNpcOrGo4Controller.dispose();
    requiredNpcOrGoCount1Controller.dispose();
    requiredNpcOrGoCount2Controller.dispose();
    requiredNpcOrGoCount3Controller.dispose();
    requiredNpcOrGoCount4Controller.dispose();
    requiredPlayerKillsController.dispose();
    rewardAmount1Controller.dispose();
    rewardAmount2Controller.dispose();
    rewardAmount3Controller.dispose();
    rewardAmount4Controller.dispose();
    rewardArenaPointsController.dispose();
    rewardChoiceItemId1Controller.dispose();
    rewardChoiceItemId2Controller.dispose();
    rewardChoiceItemId3Controller.dispose();
    rewardChoiceItemId4Controller.dispose();
    rewardChoiceItemId5Controller.dispose();
    rewardChoiceItemId6Controller.dispose();
    rewardChoiceItemQuantity1Controller.dispose();
    rewardChoiceItemQuantity2Controller.dispose();
    rewardChoiceItemQuantity3Controller.dispose();
    rewardChoiceItemQuantity4Controller.dispose();
    rewardChoiceItemQuantity5Controller.dispose();
    rewardChoiceItemQuantity6Controller.dispose();
    rewardDisplaySpellController.dispose();
    rewardFactionId1Controller.dispose();
    rewardFactionId2Controller.dispose();
    rewardFactionId3Controller.dispose();
    rewardFactionId4Controller.dispose();
    rewardFactionId5Controller.dispose();
    rewardFactionOverride1Controller.dispose();
    rewardFactionOverride2Controller.dispose();
    rewardFactionOverride3Controller.dispose();
    rewardFactionOverride4Controller.dispose();
    rewardFactionOverride5Controller.dispose();
    rewardFactionValue1Controller.dispose();
    rewardFactionValue2Controller.dispose();
    rewardFactionValue3Controller.dispose();
    rewardFactionValue4Controller.dispose();
    rewardFactionValue5Controller.dispose();
    rewardHonorController.dispose();
    rewardItem1Controller.dispose();
    rewardItem2Controller.dispose();
    rewardItem3Controller.dispose();
    rewardItem4Controller.dispose();
    rewardKillHonorController.dispose();
    rewardMoneyController.dispose();
    rewardMoneyDifficultyController.dispose();
    rewardNextQuestController.dispose();
    rewardSpellController.dispose();
    rewardTalentsController.dispose();
    rewardXpDifficultyController.dispose();
    startItemController.dispose();
    suggestedGroupNumController.dispose();
    timeAllowedController.dispose();
    unknown0Controller.dispose();
    verifiedBuildController.dispose();
  }
}
