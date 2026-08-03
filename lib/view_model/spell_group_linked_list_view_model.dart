import 'dart:math';

import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/spell_group_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_group_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: SpellGroupEntity,
  repository: SpellGroupRepository,
)
class SpellGroupLinkedListViewModel
    with FieldControllerMixin, _SpellGroupLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, SpellGroupKey key) {
    final log = ActivityLogEntity(
      module: 'spell_group',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}