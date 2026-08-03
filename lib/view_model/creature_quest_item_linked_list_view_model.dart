import 'dart:math';

import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_quest_item_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: CreatureQuestItemEntity,
  repository: CreatureQuestItemRepository,
)
class CreatureQuestItemLinkedListViewModel
    with
        FieldControllerMixin,
        _CreatureQuestItemLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, CreatureQuestItemKey key) {
    final log = ActivityLogEntity(
      module: 'creature_quest_item',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}