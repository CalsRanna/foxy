import 'dart:math';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/skill_line_ability_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy_annotation/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/skill_line_ability_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'skill_line_ability_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(selects: {'acquireMethod'})
class SkillLineAbilityLinkedListViewModel
    with FieldControllerMixin, _SkillLineAbilityLinkedListViewModelMixin {}
