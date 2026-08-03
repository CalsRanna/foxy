import 'dart:math';

import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'npc_vendor_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: NpcVendorEntity,
  repository: NpcVendorRepository,
)
class NpcVendorLinkedListViewModel
    with FieldControllerMixin, _NpcVendorLinkedListViewModelMixin {  @override
  void _logActivity(ActivityActionType action, NpcVendorKey key) {
    final log = ActivityLogEntity(
      module: 'npc_vendor',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}