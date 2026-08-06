import 'dart:math';

import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/creature_quest_ender_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_quest_ender_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: CreatureQuestEnderEntity,
  repository: CreatureQuestEnderRepository,
)
class CreatureQuestEnderLinkedListViewModel
    with
        FieldControllerMixin,
        _CreatureQuestEnderLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, CreatureQuestEnderKey key) {
    final log = ActivityLogEntity(
      module: 'creature_quest_ender',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}