import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/game_object_template_addon_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'game_object_template_addon_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: GameObjectTemplateAddonEntity,
  repository: GameObjectTemplateAddonRepository,
  flags: {'flags'},
)
class GameObjectTemplateAddonLinkedDetailViewModel
    with FieldControllerMixin, _GameObjectTemplateAddonLinkedDetailViewModelMixin {  @override
  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'game_object_template_addon',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}