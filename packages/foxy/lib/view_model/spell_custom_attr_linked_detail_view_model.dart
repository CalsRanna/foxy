import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_custom_attr_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: SpellCustomAttrEntity,
  repository: SpellCustomAttrRepository,
  flags: {'attributes'},
)
class SpellCustomAttrLinkedDetailViewModel
    with FieldControllerMixin, _SpellCustomAttrLinkedDetailViewModelMixin {  @override
  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'spell_custom_attr',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}