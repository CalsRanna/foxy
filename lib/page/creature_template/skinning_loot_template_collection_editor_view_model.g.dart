// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skinning_loot_template_collection_editor_view_model.dart';

mixin _SkinningLootTemplateCollectionEditorViewModelMixin
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

  SkinningLootTemplateEntity _collectCandidate() {
    return SkinningLootTemplateEntity(
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

  void _applyCandidate(SkinningLootTemplateEntity skinningLootTemplate) {
    entryController.init(skinningLootTemplate.entry);
    itemController.init(skinningLootTemplate.item);
    referenceController.init(skinningLootTemplate.reference);
    chanceController.init(skinningLootTemplate.chance);
    questRequiredController.init(skinningLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(skinningLootTemplate.lootMode);
    groupIdController.init(skinningLootTemplate.groupId);
    minCountController.init(skinningLootTemplate.minCount);
    maxCountController.init(skinningLootTemplate.maxCount);
    commentController.init(skinningLootTemplate.comment);
    _afterApplyCandidate(skinningLootTemplate);
  }

  void _afterApplyCandidate(SkinningLootTemplateEntity skinningLootTemplate) {}
}
