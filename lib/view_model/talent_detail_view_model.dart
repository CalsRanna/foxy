import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/talent_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'talent_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: TalentEntity,
  selects: {'flags': 0},
  repository: TalentRepository,
)
class TalentDetailViewModel
    with FieldControllerMixin, _TalentDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// 从所有 Controller 收集数据构建 Talent

  /// 退出页面

  @override
  void _logActivity(ActivityActionType action, TalentEntity talent) {
    final log = ActivityLogEntity(
      module: 'talent',
      actionType: action,
      entityName: 'Talent ${talent.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
