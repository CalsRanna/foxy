// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_loot_template_collection_editor_view_model.dart';

mixin _ItemLootTemplateCollectionEditorViewModelMixin on FieldControllerMixin {
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

  ItemLootTemplateEntity _collectCandidate() {
    return ItemLootTemplateEntity(
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

  void _applyCandidate(ItemLootTemplateEntity itemLootTemplate) {
    entryController.init(itemLootTemplate.entry);
    itemController.init(itemLootTemplate.item);
    referenceController.init(itemLootTemplate.reference);
    chanceController.init(itemLootTemplate.chance);
    questRequiredController.init(itemLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(itemLootTemplate.lootMode);
    groupIdController.init(itemLootTemplate.groupId);
    minCountController.init(itemLootTemplate.minCount);
    maxCountController.init(itemLootTemplate.maxCount);
    commentController.init(itemLootTemplate.comment);
    _afterApplyCandidate(itemLootTemplate);
  }

  void _afterApplyCandidate(ItemLootTemplateEntity itemLootTemplate) {}
}
