// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_template_addon_single_editor_view_model.dart';

mixin _QuestTemplateAddonSingleEditorViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final maxLevelController = registerController(IntFieldController());
  late final allowableClassesController = registerController(
    FlagFieldController(),
  );
  late final sourceSpellIdController = registerController(IntFieldController());
  late final prevQuestIdController = registerController(IntFieldController());
  late final nextQuestIdController = registerController(IntFieldController());
  late final exclusiveGroupController = registerController(
    IntFieldController(),
  );
  late final breadcrumbForQuestIdController = registerController(
    IntFieldController(),
  );
  late final rewardMailTemplateIdController = registerController(
    IntFieldController(),
  );
  late final rewardMailDelayController = registerController(
    IntFieldController(),
  );
  late final requiredSkillIdController = registerController(
    IntFieldController(),
  );
  late final requiredSkillPointsController = registerController(
    IntFieldController(),
  );
  late final requiredMinRepFactionController = registerController(
    IntFieldController(),
  );
  late final requiredMaxRepFactionController = registerController(
    IntFieldController(),
  );
  late final requiredMinRepValueController = registerController(
    IntFieldController(),
  );
  late final requiredMaxRepValueController = registerController(
    IntFieldController(),
  );
  late final providedItemCountController = registerController(
    IntFieldController(),
  );
  late final specialFlagsController = registerController(FlagFieldController());

  QuestTemplateAddonEntity _collectCandidate() {
    return QuestTemplateAddonEntity(
      id: idController.collect(),
      maxLevel: maxLevelController.collect(),
      allowableClasses: allowableClassesController.collect(),
      sourceSpellId: sourceSpellIdController.collect(),
      prevQuestId: prevQuestIdController.collect(),
      nextQuestId: nextQuestIdController.collect(),
      exclusiveGroup: exclusiveGroupController.collect(),
      breadcrumbForQuestId: breadcrumbForQuestIdController.collect(),
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

  void _applyCandidate(QuestTemplateAddonEntity questTemplateAddon) {
    idController.init(questTemplateAddon.id);
    maxLevelController.init(questTemplateAddon.maxLevel);
    allowableClassesController.init(questTemplateAddon.allowableClasses);
    sourceSpellIdController.init(questTemplateAddon.sourceSpellId);
    prevQuestIdController.init(questTemplateAddon.prevQuestId);
    nextQuestIdController.init(questTemplateAddon.nextQuestId);
    exclusiveGroupController.init(questTemplateAddon.exclusiveGroup);
    breadcrumbForQuestIdController.init(
      questTemplateAddon.breadcrumbForQuestId,
    );
    rewardMailTemplateIdController.init(
      questTemplateAddon.rewardMailTemplateId,
    );
    rewardMailDelayController.init(questTemplateAddon.rewardMailDelay);
    requiredSkillIdController.init(questTemplateAddon.requiredSkillId);
    requiredSkillPointsController.init(questTemplateAddon.requiredSkillPoints);
    requiredMinRepFactionController.init(
      questTemplateAddon.requiredMinRepFaction,
    );
    requiredMaxRepFactionController.init(
      questTemplateAddon.requiredMaxRepFaction,
    );
    requiredMinRepValueController.init(questTemplateAddon.requiredMinRepValue);
    requiredMaxRepValueController.init(questTemplateAddon.requiredMaxRepValue);
    providedItemCountController.init(questTemplateAddon.providedItemCount);
    specialFlagsController.init(questTemplateAddon.specialFlags);
    _afterApplyCandidate(questTemplateAddon);
  }

  void _afterApplyCandidate(QuestTemplateAddonEntity questTemplateAddon) {}
}
