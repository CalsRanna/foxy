import 'dart:math';

import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: SpellLootTemplateEntity,
  selects: {'questRequired': 0},
  repository: SpellLootTemplateRepository,
)
class SpellLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _SpellLootTemplateLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, SpellLootTemplateKey key) {
    final log = ActivityLogEntity(
      module: 'spell_loot_template',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}