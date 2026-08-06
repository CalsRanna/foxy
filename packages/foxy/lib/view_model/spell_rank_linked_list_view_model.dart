import 'dart:math';

import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/spell_rank_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_rank_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: SpellRankEntity,
  repository: SpellRankRepository,
)
class SpellRankLinkedListViewModel
    with FieldControllerMixin, _SpellRankLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, SpellRankKey key) {
    final log = ActivityLogEntity(
      module: 'spell_rank',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}