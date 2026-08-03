import 'dart:math';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/pickpocketing_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/pickpocketing_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'pickpocketing_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: PickpocketingLootTemplateEntity,
  flags: {'lootMode'},
  repository: PickpocketingLootTemplateRepository,
)
class PickpocketingLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _PickpocketingLootTemplateLinkedListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, PickpocketingLootTemplateKey key) {
    final log = ActivityLogEntity(
      module: 'pickpocketing_loot_template',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
