// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_starter_collection_editor_view_model.dart';

mixin _CreatureQuestStarterCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final questController = registerController(IntFieldController());

  void _afterApplyCandidate(CreatureQuestStarterEntity creatureQuestStarter) {}

  void _applyCandidate(CreatureQuestStarterEntity creatureQuestStarter) {
    idController.init(creatureQuestStarter.id);
    questController.init(creatureQuestStarter.quest);
    _afterApplyCandidate(creatureQuestStarter);
  }

  CreatureQuestStarterEntity _collectCandidate() {
    return CreatureQuestStarterEntity(
      id: idController.collect(),
      quest: questController.collect(),
    );
  }
}
