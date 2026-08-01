// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_action_collection_editor_view_model.dart';

mixin _PlayerCreateInfoActionCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final raceController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final classController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final buttonController = registerController(IntFieldController());
  late final actionController = registerController(IntFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  PlayerCreateInfoActionEntity _collectCandidate() {
    return PlayerCreateInfoActionEntity(
      race: raceController.collect(),
      class_: classController.collect(),
      button: buttonController.collect(),
      action: actionController.collect(),
      type: typeController.collect(),
    );
  }

  void _applyCandidate(PlayerCreateInfoActionEntity playerCreateInfoAction) {
    raceController.init(playerCreateInfoAction.race);
    classController.init(playerCreateInfoAction.class_);
    buttonController.init(playerCreateInfoAction.button);
    actionController.init(playerCreateInfoAction.action);
    typeController.init(playerCreateInfoAction.type);
    _afterApplyCandidate(playerCreateInfoAction);
  }

  void _afterApplyCandidate(
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) {}
}
