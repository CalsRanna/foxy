import 'dart:math';

import 'package:foxy/entity/creature_quest_item_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_quest_item_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_quest_item_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: CreatureQuestItemEntity,
  repository: CreatureQuestItemRepository,
)
class CreatureQuestItemCollectionEditorViewModel
    with
        FieldControllerMixin,
        _CreatureQuestItemCollectionEditorViewModelMixin {}
