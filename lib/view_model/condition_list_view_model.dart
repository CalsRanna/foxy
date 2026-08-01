import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'condition_list_view_model.g.dart';

@FoxyListViewModel(entity: ConditionEntity, repository: ConditionRepository)
class ConditionListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _ConditionListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, ConditionKey key) {
    final log = ActivityLogEntity(
      module: 'conditions',
      actionType: action,
      entityName:
          'Condition ${key.sourceTypeOrReferenceId}/${key.sourceGroup}/'
          '${key.sourceEntry}/${key.sourceId}/${key.elseGroup}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
