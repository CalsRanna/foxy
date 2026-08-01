// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milling_loot_template_collection_editor_view_model.dart';

mixin _MillingLootTemplateCollectionEditorViewModelMixin
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

  void _afterApplyCandidate(MillingLootTemplateEntity millingLootTemplate) {}

  void _applyCandidate(MillingLootTemplateEntity millingLootTemplate) {
    entryController.init(millingLootTemplate.entry);
    itemController.init(millingLootTemplate.item);
    referenceController.init(millingLootTemplate.reference);
    chanceController.init(millingLootTemplate.chance);
    questRequiredController.init(millingLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(millingLootTemplate.lootMode);
    groupIdController.init(millingLootTemplate.groupId);
    minCountController.init(millingLootTemplate.minCount);
    maxCountController.init(millingLootTemplate.maxCount);
    commentController.init(millingLootTemplate.comment);
    _afterApplyCandidate(millingLootTemplate);
  }

  MillingLootTemplateEntity _collectCandidate() {
    return MillingLootTemplateEntity(
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
