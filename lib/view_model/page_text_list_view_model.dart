import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/infrastructure/codegen/list_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'page_text_list_view_model.g.dart';

@FoxyListViewModel(entity: PageTextEntity, repository: PageTextRepository)
class PageTextListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _PageTextListViewModelMixin {
  @override
  void _logActivity(ActivityActionType action, int key) {
    final items = this.items.value;
    final page = items.where((p) => p.key == key).firstOrNull;
    final name = page?.text ?? '';
    final log = ActivityLogEntity(
      module: 'page_text',
      actionType: action,
      entityName: name,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}
