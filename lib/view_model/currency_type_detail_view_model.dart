import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/currency_type_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'currency_type_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: CurrencyTypeEntity,
  repository: CurrencyTypeRepository,
)
class CurrencyTypeDetailViewModel
    with FieldControllerMixin, _CurrencyTypeDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// Collects data from all controllers to build the CurrencyType

  /// Leaves the page

  @override
  void _logActivity(
    ActivityActionType action,
    CurrencyTypeEntity currencyType,
  ) {
    final log = ActivityLogEntity(
      module: 'currency_type',
      actionType: action,
      entityName: 'CurrencyType ${currencyType.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
