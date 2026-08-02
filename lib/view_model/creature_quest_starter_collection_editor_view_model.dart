import 'dart:math';

import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_quest_starter_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_quest_starter_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: CreatureQuestStarterEntity,
  repository: CreatureQuestStarterRepository,
)
class CreatureQuestStarterCollectionEditorViewModel
    with
        FieldControllerMixin,
        _CreatureQuestStarterCollectionEditorViewModelMixin {}
