// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_ender_collection_editor_view_model.dart';

mixin _GameObjectQuestEnderCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final questController = registerController(IntFieldController());

  GameObjectQuestEnderEntity _collectCandidate() {
    return GameObjectQuestEnderEntity(
      id: idController.collect(),
      quest: questController.collect(),
    );
  }

  void _applyCandidate(GameObjectQuestEnderEntity gameObjectQuestEnder) {
    idController.init(gameObjectQuestEnder.id);
    questController.init(gameObjectQuestEnder.quest);
    _afterApplyCandidate(gameObjectQuestEnder);
  }

  void _afterApplyCandidate(GameObjectQuestEnderEntity gameObjectQuestEnder) {}
}
