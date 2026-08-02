import 'dart:math';

import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_quest_starter_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_quest_starter_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: CreatureQuestStarterEntity,
  repository: CreatureQuestStarterRepository,
)
class CreatureQuestStarterLinkedListViewModel
    with
        FieldControllerMixin,
        _CreatureQuestStarterLinkedListViewModelMixin {}
