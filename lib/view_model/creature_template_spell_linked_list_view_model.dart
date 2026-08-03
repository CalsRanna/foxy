import 'dart:math';

import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_template_spell_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: CreatureTemplateSpellEntity,
  repository: CreatureTemplateSpellRepository,
)
class CreatureTemplateSpellLinkedListViewModel
    with
        FieldControllerMixin,
        _CreatureTemplateSpellLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, CreatureTemplateSpellKey key) {
    final log = ActivityLogEntity(
      module: 'creature_template_spell',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}