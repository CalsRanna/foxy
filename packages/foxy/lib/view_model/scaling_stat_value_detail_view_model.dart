import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/scaling_stat_value_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'scaling_stat_value_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: ScalingStatValueEntity,
  repository: ScalingStatValueRepository,
)
class ScalingStatValueDetailViewModel
    with FieldControllerMixin, _ScalingStatValueDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// Collects data from all controllers to build the ScalingStatValue

  /// Leaves the page

  @override
  void _logActivity(
    ActivityActionType action,
    ScalingStatValueEntity scalingStatValue,
  ) {
    final log = ActivityLogEntity(
      module: 'scaling_stat_value',
      actionType: action,
      entityName: 'ScalingStatValue ${scalingStatValue.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
