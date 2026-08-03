import 'dart:math';

import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/game_object_quest_ender_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'game_object_quest_ender_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: GameObjectQuestEnderEntity,
  repository: GameObjectQuestEnderRepository,
)
class GameObjectQuestEnderLinkedListViewModel
    with
        FieldControllerMixin,
        _GameObjectQuestEnderLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, GameObjectQuestEnderKey key) {
    final log = ActivityLogEntity(
      module: 'game_object_quest_ender',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}