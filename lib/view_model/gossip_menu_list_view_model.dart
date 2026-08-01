import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'gossip_menu_list_view_model.g.dart';

@FoxyListViewModel(entity: GossipMenuEntity, repository: GossipMenuRepository)
class GossipMenuListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _GossipMenuListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, GossipMenuKey key) {
    final templates = items.value;
    final template = templates.where((t) => t.key == key).firstOrNull;
    final name = template?.text ?? '';
    final log = ActivityLogEntity(
      module: 'gossip_menu',
      actionType: action,
      entityName:
          'GossipMenu ${key.menuId}/${key.textId}${name.isEmpty ? '' : ' - $name'}',
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
