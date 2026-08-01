// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disenchant_loot_template_collection_editor_view_model.dart';

mixin _DisenchantLootTemplateCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(FlagFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  void _afterApplyCandidate(
    DisenchantLootTemplateEntity disenchantLootTemplate,
  ) {}

  void _applyCandidate(DisenchantLootTemplateEntity disenchantLootTemplate) {
    entryController.init(disenchantLootTemplate.entry);
    itemController.init(disenchantLootTemplate.item);
    referenceController.init(disenchantLootTemplate.reference);
    chanceController.init(disenchantLootTemplate.chance);
    questRequiredController.init(disenchantLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(disenchantLootTemplate.lootMode);
    groupIdController.init(disenchantLootTemplate.groupId);
    minCountController.init(disenchantLootTemplate.minCount);
    maxCountController.init(disenchantLootTemplate.maxCount);
    commentController.init(disenchantLootTemplate.comment);
    _afterApplyCandidate(disenchantLootTemplate);
  }

  DisenchantLootTemplateEntity _collectCandidate() {
    return DisenchantLootTemplateEntity(
      entry: entryController.collect(),
      item: itemController.collect(),
      reference: referenceController.collect(),
      chance: chanceController.collect(),
      questRequired: questRequiredController.collect() == 1,
      lootMode: lootModeController.collect(),
      groupId: groupIdController.collect(),
      minCount: minCountController.collect(),
      maxCount: maxCountController.collect(),
      comment: commentController.collect(),
    );
  }
}
