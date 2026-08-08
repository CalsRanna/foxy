import 'dart:math';

import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_area_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: SpellAreaEntity,
  selects: {'autocast': 0, 'gender': 2},
  flags: {'questEndStatus', 'questStartStatus', 'racemask'},
  repository: SpellAreaRepository,
)
class SpellAreaLinkedListViewModel
    with FieldControllerMixin, _SpellAreaLinkedListViewModelMixin {
}