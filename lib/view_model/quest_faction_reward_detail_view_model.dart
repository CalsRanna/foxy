import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_faction_reward_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_faction_reward_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: QuestFactionRewardEntity,
  repository: QuestFactionRewardRepository,
)
class QuestFactionRewardDetailViewModel
    with FieldControllerMixin, _QuestFactionRewardDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  /// Collects data from all controllers to build the QuestFactionReward

  /// Leaves the page

  @override
  void _logActivity(
    ActivityActionType action,
    QuestFactionRewardEntity questFactionReward,
  ) {
    final log = ActivityLogEntity(
      module: 'quest_faction_reward',
      actionType: action,
      entityName: 'QuestFactionReward ${questFactionReward.id}',
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
