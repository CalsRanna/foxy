import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/reference_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/reference_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'reference_loot_template_list_view_model.g.dart';

@FoxyListViewModel(
  entity: ReferenceLootTemplateEntity,
  repository: ReferenceLootTemplateRepository,
)
class ReferenceLootTemplateListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _ReferenceLootTemplateListViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  @override
  void _logActivity(
    ActivityActionType action,
    ReferenceLootTemplateKey key,
  ) {
    _activityLogService.recordBestEffort(
      ActivityLogEntity(
        module: 'reference_loot_template',
        actionType: action,
        entityName: 'ReferenceLoot ${key.entry}/${key.item}',
        createdAt: DateTime.now(),
      ),
    );
  }
}
