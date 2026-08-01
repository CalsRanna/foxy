import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/area_table_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'area_table_list_view_model.g.dart';

@FoxyListViewModel(entity: AreaTableEntity, repository: AreaTableRepository)
class AreaTableListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _AreaTableListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final items = this.items.value;
    final area = items.where((a) => a.key == key).firstOrNull;
    final name = area?.areaNameLangZhCN ?? '';
    final log = ActivityLogEntity(
      module: 'area_table',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
