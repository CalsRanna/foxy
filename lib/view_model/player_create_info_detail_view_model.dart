import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'player_create_info_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: PlayerCreateInfoEntity,
  selects: {'class_': 0, 'race': 0},
  repository: PlayerCreateInfoRepository,
)
class PlayerCreateInfoDetailViewModel
    with FieldControllerMixin, _PlayerCreateInfoDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  @override
  void _logActivity(
    ActivityActionType action,
    PlayerCreateInfoEntity playerCreateInfo,
  ) {
    final log = ActivityLogEntity(
      module: 'player_create_info',
      actionType: action,
      entityName:
          'PlayerCreateInfo ${playerCreateInfo.race}/${playerCreateInfo.class_}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
