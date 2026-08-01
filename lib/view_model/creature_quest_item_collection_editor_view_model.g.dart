// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_item_collection_editor_view_model.dart';

mixin _CreatureQuestItemCollectionEditorViewModelMixin on FieldControllerMixin {
  late final creatureEntryController = registerController(IntFieldController());
  late final idxController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(CreatureQuestItemEntity creatureQuestItem) {}

  void _applyCandidate(CreatureQuestItemEntity creatureQuestItem) {
    creatureEntryController.init(creatureQuestItem.creatureEntry);
    idxController.init(creatureQuestItem.idx);
    itemIdController.init(creatureQuestItem.itemId);
    verifiedBuildController.init(creatureQuestItem.verifiedBuild);
    _afterApplyCandidate(creatureQuestItem);
  }

  CreatureQuestItemEntity _collectCandidate() {
    return CreatureQuestItemEntity(
      creatureEntry: creatureEntryController.collect(),
      idx: idxController.collect(),
      itemId: itemIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }
}
