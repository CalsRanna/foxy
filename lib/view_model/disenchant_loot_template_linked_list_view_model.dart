import 'dart:math';

import 'package:foxy/entity/disenchant_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/disenchant_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'disenchant_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: DisenchantLootTemplateEntity,
  flags: {'lootMode'},
  repository: DisenchantLootTemplateRepository,
)
class DisenchantLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _DisenchantLootTemplateLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, DisenchantLootTemplateKey key) {
    final log = ActivityLogEntity(
      module: 'disenchant_loot_template',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}