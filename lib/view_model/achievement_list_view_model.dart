import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/achievement_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'achievement_list_view_model.g.dart';

@FoxyListViewModel(entity: AchievementEntity, repository: AchievementRepository)
class AchievementListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _AchievementListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'achievement',
      actionType: action,
      entityName: 'Achievement $key',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
