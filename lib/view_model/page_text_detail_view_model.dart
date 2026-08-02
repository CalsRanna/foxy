import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'page_text_detail_view_model.g.dart';

@FoxyDetailViewModel(entity: PageTextEntity, repository: PageTextRepository)
class PageTextDetailViewModel
    with FieldControllerMixin, _PageTextDetailViewModelMixin {
  final _activityLogService = GetIt.instance.get<ActivityLogService>();

  @override
  void _logActivity(ActivityActionType action, PageTextEntity pageText) {
    final log = ActivityLogEntity(
      module: 'page_text',
      actionType: action,
      entityName: pageText.text,
      createdAt: DateTime.now(),
    );
    _activityLogService.recordBestEffort(log);
  }
}
