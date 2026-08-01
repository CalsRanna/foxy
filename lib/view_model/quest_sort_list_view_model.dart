import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/quest_sort_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'quest_sort_list_view_model.g.dart';

@FoxyListViewModel(entity: QuestSortEntity, repository: QuestSortRepository)
class QuestSortListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _QuestSortListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final items = this.items.value;
    final sort = items.where((s) => s.key == key).firstOrNull;
    final name = sort?.sortNameLangZhCN ?? '';
    final log = ActivityLogEntity(
      module: 'quest_sort',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
