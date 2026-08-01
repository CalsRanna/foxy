import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/emote_text_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'emote_text_list_view_model.g.dart';

@FoxyListViewModel(entity: EmoteTextEntity, repository: EmoteTextRepository)
class EmoteTextListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _EmoteTextListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final templates = items.value;
    final template = templates.where((t) => t.key == key).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'emote_text',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
