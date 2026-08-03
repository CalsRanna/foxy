import 'dart:math';

import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'npc_trainer_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: NpcTrainerEntity,
  repository: NpcTrainerRepository,
)
class NpcTrainerLinkedListViewModel
    with FieldControllerMixin, _NpcTrainerLinkedListViewModelMixin {
  void clearLink() {
    ++_refreshToken;
    linkKey.value = null;
    items.value = const [];
    editingKey.value = null;
    selectedKey.value = null;
    page.value = 1;
    total.value = 0;
    loading.value = false;
    errorMessage.value = null;
    _applyCandidate(const NpcTrainerEntity());
  }
  @override
  void _logActivity(ActivityActionType action, NpcTrainerKey key) {
    final log = ActivityLogEntity(
      module: 'npc_trainer',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}