import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'scaling_stat_distribution_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: ScalingStatDistributionEntity,
  selects: {
    'statId0': 0,
    'statId1': 0,
    'statId2': 0,
    'statId3': 0,
    'statId4': 0,
    'statId5': 0,
    'statId6': 0,
    'statId7': 0,
    'statId8': 0,
    'statId9': 0,
  },
  repository: ScalingStatDistributionRepository,
)
class ScalingStatDistributionDetailViewModel
    with FieldControllerMixin, _ScalingStatDistributionDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// 从所有 Controller 收集数据构建 ScalingStatDistribution

  /// 退出页面

  @override
  void _logActivity(
    ActivityActionType action,
    ScalingStatDistributionEntity t,
  ) {
    final log = ActivityLogEntity(
      module: 'scaling_stat_distribution',
      actionType: action,
      entityName: 'ScalingStatDistribution ${t.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
