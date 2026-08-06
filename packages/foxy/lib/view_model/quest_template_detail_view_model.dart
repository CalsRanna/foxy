import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_template_detail_view_model.g.dart';

@FoxyDetailViewModel(
  entity: QuestTemplateEntity,
  flags: {'allowableRaces', 'flags'},
  selects: {
    'questType': 2,
    'rewardMoneyDifficulty': 0,
    'rewardXpDifficulty': 0,
  },
  repository: QuestTemplateRepository,
)
class QuestTemplateDetailViewModel
    with FieldControllerMixin, _QuestTemplateDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  @override
  void _logActivity(
    ActivityActionType action,
    QuestTemplateEntity questTemplate,
  ) {
    final log = ActivityLogEntity(
      module: 'quest_template',
      actionType: action,
      entityName: questTemplate.logTitle,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
