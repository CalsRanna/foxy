// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_quest_starter_collection_editor_view_model.dart';

mixin _GameObjectQuestStarterCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final questController = registerController(IntFieldController());

  GameObjectQuestStarterEntity _collectCandidate() {
    return GameObjectQuestStarterEntity(
      id: idController.collect(),
      quest: questController.collect(),
    );
  }

  void _applyCandidate(GameObjectQuestStarterEntity gameObjectQuestStarter) {
    idController.init(gameObjectQuestStarter.id);
    questController.init(gameObjectQuestStarter.quest);
    _afterApplyCandidate(gameObjectQuestStarter);
  }

  void _afterApplyCandidate(
    GameObjectQuestStarterEntity gameObjectQuestStarter,
  ) {}
}
