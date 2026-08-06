import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_template_addon_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_template_addon_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: CreatureTemplateAddonEntity,
  repository: CreatureTemplateAddonRepository,
  selects: {'visibilityDistanceType': 0},
)
class CreatureTemplateAddonLinkedDetailViewModel
    with FieldControllerMixin, _CreatureTemplateAddonLinkedDetailViewModelMixin {  @override
  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'creature_template_addon',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}