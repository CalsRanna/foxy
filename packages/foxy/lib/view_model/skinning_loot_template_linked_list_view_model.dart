import 'dart:math';

import 'package:foxy/entity/skinning_loot_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/skinning_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'skinning_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: SkinningLootTemplateEntity,
  flags: {'lootMode'},
  repository: SkinningLootTemplateRepository,
)
class SkinningLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _SkinningLootTemplateLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, SkinningLootTemplateKey key) {
    final log = ActivityLogEntity(
      module: 'skinning_loot_template',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}