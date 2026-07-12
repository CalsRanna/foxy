import 'package:flutter/widgets.dart';
import 'package:foxy/entity/quest_template_addon_entity.dart';
import 'package:foxy/repository/quest_template_addon_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class QuestTemplateAddonViewModel {
  final _repository = GetIt.instance.get<QuestTemplateAddonRepository>();
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final questId = signal(0);
  final addon = signal(QuestTemplateAddonEntity());

  final idController = IntFieldController();
  final maxLevelController = IntFieldController();
  final allowableClassesController = IntFieldController();
  final sourceSpellIdController = IntFieldController();
  final prevQuestIdController = IntFieldController();
  final nextQuestIdController = IntFieldController();
  final exclusiveGroupController = IntFieldController();
  final rewardMailTemplateIdController = IntFieldController();
  final rewardMailDelayController = IntFieldController();
  final requiredSkillIdController = IntFieldController();
  final requiredSkillPointsController = IntFieldController();
  final requiredMinRepFactionController = IntFieldController();
  final requiredMaxRepFactionController = IntFieldController();
  final requiredMinRepValueController = IntFieldController();
  final requiredMaxRepValueController = IntFieldController();
  final providedItemCountController = IntFieldController();
  final specialFlagsController = IntFieldController();

  late final _controllers = <FieldController>[
    idController,
    maxLevelController,
    allowableClassesController,
    sourceSpellIdController,
    prevQuestIdController,
    nextQuestIdController,
    exclusiveGroupController,
    rewardMailTemplateIdController,
    rewardMailDelayController,
    requiredSkillIdController,
    requiredSkillPointsController,
    requiredMinRepFactionController,
    requiredMaxRepFactionController,
    requiredMinRepValueController,
    requiredMaxRepValueController,
    providedItemCountController,
    specialFlagsController,
  ];

  int _originalId = 0;

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
    idController.init(addon.id);
    maxLevelController.init(addon.maxLevel);
    allowableClassesController.init(addon.allowableClasses);
    sourceSpellIdController.init(addon.sourceSpellId);
    prevQuestIdController.init(addon.prevQuestId);
    nextQuestIdController.init(addon.nextQuestId);
    exclusiveGroupController.init(addon.exclusiveGroup);
    rewardMailTemplateIdController.init(addon.rewardMailTemplateId);
    rewardMailDelayController.init(addon.rewardMailDelay);
    requiredSkillIdController.init(addon.requiredSkillId);
    requiredSkillPointsController.init(addon.requiredSkillPoints);
    requiredMinRepFactionController.init(addon.requiredMinRepFaction);
    requiredMaxRepFactionController.init(addon.requiredMaxRepFaction);
    requiredMinRepValueController.init(addon.requiredMinRepValue);
    requiredMaxRepValueController.init(addon.requiredMaxRepValue);
    providedItemCountController.init(addon.providedItemCount);
    specialFlagsController.init(addon.specialFlags);
  }

  QuestTemplateAddonEntity _collect() {
    return QuestTemplateAddonEntity(
      id: questId.value,
      maxLevel: maxLevelController.collect(),
      allowableClasses: allowableClassesController.collect(),
      sourceSpellId: sourceSpellIdController.collect(),
      prevQuestId: prevQuestIdController.collect(),
      nextQuestId: nextQuestIdController.collect(),
      exclusiveGroup: exclusiveGroupController.collect(),
      rewardMailTemplateId: rewardMailTemplateIdController.collect(),
      rewardMailDelay: rewardMailDelayController.collect(),
      requiredSkillId: requiredSkillIdController.collect(),
      requiredSkillPoints: requiredSkillPointsController.collect(),
      requiredMinRepFaction: requiredMinRepFactionController.collect(),
      requiredMaxRepFaction: requiredMaxRepFactionController.collect(),
      requiredMinRepValue: requiredMinRepValueController.collect(),
      requiredMaxRepValue: requiredMaxRepValueController.collect(),
      providedItemCount: providedItemCountController.collect(),
      specialFlags: specialFlagsController.collect(),
    );
  }

  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}
