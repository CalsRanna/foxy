// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_loot_template_collection_editor_view_model.dart';

mixin _GameObjectLootTemplateCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final itemController = registerController(IntFieldController());
  late final referenceController = registerController(IntFieldController());
  late final chanceController = registerController(DoubleFieldController());
  late final questRequiredController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final lootModeController = registerController(IntFieldController());
  late final groupIdController = registerController(IntFieldController());
  late final minCountController = registerController(IntFieldController());
  late final maxCountController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  GameObjectLootTemplateEntity _collectCandidate() {
    return GameObjectLootTemplateEntity(
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

  void _applyCandidate(GameObjectLootTemplateEntity gameObjectLootTemplate) {
    entryController.init(gameObjectLootTemplate.entry);
    itemController.init(gameObjectLootTemplate.item);
    referenceController.init(gameObjectLootTemplate.reference);
    chanceController.init(gameObjectLootTemplate.chance);
    questRequiredController.init(gameObjectLootTemplate.questRequired ? 1 : 0);
    lootModeController.init(gameObjectLootTemplate.lootMode);
    groupIdController.init(gameObjectLootTemplate.groupId);
    minCountController.init(gameObjectLootTemplate.minCount);
    maxCountController.init(gameObjectLootTemplate.maxCount);
    commentController.init(gameObjectLootTemplate.comment);
    _afterApplyCandidate(gameObjectLootTemplate);
  }

  void _afterApplyCandidate(
    GameObjectLootTemplateEntity gameObjectLootTemplate,
  ) {}
}
