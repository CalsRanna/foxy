import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'scaling_stat_value_list_view_model.g.dart';

@FoxyListViewModel(entity: ScalingStatValueEntity, repository: ScalingStatValueRepository)
class ScalingStatValueListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _ScalingStatValueListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'scaling_stat_value',
      actionType: action,
      entityName: 'ScalingStatValue $key',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
