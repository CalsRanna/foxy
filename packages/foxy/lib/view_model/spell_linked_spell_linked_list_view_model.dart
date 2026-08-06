import 'dart:math';

import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/spell_linked_spell_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_linked_spell_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: SpellLinkedSpellEntity,
  selects: {'type': 0},
  repository: SpellLinkedSpellRepository,
)
class SpellLinkedSpellLinkedListViewModel
    with
        FieldControllerMixin,
        _SpellLinkedSpellLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, SpellLinkedSpellKey key) {
    final log = ActivityLogEntity(
      module: 'spell_linked_spell',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}