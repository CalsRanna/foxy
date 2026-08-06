import 'package:foxy/entity/quest_request_items_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_request_items_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_request_items_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: QuestRequestItemsEntity,
  repository: QuestRequestItemsRepository,
)
class QuestRequestItemsLinkedDetailViewModel
    with FieldControllerMixin, _QuestRequestItemsLinkedDetailViewModelMixin {  @override
  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'quest_request_items',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}