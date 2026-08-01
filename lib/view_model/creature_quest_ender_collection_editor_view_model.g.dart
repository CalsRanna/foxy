// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_ender_collection_editor_view_model.dart';

mixin _CreatureQuestEnderCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final questController = registerController(IntFieldController());

  void _afterApplyCandidate(CreatureQuestEnderEntity creatureQuestEnder) {}

  void _applyCandidate(CreatureQuestEnderEntity creatureQuestEnder) {
    idController.init(creatureQuestEnder.id);
    questController.init(creatureQuestEnder.quest);
    _afterApplyCandidate(creatureQuestEnder);
  }

  CreatureQuestEnderEntity _collectCandidate() {
    return CreatureQuestEnderEntity(
      id: idController.collect(),
      quest: questController.collect(),
    );
  }
}
