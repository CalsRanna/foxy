import 'dart:math';

import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_quest_ender_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_quest_ender_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: CreatureQuestEnderEntity,
  repository: CreatureQuestEnderRepository,
)
class CreatureQuestEnderLinkedListViewModel
    with
        FieldControllerMixin,
        _CreatureQuestEnderLinkedListViewModelMixin {}
