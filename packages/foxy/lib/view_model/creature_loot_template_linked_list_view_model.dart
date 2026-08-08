import 'dart:math';

import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/repository/creature_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: CreatureLootTemplateEntity,
  flags: {'lootMode'},
  repository: CreatureLootTemplateRepository,
)
class CreatureLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _CreatureLootTemplateLinkedListViewModelMixin {
}