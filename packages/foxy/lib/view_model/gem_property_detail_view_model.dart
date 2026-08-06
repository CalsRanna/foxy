import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/gem_property_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'gem_property_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: GemPropertyEntity,
  selects: {'type': 0},
  repository: GemPropertyRepository,
)
class GemPropertyDetailViewModel
    with FieldControllerMixin, _GemPropertyDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// Collects data from all controllers to build the GemProperty

  /// Leaves the page

  @override
  void _logActivity(ActivityActionType action, GemPropertyEntity gemProperty) {
    final log = ActivityLogEntity(
      module: 'gem_property',
      actionType: action,
      entityName: 'GemProperty ${gemProperty.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
