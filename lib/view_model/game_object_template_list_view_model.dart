import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/game_object_template_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'game_object_template_list_view_model.g.dart';

@FoxyListViewModel(entity: GameObjectTemplateEntity, repository: GameObjectTemplateRepository)
class GameObjectTemplateListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _GameObjectTemplateListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final all = items.value;
    final template = all.where((t) => t.entry == key).firstOrNull;
    final name = template?.name ?? '';
    final log = ActivityLogEntity(
      module: 'gameobject_template',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
