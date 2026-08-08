import 'dart:math';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/entity/prospecting_loot_template_entity.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/prospecting_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'prospecting_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: ProspectingLootTemplateEntity,
  flags: {'lootMode'},
  repository: ProspectingLootTemplateRepository,
)
class ProspectingLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _ProspectingLootTemplateLinkedListViewModelMixin {
}
