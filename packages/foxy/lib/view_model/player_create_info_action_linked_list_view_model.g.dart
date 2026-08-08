// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_action_linked_list_view_model.dart';

mixin _PlayerCreateInfoActionLinkedListViewModelMixin on FieldControllerMixin {
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

  void _afterApplyCandidate(
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) {}

  void _applyCandidate(PlayerCreateInfoActionEntity playerCreateInfoAction) {
    raceController.init(playerCreateInfoAction.race);
    classController.init(playerCreateInfoAction.class_);
    buttonController.init(playerCreateInfoAction.button);
    actionController.init(playerCreateInfoAction.action);
    typeController.init(playerCreateInfoAction.type);
    _afterApplyCandidate(playerCreateInfoAction);
  }

  PlayerCreateInfoActionEntity _collectCandidate() {
    return PlayerCreateInfoActionEntity(
      race: raceController.collect(),
      class_: classController.collect(),
      button: buttonController.collect(),
      action: actionController.collect(),
      type: typeController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    PlayerCreateInfoActionEntity playerCreateInfoAction,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'playercreateinfo_action',
          actionType: action,
          entityName: 'PlayerCreateInfoAction',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
