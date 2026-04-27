import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_template.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestTemplateDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final entry = signal(0);
  final template = signal(QuestTemplate());

  /// Basic
  final idController = TextEditingController();
  final questTypeController = TextEditingController();
  final questLevelController = TextEditingController();
  final minLevelController = TextEditingController();
  final questSortIdController = TextEditingController();
  final questInfoIdController = TextEditingController();
  final suggestedGroupNumController = TextEditingController();
  final requiredFactionId1Controller = TextEditingController();
  final requiredFactionId2Controller = TextEditingController();
  final requiredFactionValue1Controller = TextEditingController();
  final requiredFactionValue2Controller = TextEditingController();

  /// Reward
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

  /// RewardItem
  final rewardItem1Controller = TextEditingController();
  final rewardAmount1Controller = TextEditingController();
  final rewardItem2Controller = TextEditingController();
  final rewardAmount2Controller = TextEditingController();
  final rewardItem3Controller = TextEditingController();
  final rewardAmount3Controller = TextEditingController();
  final rewardItem4Controller = TextEditingController();
  final rewardAmount4Controller = TextEditingController();

  /// ItemDrop
  final itemDrop1Controller = TextEditingController();
  final itemDropQuantity1Controller = TextEditingController();
  final itemDrop2Controller = TextEditingController();
  final itemDropQuantity2Controller = TextEditingController();
  final itemDrop3Controller = TextEditingController();
  final itemDropQuantity3Controller = TextEditingController();
  final itemDrop4Controller = TextEditingController();
  final itemDropQuantity4Controller = TextEditingController();

  /// RewardChoiceItem
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

  /// POI
  final poiContinentController = TextEditingController();
  final poiXController = TextEditingController();
  final poiYController = TextEditingController();
  final poiPriorityController = TextEditingController();

  /// RewardTitle/Talents
  final rewardTitleController = TextEditingController();
  final rewardTalentsController = TextEditingController();
  final rewardArenaPointsController = TextEditingController();

  /// RewardFaction
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

  /// Text
  final logTitleController = TextEditingController();
  final logDescriptionController = TextEditingController();
  final questDescriptionController = TextEditingController();
  final areaDescriptionController = TextEditingController();
  final questCompletionLogController = TextEditingController();

  /// RequiredNpcOrGo
  final requiredNpcOrGo1Controller = TextEditingController();
  final requiredNpcOrGo2Controller = TextEditingController();
  final requiredNpcOrGo3Controller = TextEditingController();
  final requiredNpcOrGo4Controller = TextEditingController();
  final requiredNpcOrGoCount1Controller = TextEditingController();
  final requiredNpcOrGoCount2Controller = TextEditingController();
  final requiredNpcOrGoCount3Controller = TextEditingController();
  final requiredNpcOrGoCount4Controller = TextEditingController();

  /// RequiredItem
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

  /// 保存模板到数据库
  Future<void> save(BuildContext context) async {
    try {
      final t = _collectFromControllers();
      final repository = QuestTemplateRepository();
      if (t.id == 0) {
        await repository.storeQuestTemplate(t);
      } else {
        await repository.updateQuestTemplate(t);
      }
      template.value = t;
      entry.value = t.id;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模板数据已保存'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  /// 退出页面
  void pop() {
    routerFacade.goBack();
  }

  Future<void> initSignals({int? questId}) async {
    if (questId == null) return;
    template.value = await QuestTemplateRepository().getQuestTemplate(questId);
    _initControllers(template.value);
  }

  void _initControllers(QuestTemplate t) {
    idController.text = t.id.toString();
    questTypeController.text = t.questType.toString();
    questLevelController.text = t.questLevel.toString();
    minLevelController.text = t.minLevel.toString();
    questSortIdController.text = t.questSortId.toString();
    questInfoIdController.text = t.questInfoId.toString();
    suggestedGroupNumController.text = t.suggestedGroupNum.toString();
    requiredFactionId1Controller.text = t.requiredFactionId1.toString();
    requiredFactionId2Controller.text = t.requiredFactionId2.toString();
    requiredFactionValue1Controller.text = t.requiredFactionValue1.toString();
    requiredFactionValue2Controller.text = t.requiredFactionValue2.toString();
    rewardNextQuestController.text = t.rewardNextQuest.toString();
    rewardXpDifficultyController.text = t.rewardXpDifficulty.toString();
    rewardMoneyController.text = t.rewardMoney.toString();
    rewardMoneyDifficultyController.text = t.rewardMoneyDifficulty.toString();
    rewardDisplaySpellController.text = t.rewardDisplaySpell.toString();
    rewardSpellController.text = t.rewardSpell.toString();
    rewardHonorController.text = t.rewardHonor.toString();
    rewardKillHonorController.text = t.rewardKillHonor.toString();
    startItemController.text = t.startItem.toString();
    flagsController.text = t.flags.toString();
    requiredPlayerKillsController.text = t.requiredPlayerKills.toString();
    rewardItem1Controller.text = t.rewardItem1.toString();
    rewardAmount1Controller.text = t.rewardAmount1.toString();
    rewardItem2Controller.text = t.rewardItem2.toString();
    rewardAmount2Controller.text = t.rewardAmount2.toString();
    rewardItem3Controller.text = t.rewardItem3.toString();
    rewardAmount3Controller.text = t.rewardAmount3.toString();
    rewardItem4Controller.text = t.rewardItem4.toString();
    rewardAmount4Controller.text = t.rewardAmount4.toString();
    itemDrop1Controller.text = t.itemDrop1.toString();
    itemDropQuantity1Controller.text = t.itemDropQuantity1.toString();
    itemDrop2Controller.text = t.itemDrop2.toString();
    itemDropQuantity2Controller.text = t.itemDropQuantity2.toString();
    itemDrop3Controller.text = t.itemDrop3.toString();
    itemDropQuantity3Controller.text = t.itemDropQuantity3.toString();
    itemDrop4Controller.text = t.itemDrop4.toString();
    itemDropQuantity4Controller.text = t.itemDropQuantity4.toString();
    rewardChoiceItemId1Controller.text = t.rewardChoiceItemId1.toString();
    rewardChoiceItemQuantity1Controller.text = t.rewardChoiceItemQuantity1
        .toString();
    rewardChoiceItemId2Controller.text = t.rewardChoiceItemId2.toString();
    rewardChoiceItemQuantity2Controller.text = t.rewardChoiceItemQuantity2
        .toString();
    rewardChoiceItemId3Controller.text = t.rewardChoiceItemId3.toString();
    rewardChoiceItemQuantity3Controller.text = t.rewardChoiceItemQuantity3
        .toString();
    rewardChoiceItemId4Controller.text = t.rewardChoiceItemId4.toString();
    rewardChoiceItemQuantity4Controller.text = t.rewardChoiceItemQuantity4
        .toString();
    rewardChoiceItemId5Controller.text = t.rewardChoiceItemId5.toString();
    rewardChoiceItemQuantity5Controller.text = t.rewardChoiceItemQuantity5
        .toString();
    rewardChoiceItemId6Controller.text = t.rewardChoiceItemId6.toString();
    rewardChoiceItemQuantity6Controller.text = t.rewardChoiceItemQuantity6
        .toString();
    poiContinentController.text = t.poiContinent.toString();
    poiXController.text = t.poiX.toString();
    poiYController.text = t.poiY.toString();
    poiPriorityController.text = t.poiPriority.toString();
    rewardTitleController.text = t.rewardTitle.toString();
    rewardTalentsController.text = t.rewardTalents.toString();
    rewardArenaPointsController.text = t.rewardArenaPoints.toString();
    rewardFactionId1Controller.text = t.rewardFactionId1.toString();
    rewardFactionValue1Controller.text = t.rewardFactionValue1.toString();
    rewardFactionOverride1Controller.text = t.rewardFactionOverride1.toString();
    rewardFactionId2Controller.text = t.rewardFactionId2.toString();
    rewardFactionValue2Controller.text = t.rewardFactionValue2.toString();
    rewardFactionOverride2Controller.text = t.rewardFactionOverride2.toString();
    rewardFactionId3Controller.text = t.rewardFactionId3.toString();
    rewardFactionValue3Controller.text = t.rewardFactionValue3.toString();
    rewardFactionOverride3Controller.text = t.rewardFactionOverride3.toString();
    rewardFactionId4Controller.text = t.rewardFactionId4.toString();
    rewardFactionValue4Controller.text = t.rewardFactionValue4.toString();
    rewardFactionOverride4Controller.text = t.rewardFactionOverride4.toString();
    rewardFactionId5Controller.text = t.rewardFactionId5.toString();
    rewardFactionValue5Controller.text = t.rewardFactionValue5.toString();
    rewardFactionOverride5Controller.text = t.rewardFactionOverride5.toString();
    timeAllowedController.text = t.timeAllowed.toString();
    allowableRacesController.text = t.allowableRaces.toString();
    logTitleController.text = t.logTitle;
    logDescriptionController.text = t.logDescription;
    questDescriptionController.text = t.questDescription;
    areaDescriptionController.text = t.areaDescription;
    questCompletionLogController.text = t.questCompletionLog;
    requiredNpcOrGo1Controller.text = t.requiredNpcOrGo1.toString();
    requiredNpcOrGo2Controller.text = t.requiredNpcOrGo2.toString();
    requiredNpcOrGo3Controller.text = t.requiredNpcOrGo3.toString();
    requiredNpcOrGo4Controller.text = t.requiredNpcOrGo4.toString();
    requiredNpcOrGoCount1Controller.text = t.requiredNpcOrGoCount1.toString();
    requiredNpcOrGoCount2Controller.text = t.requiredNpcOrGoCount2.toString();
    requiredNpcOrGoCount3Controller.text = t.requiredNpcOrGoCount3.toString();
    requiredNpcOrGoCount4Controller.text = t.requiredNpcOrGoCount4.toString();
    requiredItemId1Controller.text = t.requiredItemId1.toString();
    requiredItemId2Controller.text = t.requiredItemId2.toString();
    requiredItemId3Controller.text = t.requiredItemId3.toString();
    requiredItemId4Controller.text = t.requiredItemId4.toString();
    requiredItemId5Controller.text = t.requiredItemId5.toString();
    requiredItemId6Controller.text = t.requiredItemId6.toString();
    requiredItemCount1Controller.text = t.requiredItemCount1.toString();
    requiredItemCount2Controller.text = t.requiredItemCount2.toString();
    requiredItemCount3Controller.text = t.requiredItemCount3.toString();
    requiredItemCount4Controller.text = t.requiredItemCount4.toString();
    requiredItemCount5Controller.text = t.requiredItemCount5.toString();
    requiredItemCount6Controller.text = t.requiredItemCount6.toString();
    unknown0Controller.text = t.unknown0.toString();
    objectiveText1Controller.text = t.objectiveText1;
    objectiveText2Controller.text = t.objectiveText2;
    objectiveText3Controller.text = t.objectiveText3;
    objectiveText4Controller.text = t.objectiveText4;
    verifiedBuildController.text = t.verifiedBuild?.toString() ?? '';
  }

  QuestTemplate _collectFromControllers() {
    final t = QuestTemplate();
    t.id = _parseInt(idController.text);
    t.questType = _parseInt(questTypeController.text);
    t.questLevel = _parseInt(questLevelController.text);
    t.minLevel = _parseInt(minLevelController.text);
    t.questSortId = _parseInt(questSortIdController.text);
    t.questInfoId = _parseInt(questInfoIdController.text);
    t.suggestedGroupNum = _parseInt(suggestedGroupNumController.text);
    t.requiredFactionId1 = _parseInt(requiredFactionId1Controller.text);
    t.requiredFactionId2 = _parseInt(requiredFactionId2Controller.text);
    t.requiredFactionValue1 = _parseInt(requiredFactionValue1Controller.text);
    t.requiredFactionValue2 = _parseInt(requiredFactionValue2Controller.text);
    t.rewardNextQuest = _parseInt(rewardNextQuestController.text);
    t.rewardXpDifficulty = _parseInt(rewardXpDifficultyController.text);
    t.rewardMoney = _parseInt(rewardMoneyController.text);
    t.rewardMoneyDifficulty = _parseInt(rewardMoneyDifficultyController.text);
    t.rewardDisplaySpell = _parseInt(rewardDisplaySpellController.text);
    t.rewardSpell = _parseInt(rewardSpellController.text);
    t.rewardHonor = _parseInt(rewardHonorController.text);
    t.rewardKillHonor = _parseDouble(rewardKillHonorController.text);
    t.startItem = _parseInt(startItemController.text);
    t.flags = _parseInt(flagsController.text);
    t.requiredPlayerKills = _parseInt(requiredPlayerKillsController.text);
    t.rewardItem1 = _parseInt(rewardItem1Controller.text);
    t.rewardAmount1 = _parseInt(rewardAmount1Controller.text);
    t.rewardItem2 = _parseInt(rewardItem2Controller.text);
    t.rewardAmount2 = _parseInt(rewardAmount2Controller.text);
    t.rewardItem3 = _parseInt(rewardItem3Controller.text);
    t.rewardAmount3 = _parseInt(rewardAmount3Controller.text);
    t.rewardItem4 = _parseInt(rewardItem4Controller.text);
    t.rewardAmount4 = _parseInt(rewardAmount4Controller.text);
    t.itemDrop1 = _parseInt(itemDrop1Controller.text);
    t.itemDropQuantity1 = _parseInt(itemDropQuantity1Controller.text);
    t.itemDrop2 = _parseInt(itemDrop2Controller.text);
    t.itemDropQuantity2 = _parseInt(itemDropQuantity2Controller.text);
    t.itemDrop3 = _parseInt(itemDrop3Controller.text);
    t.itemDropQuantity3 = _parseInt(itemDropQuantity3Controller.text);
    t.itemDrop4 = _parseInt(itemDrop4Controller.text);
    t.itemDropQuantity4 = _parseInt(itemDropQuantity4Controller.text);
    t.rewardChoiceItemId1 = _parseInt(rewardChoiceItemId1Controller.text);
    t.rewardChoiceItemQuantity1 = _parseInt(
      rewardChoiceItemQuantity1Controller.text,
    );
    t.rewardChoiceItemId2 = _parseInt(rewardChoiceItemId2Controller.text);
    t.rewardChoiceItemQuantity2 = _parseInt(
      rewardChoiceItemQuantity2Controller.text,
    );
    t.rewardChoiceItemId3 = _parseInt(rewardChoiceItemId3Controller.text);
    t.rewardChoiceItemQuantity3 = _parseInt(
      rewardChoiceItemQuantity3Controller.text,
    );
    t.rewardChoiceItemId4 = _parseInt(rewardChoiceItemId4Controller.text);
    t.rewardChoiceItemQuantity4 = _parseInt(
      rewardChoiceItemQuantity4Controller.text,
    );
    t.rewardChoiceItemId5 = _parseInt(rewardChoiceItemId5Controller.text);
    t.rewardChoiceItemQuantity5 = _parseInt(
      rewardChoiceItemQuantity5Controller.text,
    );
    t.rewardChoiceItemId6 = _parseInt(rewardChoiceItemId6Controller.text);
    t.rewardChoiceItemQuantity6 = _parseInt(
      rewardChoiceItemQuantity6Controller.text,
    );
    t.poiContinent = _parseInt(poiContinentController.text);
    t.poiX = _parseDouble(poiXController.text);
    t.poiY = _parseDouble(poiYController.text);
    t.poiPriority = _parseInt(poiPriorityController.text);
    t.rewardTitle = _parseInt(rewardTitleController.text);
    t.rewardTalents = _parseInt(rewardTalentsController.text);
    t.rewardArenaPoints = _parseInt(rewardArenaPointsController.text);
    t.rewardFactionId1 = _parseInt(rewardFactionId1Controller.text);
    t.rewardFactionValue1 = _parseInt(rewardFactionValue1Controller.text);
    t.rewardFactionOverride1 = _parseInt(rewardFactionOverride1Controller.text);
    t.rewardFactionId2 = _parseInt(rewardFactionId2Controller.text);
    t.rewardFactionValue2 = _parseInt(rewardFactionValue2Controller.text);
    t.rewardFactionOverride2 = _parseInt(rewardFactionOverride2Controller.text);
    t.rewardFactionId3 = _parseInt(rewardFactionId3Controller.text);
    t.rewardFactionValue3 = _parseInt(rewardFactionValue3Controller.text);
    t.rewardFactionOverride3 = _parseInt(rewardFactionOverride3Controller.text);
    t.rewardFactionId4 = _parseInt(rewardFactionId4Controller.text);
    t.rewardFactionValue4 = _parseInt(rewardFactionValue4Controller.text);
    t.rewardFactionOverride4 = _parseInt(rewardFactionOverride4Controller.text);
    t.rewardFactionId5 = _parseInt(rewardFactionId5Controller.text);
    t.rewardFactionValue5 = _parseInt(rewardFactionValue5Controller.text);
    t.rewardFactionOverride5 = _parseInt(rewardFactionOverride5Controller.text);
    t.timeAllowed = _parseInt(timeAllowedController.text);
    t.allowableRaces = _parseInt(allowableRacesController.text);
    t.logTitle = logTitleController.text;
    t.logDescription = logDescriptionController.text;
    t.questDescription = questDescriptionController.text;
    t.areaDescription = areaDescriptionController.text;
    t.questCompletionLog = questCompletionLogController.text;
    t.requiredNpcOrGo1 = _parseInt(requiredNpcOrGo1Controller.text);
    t.requiredNpcOrGo2 = _parseInt(requiredNpcOrGo2Controller.text);
    t.requiredNpcOrGo3 = _parseInt(requiredNpcOrGo3Controller.text);
    t.requiredNpcOrGo4 = _parseInt(requiredNpcOrGo4Controller.text);
    t.requiredNpcOrGoCount1 = _parseInt(requiredNpcOrGoCount1Controller.text);
    t.requiredNpcOrGoCount2 = _parseInt(requiredNpcOrGoCount2Controller.text);
    t.requiredNpcOrGoCount3 = _parseInt(requiredNpcOrGoCount3Controller.text);
    t.requiredNpcOrGoCount4 = _parseInt(requiredNpcOrGoCount4Controller.text);
    t.requiredItemId1 = _parseInt(requiredItemId1Controller.text);
    t.requiredItemId2 = _parseInt(requiredItemId2Controller.text);
    t.requiredItemId3 = _parseInt(requiredItemId3Controller.text);
    t.requiredItemId4 = _parseInt(requiredItemId4Controller.text);
    t.requiredItemId5 = _parseInt(requiredItemId5Controller.text);
    t.requiredItemId6 = _parseInt(requiredItemId6Controller.text);
    t.requiredItemCount1 = _parseInt(requiredItemCount1Controller.text);
    t.requiredItemCount2 = _parseInt(requiredItemCount2Controller.text);
    t.requiredItemCount3 = _parseInt(requiredItemCount3Controller.text);
    t.requiredItemCount4 = _parseInt(requiredItemCount4Controller.text);
    t.requiredItemCount5 = _parseInt(requiredItemCount5Controller.text);
    t.requiredItemCount6 = _parseInt(requiredItemCount6Controller.text);
    t.unknown0 = _parseInt(unknown0Controller.text);
    t.objectiveText1 = objectiveText1Controller.text;
    t.objectiveText2 = objectiveText2Controller.text;
    t.objectiveText3 = objectiveText3Controller.text;
    t.objectiveText4 = objectiveText4Controller.text;
    t.verifiedBuild = _parseIntOrNull(verifiedBuildController.text);
    return t;
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }
  double _parseDouble(String text) {
    if (text.isEmpty) return 0.0;
    final value = double.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }
  int? _parseIntOrNull(String text) => text.isEmpty ? null : int.tryParse(text);

  void dispose() {
    idController.dispose();
    questTypeController.dispose();
    questLevelController.dispose();
    minLevelController.dispose();
    questSortIdController.dispose();
    questInfoIdController.dispose();
    suggestedGroupNumController.dispose();
    requiredFactionId1Controller.dispose();
    requiredFactionId2Controller.dispose();
    requiredFactionValue1Controller.dispose();
    requiredFactionValue2Controller.dispose();
    rewardNextQuestController.dispose();
    rewardXpDifficultyController.dispose();
    rewardMoneyController.dispose();
    rewardMoneyDifficultyController.dispose();
    rewardDisplaySpellController.dispose();
    rewardSpellController.dispose();
    rewardHonorController.dispose();
    rewardKillHonorController.dispose();
    startItemController.dispose();
    flagsController.dispose();
    requiredPlayerKillsController.dispose();
    rewardItem1Controller.dispose();
    rewardAmount1Controller.dispose();
    rewardItem2Controller.dispose();
    rewardAmount2Controller.dispose();
    rewardItem3Controller.dispose();
    rewardAmount3Controller.dispose();
    rewardItem4Controller.dispose();
    rewardAmount4Controller.dispose();
    itemDrop1Controller.dispose();
    itemDropQuantity1Controller.dispose();
    itemDrop2Controller.dispose();
    itemDropQuantity2Controller.dispose();
    itemDrop3Controller.dispose();
    itemDropQuantity3Controller.dispose();
    itemDrop4Controller.dispose();
    itemDropQuantity4Controller.dispose();
    rewardChoiceItemId1Controller.dispose();
    rewardChoiceItemQuantity1Controller.dispose();
    rewardChoiceItemId2Controller.dispose();
    rewardChoiceItemQuantity2Controller.dispose();
    rewardChoiceItemId3Controller.dispose();
    rewardChoiceItemQuantity3Controller.dispose();
    rewardChoiceItemId4Controller.dispose();
    rewardChoiceItemQuantity4Controller.dispose();
    rewardChoiceItemId5Controller.dispose();
    rewardChoiceItemQuantity5Controller.dispose();
    rewardChoiceItemId6Controller.dispose();
    rewardChoiceItemQuantity6Controller.dispose();
    poiContinentController.dispose();
    poiXController.dispose();
    poiYController.dispose();
    poiPriorityController.dispose();
    rewardTitleController.dispose();
    rewardTalentsController.dispose();
    rewardArenaPointsController.dispose();
    rewardFactionId1Controller.dispose();
    rewardFactionValue1Controller.dispose();
    rewardFactionOverride1Controller.dispose();
    rewardFactionId2Controller.dispose();
    rewardFactionValue2Controller.dispose();
    rewardFactionOverride2Controller.dispose();
    rewardFactionId3Controller.dispose();
    rewardFactionValue3Controller.dispose();
    rewardFactionOverride3Controller.dispose();
    rewardFactionId4Controller.dispose();
    rewardFactionValue4Controller.dispose();
    rewardFactionOverride4Controller.dispose();
    rewardFactionId5Controller.dispose();
    rewardFactionValue5Controller.dispose();
    rewardFactionOverride5Controller.dispose();
    timeAllowedController.dispose();
    allowableRacesController.dispose();
    logTitleController.dispose();
    logDescriptionController.dispose();
    questDescriptionController.dispose();
    areaDescriptionController.dispose();
    questCompletionLogController.dispose();
    requiredNpcOrGo1Controller.dispose();
    requiredNpcOrGo2Controller.dispose();
    requiredNpcOrGo3Controller.dispose();
    requiredNpcOrGo4Controller.dispose();
    requiredNpcOrGoCount1Controller.dispose();
    requiredNpcOrGoCount2Controller.dispose();
    requiredNpcOrGoCount3Controller.dispose();
    requiredNpcOrGoCount4Controller.dispose();
    requiredItemId1Controller.dispose();
    requiredItemId2Controller.dispose();
    requiredItemId3Controller.dispose();
    requiredItemId4Controller.dispose();
    requiredItemId5Controller.dispose();
    requiredItemId6Controller.dispose();
    requiredItemCount1Controller.dispose();
    requiredItemCount2Controller.dispose();
    requiredItemCount3Controller.dispose();
    requiredItemCount4Controller.dispose();
    requiredItemCount5Controller.dispose();
    requiredItemCount6Controller.dispose();
    unknown0Controller.dispose();
    objectiveText1Controller.dispose();
    objectiveText2Controller.dispose();
    objectiveText3Controller.dispose();
    objectiveText4Controller.dispose();
    verifiedBuildController.dispose();
  }
}
