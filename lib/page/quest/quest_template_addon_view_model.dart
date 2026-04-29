import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_template_addon.dart';
import 'package:foxy/repository/quest_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestTemplateAddonViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);
  final addon = signal(QuestTemplateAddon());

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

  Future<void> initSignals({required int questId}) async {
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
    _initControllers(addon.value);
  }

  Future<void> save(BuildContext context) async {
    try {
      final model = _collectFromControllers();
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

  void _initControllers(QuestTemplateAddon addon) {
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
    requiredMinRepFactionController.text = addon.requiredMinRepFaction
        .toString();
    requiredMaxRepFactionController.text = addon.requiredMaxRepFaction
        .toString();
    requiredMinRepValueController.text = addon.requiredMinRepValue.toString();
    requiredMaxRepValueController.text = addon.requiredMaxRepValue.toString();
    providedItemCountController.text = addon.providedItemCount.toString();
    specialFlagsController.text = addon.specialFlags.toString();
  }

  QuestTemplateAddon _collectFromControllers() {
    return QuestTemplateAddon(
      id: questId.value,
      maxLevel: _parseInt(maxLevelController.text),
      allowableClasses: _parseInt(allowableClassesController.text),
      sourceSpellId: _parseInt(sourceSpellIdController.text),
      prevQuestId: _parseInt(prevQuestIdController.text),
      nextQuestId: _parseInt(nextQuestIdController.text),
      exclusiveGroup: _parseInt(exclusiveGroupController.text),
      rewardMailTemplateId: _parseInt(rewardMailTemplateIdController.text),
      rewardMailDelay: _parseInt(rewardMailDelayController.text),
      requiredSkillId: _parseInt(requiredSkillIdController.text),
      requiredSkillPoints: _parseInt(requiredSkillPointsController.text),
      requiredMinRepFaction: _parseInt(requiredMinRepFactionController.text),
      requiredMaxRepFaction: _parseInt(requiredMaxRepFactionController.text),
      requiredMinRepValue: _parseInt(requiredMinRepValueController.text),
      requiredMaxRepValue: _parseInt(requiredMaxRepValueController.text),
      providedItemCount: _parseInt(providedItemCountController.text),
      specialFlags: _parseInt(specialFlagsController.text),
    );
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

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
