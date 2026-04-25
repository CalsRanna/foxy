import 'package:flutter/widgets.dart';
import 'package:foxy/model/quest_template_addon.dart';
import 'package:foxy/repository/quest_template_addon_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:signals/signals.dart';

/// QuestTemplateAddon 子表 ViewModel（1:1 编辑模式）
///
/// 17 个字段使用显式 TextEditingController（字段少，无需 Map 模式）。
/// search 即 find，不存在则进入创建模式。
class QuestTemplateAddonViewModel {
  final _repository = QuestTemplateAddonRepository();

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

  final loading = signal(false);
  final saving = signal(false);
  final creating = signal(true);
  final currentId = signal(0);

  int _originalId = 0;

  /// 加载：find addon，存在则填充 + creating=false，不存在则 create + creating=true
  Future<void> search(int questId) async {
    loading.value = true;
    try {
      final existing = await _repository.find(questId);
      if (existing != null) {
        creating.value = false;
        _originalId = existing.id;
        currentId.value = existing.id;
        _applyToControllers(existing);
      } else {
        creating.value = true;
        final blank = await _repository.create(questId);
        currentId.value = questId;
        _applyToControllers(blank);
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
      currentId.value = model.id;
      DialogUtil.instance.success('保存成功');
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    } finally {
      saving.value = false;
    }
  }

  void _applyToControllers(QuestTemplateAddon addon) {
    idController.text = addon.id.toString();
    maxLevelController.text = addon.maxLevel.toString();
    allowableClassesController.text = addon.allowableClasses.toString();
    sourceSpellIdController.text = addon.sourceSpellId.toString();
    prevQuestIdController.text = addon.prevQuestId.toString();
    nextQuestIdController.text = addon.nextQuestId.toString();
    exclusiveGroupController.text = addon.exclusiveGroup.toString();
    rewardMailTemplateIdController.text = addon.rewardMailTemplateId.toString();
    rewardMailDelayController.text = addon.rewardMailDelay.toString();
    requiredSkillIdController.text = addon.requiredSkillId.toString();
    requiredSkillPointsController.text = addon.requiredSkillPoints.toString();
    requiredMinRepFactionController.text = addon.requiredMinRepFaction.toString();
    requiredMaxRepFactionController.text = addon.requiredMaxRepFaction.toString();
    requiredMinRepValueController.text = addon.requiredMinRepValue.toString();
    requiredMaxRepValueController.text = addon.requiredMaxRepValue.toString();
    providedItemCountController.text = addon.providedItemCount.toString();
    specialFlagsController.text = addon.specialFlags.toString();
  }

  QuestTemplateAddon _collectFromControllers() {
    final addon = QuestTemplateAddon();
    addon.id = _parseInt(idController.text);
    addon.maxLevel = _parseInt(maxLevelController.text);
    addon.allowableClasses = _parseInt(allowableClassesController.text);
    addon.sourceSpellId = _parseInt(sourceSpellIdController.text);
    addon.prevQuestId = _parseInt(prevQuestIdController.text);
    addon.nextQuestId = _parseInt(nextQuestIdController.text);
    addon.exclusiveGroup = _parseInt(exclusiveGroupController.text);
    addon.rewardMailTemplateId = _parseInt(rewardMailTemplateIdController.text);
    addon.rewardMailDelay = _parseInt(rewardMailDelayController.text);
    addon.requiredSkillId = _parseInt(requiredSkillIdController.text);
    addon.requiredSkillPoints = _parseInt(requiredSkillPointsController.text);
    addon.requiredMinRepFaction = _parseInt(requiredMinRepFactionController.text);
    addon.requiredMaxRepFaction = _parseInt(requiredMaxRepFactionController.text);
    addon.requiredMinRepValue = _parseInt(requiredMinRepValueController.text);
    addon.requiredMaxRepValue = _parseInt(requiredMaxRepValueController.text);
    addon.providedItemCount = _parseInt(providedItemCountController.text);
    addon.specialFlags = _parseInt(specialFlagsController.text);
    return addon;
  }

  int _parseInt(String text) => int.tryParse(text) ?? 0;

  void dispose() {
    idController.dispose();
    maxLevelController.dispose();
    allowableClassesController.dispose();
    sourceSpellIdController.dispose();
    prevQuestIdController.dispose();
    nextQuestIdController.dispose();
    exclusiveGroupController.dispose();
    rewardMailTemplateIdController.dispose();
    rewardMailDelayController.dispose();
    requiredSkillIdController.dispose();
    requiredSkillPointsController.dispose();
    requiredMinRepFactionController.dispose();
    requiredMaxRepFactionController.dispose();
    requiredMinRepValueController.dispose();
    requiredMaxRepValueController.dispose();
    providedItemCountController.dispose();
    specialFlagsController.dispose();
  }
}