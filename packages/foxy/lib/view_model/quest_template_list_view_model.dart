import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_template_entity.dart';
import 'package:foxy_annotation/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_template_list_view_model.g.dart';

@FoxyListViewModel(entity: QuestTemplateEntity, repository: QuestTemplateRepository)
class QuestTemplateListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _QuestTemplateListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final items = this.items.value;
    final template = items.where((t) => t.id == key).firstOrNull;
    final name = template?.logTitle ?? '';
    final log = ActivityLogEntity(
      module: 'quest_template',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
