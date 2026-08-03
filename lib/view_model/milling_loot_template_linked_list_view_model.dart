import 'dart:math';

import 'package:foxy/entity/milling_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/milling_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'milling_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: MillingLootTemplateEntity,
  flags: {'lootMode'},
  repository: MillingLootTemplateRepository,
)
class MillingLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _MillingLootTemplateLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, MillingLootTemplateKey key) {
    final log = ActivityLogEntity(
      module: 'milling_loot_template',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}