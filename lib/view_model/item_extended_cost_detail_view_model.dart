import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/item_extended_cost_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'item_extended_cost_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: ItemExtendedCostEntity,
  selects: {'arenaBracket': 0},
  repository: ItemExtendedCostRepository,
)
class ItemExtendedCostDetailViewModel
    with FieldControllerMixin, _ItemExtendedCostDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// Collects data from all controllers to build the ItemExtendedCost

  /// Leaves the page

  @override
  void _logActivity(
    ActivityActionType action,
    ItemExtendedCostEntity itemExtendedCost,
  ) {
    final log = ActivityLogEntity(
      module: 'item_extended_cost',
      actionType: action,
      entityName: 'ItemExtendedCost ${itemExtendedCost.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
