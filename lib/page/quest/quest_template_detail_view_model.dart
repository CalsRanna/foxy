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
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final template = signal(QuestTemplateEntity());

  /// Basic (ints)
  final id = signal<int>(0);
  final questType = signal<int>(0);
  final questLevel = signal<int>(0);
  final minLevel = signal<int>(0);
  final suggestedGroupNum = signal<int>(0);
  final requiredFactionId1 = signal<int>(0);
  final requiredFactionId2 = signal<int>(0);
  final requiredFactionValue1 = signal<int>(0);
  final requiredFactionValue2 = signal<int>(0);

  /// Basic (selector controllers — KEEP)
  final questSortIdController = TextEditingController();
  final questInfoIdController = TextEditingController();

  /// Reward (ints)
  final rewardNextQuest = signal<int>(0);
  final rewardXpDifficulty = signal<int>(0);
  final rewardMoney = signal<int>(0);
  final rewardMoneyDifficulty = signal<int>(0);
  final rewardDisplaySpell = signal<int>(0);
  final rewardSpell = signal<int>(0);
  final rewardHonor = signal<int>(0);
  final rewardKillHonor = signal<double>(0.0);
  final startItem = signal<int>(0);
  final flags = signal<int>(0);
  final requiredPlayerKills = signal<int>(0);

  /// RewardItem (ints)
  final rewardItem1 = signal<int>(0);
  final rewardAmount1 = signal<int>(0);
  final rewardItem2 = signal<int>(0);
  final rewardAmount2 = signal<int>(0);
  final rewardItem3 = signal<int>(0);
  final rewardAmount3 = signal<int>(0);
  final rewardItem4 = signal<int>(0);
  final rewardAmount4 = signal<int>(0);

  /// ItemDrop (ints)
  final itemDrop1 = signal<int>(0);
  final itemDropQuantity1 = signal<int>(0);
  final itemDrop2 = signal<int>(0);
  final itemDropQuantity2 = signal<int>(0);
  final itemDrop3 = signal<int>(0);
  final itemDropQuantity3 = signal<int>(0);
  final itemDrop4 = signal<int>(0);
  final itemDropQuantity4 = signal<int>(0);

  /// RewardChoiceItem (ints)
  final rewardChoiceItemId1 = signal<int>(0);
  final rewardChoiceItemQuantity1 = signal<int>(0);
  final rewardChoiceItemId2 = signal<int>(0);
  final rewardChoiceItemQuantity2 = signal<int>(0);
  final rewardChoiceItemId3 = signal<int>(0);
  final rewardChoiceItemQuantity3 = signal<int>(0);
  final rewardChoiceItemId4 = signal<int>(0);
  final rewardChoiceItemQuantity4 = signal<int>(0);
  final rewardChoiceItemId5 = signal<int>(0);
  final rewardChoiceItemQuantity5 = signal<int>(0);
  final rewardChoiceItemId6 = signal<int>(0);
  final rewardChoiceItemQuantity6 = signal<int>(0);

  /// POI (ints + doubles)
  final poiContinent = signal<int>(0);
  final poiX = signal<double>(0.0);
  final poiY = signal<double>(0.0);
  final poiPriority = signal<int>(0);

  /// RewardTitle (selector controller) / Talents (ints)
  final rewardTitleController = TextEditingController();
  final rewardTalents = signal<int>(0);
  final rewardArenaPoints = signal<int>(0);

  /// RewardFaction (ints)
  final rewardFactionId1 = signal<int>(0);
  final rewardFactionValue1 = signal<int>(0);
  final rewardFactionOverride1 = signal<int>(0);
  final rewardFactionId2 = signal<int>(0);
  final rewardFactionValue2 = signal<int>(0);
  final rewardFactionOverride2 = signal<int>(0);
  final rewardFactionId3 = signal<int>(0);
  final rewardFactionValue3 = signal<int>(0);
  final rewardFactionOverride3 = signal<int>(0);
  final rewardFactionId4 = signal<int>(0);
  final rewardFactionValue4 = signal<int>(0);
  final rewardFactionOverride4 = signal<int>(0);
  final rewardFactionId5 = signal<int>(0);
  final rewardFactionValue5 = signal<int>(0);
  final rewardFactionOverride5 = signal<int>(0);

  /// Other int
  final timeAllowed = signal<int>(0);
  final allowableRaces = signal<int>(0);

  /// Text (string controllers — KEEP)
  final logTitleController = TextEditingController();
  final logDescriptionController = TextEditingController();
  final questDescriptionController = TextEditingController();
  final areaDescriptionController = TextEditingController();
  final questCompletionLogController = TextEditingController();

  /// RequiredNpcOrGo (ints)
  final requiredNpcOrGo1 = signal<int>(0);
  final requiredNpcOrGo2 = signal<int>(0);
  final requiredNpcOrGo3 = signal<int>(0);
  final requiredNpcOrGo4 = signal<int>(0);
  final requiredNpcOrGoCount1 = signal<int>(0);
  final requiredNpcOrGoCount2 = signal<int>(0);
  final requiredNpcOrGoCount3 = signal<int>(0);
  final requiredNpcOrGoCount4 = signal<int>(0);

  /// RequiredItem (ints)
  final requiredItemId1 = signal<int>(0);
  final requiredItemId2 = signal<int>(0);
  final requiredItemId3 = signal<int>(0);
  final requiredItemId4 = signal<int>(0);
  final requiredItemId5 = signal<int>(0);
  final requiredItemId6 = signal<int>(0);
  final requiredItemCount1 = signal<int>(0);
  final requiredItemCount2 = signal<int>(0);
  final requiredItemCount3 = signal<int>(0);
  final requiredItemCount4 = signal<int>(0);
  final requiredItemCount5 = signal<int>(0);
  final requiredItemCount6 = signal<int>(0);

  /// Misc
  final unknown0 = signal<int>(0);
  final objectiveText1Controller = TextEditingController();
  final objectiveText2Controller = TextEditingController();
  final objectiveText3Controller = TextEditingController();
  final objectiveText4Controller = TextEditingController();
  final verifiedBuildController = TextEditingController();

  Future<void> save(BuildContext context) async {
    try {
      final t = _collect();
      final repository = QuestTemplateRepository();
      if (t.id == 0) {
        await repository.storeQuestTemplate(t);
      } else {
        await repository.updateQuestTemplate(t);
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
      template.value = await QuestTemplateRepository().getQuestTemplate(questId);
      _initSignals(template.value);
    } catch (e) {
      LoggerUtil.instance.e('加载任务详情失败: $e');
      DialogUtil.instance.error('加载任务详情失败: $e');
    }
  }

  void _initSignals(QuestTemplateEntity t) {
    id.value = t.id;
    questType.value = t.questType;
    questLevel.value = t.questLevel;
    minLevel.value = t.minLevel;
    questSortIdController.text = t.questSortId.toString();
    questInfoIdController.text = t.questInfoId.toString();
    suggestedGroupNum.value = t.suggestedGroupNum;
    requiredFactionId1.value = t.requiredFactionId1;
    requiredFactionId2.value = t.requiredFactionId2;
    requiredFactionValue1.value = t.requiredFactionValue1;
    requiredFactionValue2.value = t.requiredFactionValue2;

    rewardNextQuest.value = t.rewardNextQuest;
    rewardXpDifficulty.value = t.rewardXpDifficulty;
    rewardMoney.value = t.rewardMoney;
    rewardMoneyDifficulty.value = t.rewardMoneyDifficulty;
    rewardDisplaySpell.value = t.rewardDisplaySpell;
    rewardSpell.value = t.rewardSpell;
    rewardHonor.value = t.rewardHonor;
    rewardKillHonor.value = t.rewardKillHonor;
    startItem.value = t.startItem;
    flags.value = t.flags;
    requiredPlayerKills.value = t.requiredPlayerKills;

    rewardItem1.value = t.rewardItem1;
    rewardAmount1.value = t.rewardAmount1;
    rewardItem2.value = t.rewardItem2;
    rewardAmount2.value = t.rewardAmount2;
    rewardItem3.value = t.rewardItem3;
    rewardAmount3.value = t.rewardAmount3;
    rewardItem4.value = t.rewardItem4;
    rewardAmount4.value = t.rewardAmount4;

    itemDrop1.value = t.itemDrop1;
    itemDropQuantity1.value = t.itemDropQuantity1;
    itemDrop2.value = t.itemDrop2;
    itemDropQuantity2.value = t.itemDropQuantity2;
    itemDrop3.value = t.itemDrop3;
    itemDropQuantity3.value = t.itemDropQuantity3;
    itemDrop4.value = t.itemDrop4;
    itemDropQuantity4.value = t.itemDropQuantity4;

    rewardChoiceItemId1.value = t.rewardChoiceItemId1;
    rewardChoiceItemQuantity1.value = t.rewardChoiceItemQuantity1;
    rewardChoiceItemId2.value = t.rewardChoiceItemId2;
    rewardChoiceItemQuantity2.value = t.rewardChoiceItemQuantity2;
    rewardChoiceItemId3.value = t.rewardChoiceItemId3;
    rewardChoiceItemQuantity3.value = t.rewardChoiceItemQuantity3;
    rewardChoiceItemId4.value = t.rewardChoiceItemId4;
    rewardChoiceItemQuantity4.value = t.rewardChoiceItemQuantity4;
    rewardChoiceItemId5.value = t.rewardChoiceItemId5;
    rewardChoiceItemQuantity5.value = t.rewardChoiceItemQuantity5;
    rewardChoiceItemId6.value = t.rewardChoiceItemId6;
    rewardChoiceItemQuantity6.value = t.rewardChoiceItemQuantity6;

    poiContinent.value = t.poiContinent;
    poiX.value = t.poiX;
    poiY.value = t.poiY;
    poiPriority.value = t.poiPriority;

    rewardTitleController.text = t.rewardTitle.toString();
    rewardTalents.value = t.rewardTalents;
    rewardArenaPoints.value = t.rewardArenaPoints;

    rewardFactionId1.value = t.rewardFactionId1;
    rewardFactionValue1.value = t.rewardFactionValue1;
    rewardFactionOverride1.value = t.rewardFactionOverride1;
    rewardFactionId2.value = t.rewardFactionId2;
    rewardFactionValue2.value = t.rewardFactionValue2;
    rewardFactionOverride2.value = t.rewardFactionOverride2;
    rewardFactionId3.value = t.rewardFactionId3;
    rewardFactionValue3.value = t.rewardFactionValue3;
    rewardFactionOverride3.value = t.rewardFactionOverride3;
    rewardFactionId4.value = t.rewardFactionId4;
    rewardFactionValue4.value = t.rewardFactionValue4;
    rewardFactionOverride4.value = t.rewardFactionOverride4;
    rewardFactionId5.value = t.rewardFactionId5;
    rewardFactionValue5.value = t.rewardFactionValue5;
    rewardFactionOverride5.value = t.rewardFactionOverride5;

    timeAllowed.value = t.timeAllowed;
    allowableRaces.value = t.allowableRaces;

    logTitleController.text = t.logTitle;
    logDescriptionController.text = t.logDescription;
    questDescriptionController.text = t.questDescription;
    areaDescriptionController.text = t.areaDescription;
    questCompletionLogController.text = t.questCompletionLog;

    requiredNpcOrGo1.value = t.requiredNpcOrGo1;
    requiredNpcOrGo2.value = t.requiredNpcOrGo2;
    requiredNpcOrGo3.value = t.requiredNpcOrGo3;
    requiredNpcOrGo4.value = t.requiredNpcOrGo4;
    requiredNpcOrGoCount1.value = t.requiredNpcOrGoCount1;
    requiredNpcOrGoCount2.value = t.requiredNpcOrGoCount2;
    requiredNpcOrGoCount3.value = t.requiredNpcOrGoCount3;
    requiredNpcOrGoCount4.value = t.requiredNpcOrGoCount4;

    requiredItemId1.value = t.requiredItemId1;
    requiredItemId2.value = t.requiredItemId2;
    requiredItemId3.value = t.requiredItemId3;
    requiredItemId4.value = t.requiredItemId4;
    requiredItemId5.value = t.requiredItemId5;
    requiredItemId6.value = t.requiredItemId6;
    requiredItemCount1.value = t.requiredItemCount1;
    requiredItemCount2.value = t.requiredItemCount2;
    requiredItemCount3.value = t.requiredItemCount3;
    requiredItemCount4.value = t.requiredItemCount4;
    requiredItemCount5.value = t.requiredItemCount5;
    requiredItemCount6.value = t.requiredItemCount6;

    unknown0.value = t.unknown0;
    objectiveText1Controller.text = t.objectiveText1;
    objectiveText2Controller.text = t.objectiveText2;
    objectiveText3Controller.text = t.objectiveText3;
    objectiveText4Controller.text = t.objectiveText4;
    verifiedBuildController.text = t.verifiedBuild?.toString() ?? '';
  }

  QuestTemplateEntity _collect() {
    return QuestTemplateEntity(
      id: id.value,
      questType: questType.value,
      questLevel: questLevel.value,
      minLevel: minLevel.value,
      questSortId: _parseInt(questSortIdController.text),
      questInfoId: _parseInt(questInfoIdController.text),
      suggestedGroupNum: suggestedGroupNum.value,
      requiredFactionId1: requiredFactionId1.value,
      requiredFactionId2: requiredFactionId2.value,
      requiredFactionValue1: requiredFactionValue1.value,
      requiredFactionValue2: requiredFactionValue2.value,
      rewardNextQuest: rewardNextQuest.value,
      rewardXpDifficulty: rewardXpDifficulty.value,
      rewardMoney: rewardMoney.value,
      rewardMoneyDifficulty: rewardMoneyDifficulty.value,
      rewardDisplaySpell: rewardDisplaySpell.value,
      rewardSpell: rewardSpell.value,
      rewardHonor: rewardHonor.value,
      rewardKillHonor: rewardKillHonor.value,
      startItem: startItem.value,
      flags: flags.value,
      requiredPlayerKills: requiredPlayerKills.value,
      rewardItem1: rewardItem1.value,
      rewardAmount1: rewardAmount1.value,
      rewardItem2: rewardItem2.value,
      rewardAmount2: rewardAmount2.value,
      rewardItem3: rewardItem3.value,
      rewardAmount3: rewardAmount3.value,
      rewardItem4: rewardItem4.value,
      rewardAmount4: rewardAmount4.value,
      itemDrop1: itemDrop1.value,
      itemDropQuantity1: itemDropQuantity1.value,
      itemDrop2: itemDrop2.value,
      itemDropQuantity2: itemDropQuantity2.value,
      itemDrop3: itemDrop3.value,
      itemDropQuantity3: itemDropQuantity3.value,
      itemDrop4: itemDrop4.value,
      itemDropQuantity4: itemDropQuantity4.value,
      rewardChoiceItemId1: rewardChoiceItemId1.value,
      rewardChoiceItemQuantity1: rewardChoiceItemQuantity1.value,
      rewardChoiceItemId2: rewardChoiceItemId2.value,
      rewardChoiceItemQuantity2: rewardChoiceItemQuantity2.value,
      rewardChoiceItemId3: rewardChoiceItemId3.value,
      rewardChoiceItemQuantity3: rewardChoiceItemQuantity3.value,
      rewardChoiceItemId4: rewardChoiceItemId4.value,
      rewardChoiceItemQuantity4: rewardChoiceItemQuantity4.value,
      rewardChoiceItemId5: rewardChoiceItemId5.value,
      rewardChoiceItemQuantity5: rewardChoiceItemQuantity5.value,
      rewardChoiceItemId6: rewardChoiceItemId6.value,
      rewardChoiceItemQuantity6: rewardChoiceItemQuantity6.value,
      poiContinent: poiContinent.value,
      poiX: poiX.value,
      poiY: poiY.value,
      poiPriority: poiPriority.value,
      rewardTitle: _parseInt(rewardTitleController.text),
      rewardTalents: rewardTalents.value,
      rewardArenaPoints: rewardArenaPoints.value,
      rewardFactionId1: rewardFactionId1.value,
      rewardFactionValue1: rewardFactionValue1.value,
      rewardFactionOverride1: rewardFactionOverride1.value,
      rewardFactionId2: rewardFactionId2.value,
      rewardFactionValue2: rewardFactionValue2.value,
      rewardFactionOverride2: rewardFactionOverride2.value,
      rewardFactionId3: rewardFactionId3.value,
      rewardFactionValue3: rewardFactionValue3.value,
      rewardFactionOverride3: rewardFactionOverride3.value,
      rewardFactionId4: rewardFactionId4.value,
      rewardFactionValue4: rewardFactionValue4.value,
      rewardFactionOverride4: rewardFactionOverride4.value,
      rewardFactionId5: rewardFactionId5.value,
      rewardFactionValue5: rewardFactionValue5.value,
      rewardFactionOverride5: rewardFactionOverride5.value,
      timeAllowed: timeAllowed.value,
      allowableRaces: allowableRaces.value,
      logTitle: logTitleController.text,
      logDescription: logDescriptionController.text,
      questDescription: questDescriptionController.text,
      areaDescription: areaDescriptionController.text,
      questCompletionLog: questCompletionLogController.text,
      requiredNpcOrGo1: requiredNpcOrGo1.value,
      requiredNpcOrGo2: requiredNpcOrGo2.value,
      requiredNpcOrGo3: requiredNpcOrGo3.value,
      requiredNpcOrGo4: requiredNpcOrGo4.value,
      requiredNpcOrGoCount1: requiredNpcOrGoCount1.value,
      requiredNpcOrGoCount2: requiredNpcOrGoCount2.value,
      requiredNpcOrGoCount3: requiredNpcOrGoCount3.value,
      requiredNpcOrGoCount4: requiredNpcOrGoCount4.value,
      requiredItemId1: requiredItemId1.value,
      requiredItemId2: requiredItemId2.value,
      requiredItemId3: requiredItemId3.value,
      requiredItemId4: requiredItemId4.value,
      requiredItemId5: requiredItemId5.value,
      requiredItemId6: requiredItemId6.value,
      requiredItemCount1: requiredItemCount1.value,
      requiredItemCount2: requiredItemCount2.value,
      requiredItemCount3: requiredItemCount3.value,
      requiredItemCount4: requiredItemCount4.value,
      requiredItemCount5: requiredItemCount5.value,
      requiredItemCount6: requiredItemCount6.value,
      unknown0: unknown0.value,
      objectiveText1: objectiveText1Controller.text,
      objectiveText2: objectiveText2Controller.text,
      objectiveText3: objectiveText3Controller.text,
      objectiveText4: objectiveText4Controller.text,
      verifiedBuild: _parseIntOrNull(verifiedBuildController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  int? _parseIntOrNull(String text) => text.isEmpty ? null : int.tryParse(text);

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
    questSortIdController.dispose();
    questInfoIdController.dispose();
    rewardTitleController.dispose();
    logTitleController.dispose();
    logDescriptionController.dispose();
    questDescriptionController.dispose();
    areaDescriptionController.dispose();
    questCompletionLogController.dispose();
    objectiveText1Controller.dispose();
    objectiveText2Controller.dispose();
    objectiveText3Controller.dispose();
    objectiveText4Controller.dispose();
    verifiedBuildController.dispose();
  }
}
