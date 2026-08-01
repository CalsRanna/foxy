// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_item_collection_editor_view_model.dart';

mixin _GameObjectQuestItemCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final gameObjectEntryController = registerController(
    IntFieldController(),
  );
  late final idxController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  GameObjectQuestItemEntity _collectCandidate() {
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntryController.collect(),
      idx: idxController.collect(),
      itemId: itemIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _applyCandidate(GameObjectQuestItemEntity gameObjectQuestItem) {
    gameObjectEntryController.init(gameObjectQuestItem.gameObjectEntry);
    idxController.init(gameObjectQuestItem.idx);
    itemIdController.init(gameObjectQuestItem.itemId);
    verifiedBuildController.init(gameObjectQuestItem.verifiedBuild);
    _afterApplyCandidate(gameObjectQuestItem);
  }

  void _afterApplyCandidate(GameObjectQuestItemEntity gameObjectQuestItem) {}
}
