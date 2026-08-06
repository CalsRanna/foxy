import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'emote_text_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: EmoteTextEntity, repository: EmoteTextRepository)
class EmoteTextDetailViewModel
    with FieldControllerMixin, _EmoteTextDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  @override
  void _logActivity(ActivityActionType action, EmoteTextEntity emoteText) {
    final log = ActivityLogEntity(
      module: 'emote_text',
      actionType: action,
      entityName: emoteText.name,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
