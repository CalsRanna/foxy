import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/repository/quest_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestTemplateAddonViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);
  final addon = signal(QuestTemplateAddonEntity());

  final id = signal<int>(0);
  final maxLevel = signal<int>(0);
  final allowableClasses = signal<int>(0);
  final sourceSpellId = signal<int>(0);
  final prevQuestId = signal<int>(0);
  final nextQuestId = signal<int>(0);
  final exclusiveGroup = signal<int>(0);
  final rewardMailTemplateId = signal<int>(0);
  final rewardMailDelay = signal<int>(0);
  final requiredSkillId = signal<int>(0);
  final requiredSkillPoints = signal<int>(0);
  final requiredMinRepFaction = signal<int>(0);
  final requiredMaxRepFaction = signal<int>(0);
  final requiredMinRepValue = signal<int>(0);
  final requiredMaxRepValue = signal<int>(0);
  final providedItemCount = signal<int>(0);
  final specialFlags = signal<int>(0);

  int _originalId = 0;

  Future<void> initSignals({required int questId}) async {
    try {
      this.questId.value = questId;
      final repository = QuestTemplateAddonRepository();
      final existing = await repository.getQuestTemplateAddon(questId);
      if (existing != null) {
        _originalId = existing.id;
        addon.value = existing;
      } else {
        final blank = await repository.createQuestTemplateAddon(questId);
        addon.value = blank;
      }
      _initSignals(addon.value);
    } catch (e) {
      LoggerUtil.instance.e('初始化失败: $e');
      DialogUtil.instance.error('初始化失败: $e');
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collect();
      final repository = QuestTemplateAddonRepository();
      if (_originalId == 0) {
        await repository.storeQuestTemplateAddon(model);
      } else {
        await repository.updateQuestTemplateAddon(_originalId, model);
      }
      _originalId = model.id;
      addon.value = model;
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('模版补充数据已保存'));
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

  void _initSignals(QuestTemplateAddonEntity addon) {
    id.value = addon.id;
    maxLevel.value = addon.maxLevel;
    allowableClasses.value = addon.allowableClasses;
    sourceSpellId.value = addon.sourceSpellId;
    prevQuestId.value = addon.prevQuestId;
    nextQuestId.value = addon.nextQuestId;
    exclusiveGroup.value = addon.exclusiveGroup;
    rewardMailTemplateId.value = addon.rewardMailTemplateId;
    rewardMailDelay.value = addon.rewardMailDelay;
    requiredSkillId.value = addon.requiredSkillId;
    requiredSkillPoints.value = addon.requiredSkillPoints;
    requiredMinRepFaction.value = addon.requiredMinRepFaction;
    requiredMaxRepFaction.value = addon.requiredMaxRepFaction;
    requiredMinRepValue.value = addon.requiredMinRepValue;
    requiredMaxRepValue.value = addon.requiredMaxRepValue;
    providedItemCount.value = addon.providedItemCount;
    specialFlags.value = addon.specialFlags;
  }

  QuestTemplateAddonEntity _collect() {
    return QuestTemplateAddonEntity(
      id: questId.value,
      maxLevel: maxLevel.value,
      allowableClasses: allowableClasses.value,
      sourceSpellId: sourceSpellId.value,
      prevQuestId: prevQuestId.value,
      nextQuestId: nextQuestId.value,
      exclusiveGroup: exclusiveGroup.value,
      rewardMailTemplateId: rewardMailTemplateId.value,
      rewardMailDelay: rewardMailDelay.value,
      requiredSkillId: requiredSkillId.value,
      requiredSkillPoints: requiredSkillPoints.value,
      requiredMinRepFaction: requiredMinRepFaction.value,
      requiredMaxRepFaction: requiredMaxRepFaction.value,
      requiredMinRepValue: requiredMinRepValue.value,
      requiredMaxRepValue: requiredMaxRepValue.value,
      providedItemCount: providedItemCount.value,
      specialFlags: specialFlags.value,
    );
  }

  void dispose() {}
}
