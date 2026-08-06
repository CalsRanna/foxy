import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy_annotation/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'smart_script_list_view_model.g.dart';

@FoxyListViewModel(entity: SmartScriptEntity, repository: SmartScriptRepository)
class SmartScriptListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _SmartScriptListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, SmartScriptKey key) {
    final templates = items.value;
    final template = templates.where((t) => t.key == key).firstOrNull;
    final name = template?.comment ?? '';
    final log = ActivityLogEntity(
      module: 'smart_script',
      actionType: action,
      entityName:
          'SmartScript ${key.entryOrGuid}/${key.sourceType}/${key.id}/${key.link}'
          '${name.isEmpty ? '' : ' - $name'}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
