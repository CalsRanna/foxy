// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_request_items_single_editor_view_model.dart';

mixin _QuestRequestItemsSingleEditorViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final emoteOnCompleteController = registerController(
    IntFieldController(),
  );
  late final emoteOnIncompleteController = registerController(
    IntFieldController(),
  );
  late final completionTextController = registerController(
    StringFieldController(),
  );
  late final verifiedBuildController = registerController(IntFieldController());

  QuestRequestItemsEntity _collectCandidate() {
    return QuestRequestItemsEntity(
      id: idController.collect(),
      emoteOnComplete: emoteOnCompleteController.collect(),
      emoteOnIncomplete: emoteOnIncompleteController.collect(),
      completionText: completionTextController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _applyCandidate(QuestRequestItemsEntity questRequestItems) {
    idController.init(questRequestItems.id);
    emoteOnCompleteController.init(questRequestItems.emoteOnComplete);
    emoteOnIncompleteController.init(questRequestItems.emoteOnIncomplete);
    completionTextController.init(questRequestItems.completionText);
    verifiedBuildController.init(questRequestItems.verifiedBuild);
    _afterApplyCandidate(questRequestItems);
  }

  void _afterApplyCandidate(QuestRequestItemsEntity questRequestItems) {}
}
