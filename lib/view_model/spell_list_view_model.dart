import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_list_view_model.g.dart';

@FoxyListViewModel(entity: SpellEntity, repository: SpellRepository)
class SpellListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _SpellListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final templates = items.value;
    final template = templates.where((t) => t.id == key).firstOrNull;
    final name = template?.displayName ?? '';
    final log = ActivityLogEntity(
      module: 'spell',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
