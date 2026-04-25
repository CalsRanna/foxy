import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_template.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

// 任务详情页父 ViewModel（Factory）
/// 持有共享 id signal 供子 tab 监听，主表使用 Map<String, TextEditingController> 惰性初始化模式管理 105 个字段
class QuestTemplateDetailViewModel {
  final _routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = QuestTemplateRepository();

  final _controllers = <String, TextEditingController>{};

  /// 按需获取字段 controller（惰性初始化）
  TextEditingController controllerOf(String key) {
    return _controllers.putIfAbsent(key, () => TextEditingController());
  }

  /// 共享 signal：子 Tab 监听 id 变化触发自身加载
  final id = signal(0);

  /// 是否为新建模式
  final creating = signal(true);

  /// 原始 ID（用于 update 的 where 条件）
  int _originalId = 0;

  final loading = signal(false);
  final saving = signal(false);

  /// 初始化：创建模式 (questId == null) 或编辑模式
  Future<void> initSignals({int? questId}) async {
    loading.value = true;
    try {
      if (questId == null) {
        creating.value = true;
        final suggested = await _repository.create();
        id.value = suggested.id;
        _applyToControllers(suggested);
      } else {
        creating.value = false;
        _originalId = questId;
        final existing = await _repository.find(questId);
        if (existing != null) {
          id.value = existing.id;
          _applyToControllers(existing);
        } else {
          id.value = questId;
          final blank = QuestTemplate();
          blank.id = questId;
          _applyToControllers(blank);
        }
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> onSave() async {
    saving.value = true;
    try {
      final model = _collectFromControllers();
      if (creating.value) {
        await _repository.store(model);
        creating.value = false;
      } else {
        await _repository.update(_originalId, model);
      }
      _originalId = model.id;
      id.value = model.id;
      DialogUtil.instance.success('保存成功');
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    } finally {
      saving.value = false;
    }
  }

  void pop() {
    _routerFacade.goBack();
  }

  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
  }

  /// 将 QuestTemplate 所有字段写入 controllers
  void _applyToControllers(QuestTemplate t) {
    controllerOf('ID').text = t.id.toString();
    controllerOf('QuestType').text = t.questType.toString();
    controllerOf('QuestLevel').text = t.questLevel.toString();
    controllerOf('MinLevel').text = t.minLevel.toString();
    controllerOf('QuestSortID').text = t.questSortId.toString();
    controllerOf('QuestInfoID').text = t.questInfoId.toString();
    controllerOf('SuggestedGroupNum').text = t.suggestedGroupNum.toString();
    controllerOf('RequiredFactionId1').text = t.requiredFactionId1.toString();
    controllerOf('RequiredFactionId2').text = t.requiredFactionId2.toString();
    controllerOf('RequiredFactionValue1').text =
        t.requiredFactionValue1.toString();
    controllerOf('RequiredFactionValue2').text =
        t.requiredFactionValue2.toString();
    controllerOf('RewardNextQuest').text = t.rewardNextQuest.toString();
    controllerOf('RewardXPDifficulty').text = t.rewardXpDifficulty.toString();
    controllerOf('RewardMoney').text = t.rewardMoney.toString();
    controllerOf('RewardMoneyDifficulty').text =
        t.rewardMoneyDifficulty.toString();
    controllerOf('RewardDisplaySpell').text = t.rewardDisplaySpell.toString();
    controllerOf('RewardSpell').text = t.rewardSpell.toString();
    controllerOf('RewardHonor').text = t.rewardHonor.toString();
    controllerOf('RewardKillHonor').text = t.rewardKillHonor.toString();
    controllerOf('StartItem').text = t.startItem.toString();
    controllerOf('Flags').text = t.flags.toString();
    controllerOf('RequiredPlayerKills').text = t.requiredPlayerKills.toString();
    controllerOf('RewardItem1').text = t.rewardItem1.toString();
    controllerOf('RewardAmount1').text = t.rewardAmount1.toString();
    controllerOf('RewardItem2').text = t.rewardItem2.toString();
    controllerOf('RewardAmount2').text = t.rewardAmount2.toString();
    controllerOf('RewardItem3').text = t.rewardItem3.toString();
    controllerOf('RewardAmount3').text = t.rewardAmount3.toString();
    controllerOf('RewardItem4').text = t.rewardItem4.toString();
    controllerOf('RewardAmount4').text = t.rewardAmount4.toString();
    controllerOf('ItemDrop1').text = t.itemDrop1.toString();
    controllerOf('ItemDropQuantity1').text = t.itemDropQuantity1.toString();
    controllerOf('ItemDrop2').text = t.itemDrop2.toString();
    controllerOf('ItemDropQuantity2').text = t.itemDropQuantity2.toString();
    controllerOf('ItemDrop3').text = t.itemDrop3.toString();
    controllerOf('ItemDropQuantity3').text = t.itemDropQuantity3.toString();
    controllerOf('ItemDrop4').text = t.itemDrop4.toString();
    controllerOf('ItemDropQuantity4').text = t.itemDropQuantity4.toString();
    controllerOf('RewardChoiceItemID1').text =
        t.rewardChoiceItemId1.toString();
    controllerOf('RewardChoiceItemQuantity1').text =
        t.rewardChoiceItemQuantity1.toString();
    controllerOf('RewardChoiceItemID2').text =
        t.rewardChoiceItemId2.toString();
    controllerOf('RewardChoiceItemQuantity2').text =
        t.rewardChoiceItemQuantity2.toString();
    controllerOf('RewardChoiceItemID3').text =
        t.rewardChoiceItemId3.toString();
    controllerOf('RewardChoiceItemQuantity3').text =
        t.rewardChoiceItemQuantity3.toString();
    controllerOf('RewardChoiceItemID4').text =
        t.rewardChoiceItemId4.toString();
    controllerOf('RewardChoiceItemQuantity4').text =
        t.rewardChoiceItemQuantity4.toString();
    controllerOf('RewardChoiceItemID5').text =
        t.rewardChoiceItemId5.toString();
    controllerOf('RewardChoiceItemQuantity5').text =
        t.rewardChoiceItemQuantity5.toString();
    controllerOf('RewardChoiceItemID6').text =
        t.rewardChoiceItemId6.toString();
    controllerOf('RewardChoiceItemQuantity6').text =
        t.rewardChoiceItemQuantity6.toString();
    controllerOf('POIContinent').text = t.poiContinent.toString();
    controllerOf('POIx').text = t.poiX.toString();
    controllerOf('POIy').text = t.poiY.toString();
    controllerOf('POIPriority').text = t.poiPriority.toString();
    controllerOf('RewardTitle').text = t.rewardTitle.toString();
    controllerOf('RewardTalents').text = t.rewardTalents.toString();
    controllerOf('RewardArenaPoints').text = t.rewardArenaPoints.toString();
    controllerOf('RewardFactionID1').text = t.rewardFactionId1.toString();
    controllerOf('RewardFactionValue1').text = t.rewardFactionValue1.toString();
    controllerOf('RewardFactionOverride1').text =
        t.rewardFactionOverride1.toString();
    controllerOf('RewardFactionID2').text = t.rewardFactionId2.toString();
    controllerOf('RewardFactionValue2').text = t.rewardFactionValue2.toString();
    controllerOf('RewardFactionOverride2').text =
        t.rewardFactionOverride2.toString();
    controllerOf('RewardFactionID3').text = t.rewardFactionId3.toString();
    controllerOf('RewardFactionValue3').text = t.rewardFactionValue3.toString();
    controllerOf('RewardFactionOverride3').text =
        t.rewardFactionOverride3.toString();
    controllerOf('RewardFactionID4').text = t.rewardFactionId4.toString();
    controllerOf('RewardFactionValue4').text = t.rewardFactionValue4.toString();
    controllerOf('RewardFactionOverride4').text =
        t.rewardFactionOverride4.toString();
    controllerOf('RewardFactionID5').text = t.rewardFactionId5.toString();
    controllerOf('RewardFactionValue5').text = t.rewardFactionValue5.toString();
    controllerOf('RewardFactionOverride5').text =
        t.rewardFactionOverride5.toString();
    controllerOf('TimeAllowed').text = t.timeAllowed.toString();
    controllerOf('AllowableRaces').text = t.allowableRaces.toString();
    controllerOf('LogTitle').text = t.logTitle;
    controllerOf('LogDescription').text = t.logDescription;
    controllerOf('QuestDescription').text = t.questDescription;
    controllerOf('AreaDescription').text = t.areaDescription;
    controllerOf('QuestCompletionLog').text = t.questCompletionLog;
    controllerOf('RequiredNpcOrGo1').text = t.requiredNpcOrGo1.toString();
    controllerOf('RequiredNpcOrGo2').text = t.requiredNpcOrGo2.toString();
    controllerOf('RequiredNpcOrGo3').text = t.requiredNpcOrGo3.toString();
    controllerOf('RequiredNpcOrGo4').text = t.requiredNpcOrGo4.toString();
    controllerOf('RequiredNpcOrGoCount1').text =
        t.requiredNpcOrGoCount1.toString();
    controllerOf('RequiredNpcOrGoCount2').text =
        t.requiredNpcOrGoCount2.toString();
    controllerOf('RequiredNpcOrGoCount3').text =
        t.requiredNpcOrGoCount3.toString();
    controllerOf('RequiredNpcOrGoCount4').text =
        t.requiredNpcOrGoCount4.toString();
    controllerOf('RequiredItemId1').text = t.requiredItemId1.toString();
    controllerOf('RequiredItemId2').text = t.requiredItemId2.toString();
    controllerOf('RequiredItemId3').text = t.requiredItemId3.toString();
    controllerOf('RequiredItemId4').text = t.requiredItemId4.toString();
    controllerOf('RequiredItemId5').text = t.requiredItemId5.toString();
    controllerOf('RequiredItemId6').text = t.requiredItemId6.toString();
    controllerOf('RequiredItemCount1').text = t.requiredItemCount1.toString();
    controllerOf('RequiredItemCount2').text = t.requiredItemCount2.toString();
    controllerOf('RequiredItemCount3').text = t.requiredItemCount3.toString();
    controllerOf('RequiredItemCount4').text = t.requiredItemCount4.toString();
    controllerOf('RequiredItemCount5').text = t.requiredItemCount5.toString();
    controllerOf('RequiredItemCount6').text = t.requiredItemCount6.toString();
    controllerOf('Unknown0').text = t.unknown0.toString();
    controllerOf('ObjectiveText1').text = t.objectiveText1;
    controllerOf('ObjectiveText2').text = t.objectiveText2;
    controllerOf('ObjectiveText3').text = t.objectiveText3;
    controllerOf('ObjectiveText4').text = t.objectiveText4;
    controllerOf('VerifiedBuild').text =
        t.verifiedBuild?.toString() ?? '';
  }

  /// 从 controllers 收集数据构建 QuestTemplate
  QuestTemplate _collectFromControllers() {
    final t = QuestTemplate();
    t.id = _parseInt(controllerOf('ID').text);
    t.questType = _parseInt(controllerOf('QuestType').text);
    t.questLevel = _parseInt(controllerOf('QuestLevel').text);
    t.minLevel = _parseInt(controllerOf('MinLevel').text);
    t.questSortId = _parseInt(controllerOf('QuestSortID').text);
    t.questInfoId = _parseInt(controllerOf('QuestInfoID').text);
    t.suggestedGroupNum = _parseInt(controllerOf('SuggestedGroupNum').text);
    t.requiredFactionId1 = _parseInt(controllerOf('RequiredFactionId1').text);
    t.requiredFactionId2 = _parseInt(controllerOf('RequiredFactionId2').text);
    t.requiredFactionValue1 =
        _parseInt(controllerOf('RequiredFactionValue1').text);
    t.requiredFactionValue2 =
        _parseInt(controllerOf('RequiredFactionValue2').text);
    t.rewardNextQuest = _parseInt(controllerOf('RewardNextQuest').text);
    t.rewardXpDifficulty = _parseInt(controllerOf('RewardXPDifficulty').text);
    t.rewardMoney = _parseInt(controllerOf('RewardMoney').text);
    t.rewardMoneyDifficulty =
        _parseInt(controllerOf('RewardMoneyDifficulty').text);
    t.rewardDisplaySpell = _parseInt(controllerOf('RewardDisplaySpell').text);
    t.rewardSpell = _parseInt(controllerOf('RewardSpell').text);
    t.rewardHonor = _parseInt(controllerOf('RewardHonor').text);
    t.rewardKillHonor = _parseDouble(controllerOf('RewardKillHonor').text);
    t.startItem = _parseInt(controllerOf('StartItem').text);
    t.flags = _parseInt(controllerOf('Flags').text);
    t.requiredPlayerKills =
        _parseInt(controllerOf('RequiredPlayerKills').text);
    t.rewardItem1 = _parseInt(controllerOf('RewardItem1').text);
    t.rewardAmount1 = _parseInt(controllerOf('RewardAmount1').text);
    t.rewardItem2 = _parseInt(controllerOf('RewardItem2').text);
    t.rewardAmount2 = _parseInt(controllerOf('RewardAmount2').text);
    t.rewardItem3 = _parseInt(controllerOf('RewardItem3').text);
    t.rewardAmount3 = _parseInt(controllerOf('RewardAmount3').text);
    t.rewardItem4 = _parseInt(controllerOf('RewardItem4').text);
    t.rewardAmount4 = _parseInt(controllerOf('RewardAmount4').text);
    t.itemDrop1 = _parseInt(controllerOf('ItemDrop1').text);
    t.itemDropQuantity1 = _parseInt(controllerOf('ItemDropQuantity1').text);
    t.itemDrop2 = _parseInt(controllerOf('ItemDrop2').text);
    t.itemDropQuantity2 = _parseInt(controllerOf('ItemDropQuantity2').text);
    t.itemDrop3 = _parseInt(controllerOf('ItemDrop3').text);
    t.itemDropQuantity3 = _parseInt(controllerOf('ItemDropQuantity3').text);
    t.itemDrop4 = _parseInt(controllerOf('ItemDrop4').text);
    t.itemDropQuantity4 = _parseInt(controllerOf('ItemDropQuantity4').text);
    t.rewardChoiceItemId1 =
        _parseInt(controllerOf('RewardChoiceItemID1').text);
    t.rewardChoiceItemQuantity1 =
        _parseInt(controllerOf('RewardChoiceItemQuantity1').text);
    t.rewardChoiceItemId2 =
        _parseInt(controllerOf('RewardChoiceItemID2').text);
    t.rewardChoiceItemQuantity2 =
        _parseInt(controllerOf('RewardChoiceItemQuantity2').text);
    t.rewardChoiceItemId3 =
        _parseInt(controllerOf('RewardChoiceItemID3').text);
    t.rewardChoiceItemQuantity3 =
        _parseInt(controllerOf('RewardChoiceItemQuantity3').text);
    t.rewardChoiceItemId4 =
        _parseInt(controllerOf('RewardChoiceItemID4').text);
    t.rewardChoiceItemQuantity4 =
        _parseInt(controllerOf('RewardChoiceItemQuantity4').text);
    t.rewardChoiceItemId5 =
        _parseInt(controllerOf('RewardChoiceItemID5').text);
    t.rewardChoiceItemQuantity5 =
        _parseInt(controllerOf('RewardChoiceItemQuantity5').text);
    t.rewardChoiceItemId6 =
        _parseInt(controllerOf('RewardChoiceItemID6').text);
    t.rewardChoiceItemQuantity6 =
        _parseInt(controllerOf('RewardChoiceItemQuantity6').text);
    t.poiContinent = _parseInt(controllerOf('POIContinent').text);
    t.poiX = _parseDouble(controllerOf('POIx').text);
    t.poiY = _parseDouble(controllerOf('POIy').text);
    t.poiPriority = _parseInt(controllerOf('POIPriority').text);
    t.rewardTitle = _parseInt(controllerOf('RewardTitle').text);
    t.rewardTalents = _parseInt(controllerOf('RewardTalents').text);
    t.rewardArenaPoints = _parseInt(controllerOf('RewardArenaPoints').text);
    t.rewardFactionId1 = _parseInt(controllerOf('RewardFactionID1').text);
    t.rewardFactionValue1 =
        _parseInt(controllerOf('RewardFactionValue1').text);
    t.rewardFactionOverride1 =
        _parseInt(controllerOf('RewardFactionOverride1').text);
    t.rewardFactionId2 = _parseInt(controllerOf('RewardFactionID2').text);
    t.rewardFactionValue2 =
        _parseInt(controllerOf('RewardFactionValue2').text);
    t.rewardFactionOverride2 =
        _parseInt(controllerOf('RewardFactionOverride2').text);
    t.rewardFactionId3 = _parseInt(controllerOf('RewardFactionID3').text);
    t.rewardFactionValue3 =
        _parseInt(controllerOf('RewardFactionValue3').text);
    t.rewardFactionOverride3 =
        _parseInt(controllerOf('RewardFactionOverride3').text);
    t.rewardFactionId4 = _parseInt(controllerOf('RewardFactionID4').text);
    t.rewardFactionValue4 =
        _parseInt(controllerOf('RewardFactionValue4').text);
    t.rewardFactionOverride4 =
        _parseInt(controllerOf('RewardFactionOverride4').text);
    t.rewardFactionId5 = _parseInt(controllerOf('RewardFactionID5').text);
    t.rewardFactionValue5 =
        _parseInt(controllerOf('RewardFactionValue5').text);
    t.rewardFactionOverride5 =
        _parseInt(controllerOf('RewardFactionOverride5').text);
    t.timeAllowed = _parseInt(controllerOf('TimeAllowed').text);
    t.allowableRaces = _parseInt(controllerOf('AllowableRaces').text);
    t.logTitle = controllerOf('LogTitle').text;
    t.logDescription = controllerOf('LogDescription').text;
    t.questDescription = controllerOf('QuestDescription').text;
    t.areaDescription = controllerOf('AreaDescription').text;
    t.questCompletionLog = controllerOf('QuestCompletionLog').text;
    t.requiredNpcOrGo1 = _parseInt(controllerOf('RequiredNpcOrGo1').text);
    t.requiredNpcOrGo2 = _parseInt(controllerOf('RequiredNpcOrGo2').text);
    t.requiredNpcOrGo3 = _parseInt(controllerOf('RequiredNpcOrGo3').text);
    t.requiredNpcOrGo4 = _parseInt(controllerOf('RequiredNpcOrGo4').text);
    t.requiredNpcOrGoCount1 =
        _parseInt(controllerOf('RequiredNpcOrGoCount1').text);
    t.requiredNpcOrGoCount2 =
        _parseInt(controllerOf('RequiredNpcOrGoCount2').text);
    t.requiredNpcOrGoCount3 =
        _parseInt(controllerOf('RequiredNpcOrGoCount3').text);
    t.requiredNpcOrGoCount4 =
        _parseInt(controllerOf('RequiredNpcOrGoCount4').text);
    t.requiredItemId1 = _parseInt(controllerOf('RequiredItemId1').text);
    t.requiredItemId2 = _parseInt(controllerOf('RequiredItemId2').text);
    t.requiredItemId3 = _parseInt(controllerOf('RequiredItemId3').text);
    t.requiredItemId4 = _parseInt(controllerOf('RequiredItemId4').text);
    t.requiredItemId5 = _parseInt(controllerOf('RequiredItemId5').text);
    t.requiredItemId6 = _parseInt(controllerOf('RequiredItemId6').text);
    t.requiredItemCount1 = _parseInt(controllerOf('RequiredItemCount1').text);
    t.requiredItemCount2 = _parseInt(controllerOf('RequiredItemCount2').text);
    t.requiredItemCount3 = _parseInt(controllerOf('RequiredItemCount3').text);
    t.requiredItemCount4 = _parseInt(controllerOf('RequiredItemCount4').text);
    t.requiredItemCount5 = _parseInt(controllerOf('RequiredItemCount5').text);
    t.requiredItemCount6 = _parseInt(controllerOf('RequiredItemCount6').text);
    t.unknown0 = _parseInt(controllerOf('Unknown0').text);
    t.objectiveText1 = controllerOf('ObjectiveText1').text;
    t.objectiveText2 = controllerOf('ObjectiveText2').text;
    t.objectiveText3 = controllerOf('ObjectiveText3').text;
    t.objectiveText4 = controllerOf('ObjectiveText4').text;
    t.verifiedBuild = _parseIntOrNull(controllerOf('VerifiedBuild').text);
    return t;
  }

  int _parseInt(String text) => int.tryParse(text) ?? 0;

  double _parseDouble(String text) => double.tryParse(text) ?? 0;

  /// nullable int: 空字符串返回 null，否则返回解析值（失败为 null）
  int? _parseIntOrNull(String? text) {
    if (text == null || text.isEmpty) return null;
    return int.tryParse(text);
  }
}