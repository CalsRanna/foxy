import 'dart:math';

import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_quest_item_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: CreatureQuestItemEntity,
  repository: CreatureQuestItemRepository,
)
class CreatureQuestItemLinkedListViewModel
    with
        FieldControllerMixin,
        _CreatureQuestItemLinkedListViewModelMixin {
}