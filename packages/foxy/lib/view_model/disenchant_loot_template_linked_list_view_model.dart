import 'dart:math';

import 'package:foxy/entity/disenchant_loot_template_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/disenchant_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'disenchant_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: DisenchantLootTemplateEntity,
  flags: {'lootMode'},
  repository: DisenchantLootTemplateRepository,
)
class DisenchantLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _DisenchantLootTemplateLinkedListViewModelMixin {
}