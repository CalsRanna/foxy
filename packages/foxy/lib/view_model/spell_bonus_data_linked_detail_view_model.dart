import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_bonus_data_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: SpellBonusDataEntity,
  repository: SpellBonusDataRepository,
)
class SpellBonusDataLinkedDetailViewModel
    with FieldControllerMixin, _SpellBonusDataLinkedDetailViewModelMixin {  @override
  void _logActivity(ActivityActionType action, int key) {
    final log = ActivityLogEntity(
      module: 'spell_bonus_data',
      actionType: action,
      entityName: key.toString(),
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogService>().recordBestEffort(log);
  }
}