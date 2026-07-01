import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/repository/quest_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestTemplateAddonViewModel {
  final _repository = GetIt.instance.get<QuestTemplateAddonRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);
  final addon = signal(QuestTemplateAddonEntity());

  final idController = TextEditingController();
  final maxLevelController = TextEditingController();
  final allowableClassesController = TextEditingController();
  final sourceSpellIdController = TextEditingController();
  final prevQuestIdController = TextEditingController();
  final nextQuestIdController = TextEditingController();
  final exclusiveGroupController = TextEditingController();
  final rewardMailTemplateIdController = TextEditingController();
  final rewardMailDelayController = TextEditingController();
  final requiredSkillIdController = TextEditingController();
  final requiredSkillPointsController = TextEditingController();
  final requiredMinRepFactionController = TextEditingController();
  final requiredMaxRepFactionController = TextEditingController();
  final requiredMinRepValueController = TextEditingController();
  final requiredMaxRepValueController = TextEditingController();
  final providedItemCountController = TextEditingController();
  final specialFlagsController = TextEditingController();

  int _originalId = 0;

  String _fmt(num v) => formatNum(v);

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> initSignals({required int questId}) async {
    try {
      this.questId.value = questId;
      final existing = await _repository.getQuestTemplateAddon(questId);
      if (existing != null) {
        _originalId = existing.id;
        addon.value = existing;
      } else {
        final blank = await _repository.createQuestTemplateAddon(questId);
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
      if (_originalId == 0) {
        await _repository.storeQuestTemplateAddon(model);
      } else {
        await _repository.updateQuestTemplateAddon(_originalId, model);
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
    idController.text = _fmt(addon.id);
    maxLevelController.text = _fmt(addon.maxLevel);
    allowableClassesController.text = _fmt(addon.allowableClasses);
    sourceSpellIdController.text = _fmt(addon.sourceSpellId);
    prevQuestIdController.text = _fmt(addon.prevQuestId);
    nextQuestIdController.text = _fmt(addon.nextQuestId);
    exclusiveGroupController.text = _fmt(addon.exclusiveGroup);
    rewardMailTemplateIdController.text = _fmt(addon.rewardMailTemplateId);
    rewardMailDelayController.text = _fmt(addon.rewardMailDelay);
    requiredSkillIdController.text = _fmt(addon.requiredSkillId);
    requiredSkillPointsController.text = _fmt(addon.requiredSkillPoints);
    requiredMinRepFactionController.text = _fmt(addon.requiredMinRepFaction);
    requiredMaxRepFactionController.text = _fmt(addon.requiredMaxRepFaction);
    requiredMinRepValueController.text = _fmt(addon.requiredMinRepValue);
    requiredMaxRepValueController.text = _fmt(addon.requiredMaxRepValue);
    providedItemCountController.text = _fmt(addon.providedItemCount);
    specialFlagsController.text = _fmt(addon.specialFlags);
  }

  QuestTemplateAddonEntity _collect() {
    return QuestTemplateAddonEntity(
      id: questId.value,
      maxLevel: _pi(maxLevelController.text),
      allowableClasses: _pi(allowableClassesController.text),
      sourceSpellId: _pi(sourceSpellIdController.text),
      prevQuestId: _pi(prevQuestIdController.text),
      nextQuestId: _pi(nextQuestIdController.text),
      exclusiveGroup: _pi(exclusiveGroupController.text),
      rewardMailTemplateId: _pi(rewardMailTemplateIdController.text),
      rewardMailDelay: _pi(rewardMailDelayController.text),
      requiredSkillId: _pi(requiredSkillIdController.text),
      requiredSkillPoints: _pi(requiredSkillPointsController.text),
      requiredMinRepFaction: _pi(requiredMinRepFactionController.text),
      requiredMaxRepFaction: _pi(requiredMaxRepFactionController.text),
      requiredMinRepValue: _pi(requiredMinRepValueController.text),
      requiredMaxRepValue: _pi(requiredMaxRepValueController.text),
      providedItemCount: _pi(providedItemCountController.text),
      specialFlags: _pi(specialFlagsController.text),
    );
  }

  void dispose() {
    allowableClassesController.dispose();
    exclusiveGroupController.dispose();
    idController.dispose();
    maxLevelController.dispose();
    nextQuestIdController.dispose();
    prevQuestIdController.dispose();
    providedItemCountController.dispose();
    requiredMaxRepFactionController.dispose();
    requiredMaxRepValueController.dispose();
    requiredMinRepFactionController.dispose();
    requiredMinRepValueController.dispose();
    requiredSkillIdController.dispose();
    requiredSkillPointsController.dispose();
    rewardMailDelayController.dispose();
    rewardMailTemplateIdController.dispose();
    sourceSpellIdController.dispose();
    specialFlagsController.dispose();
  }
}
