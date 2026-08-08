import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_bonus_data_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: SpellBonusDataEntity,
  repository: SpellBonusDataRepository,
)
class SpellBonusDataLinkedDetailViewModel
    with FieldControllerMixin, _SpellBonusDataLinkedDetailViewModelMixin {
}