import 'dart:math';

import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/game_object_quest_item_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'game_object_quest_item_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: GameObjectQuestItemEntity,
  repository: GameObjectQuestItemRepository,
)
class GameObjectQuestItemCollectionEditorViewModel
    with
        FieldControllerMixin,
        _GameObjectQuestItemCollectionEditorViewModelMixin {}
