import 'dart:math';

import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/spell_group_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_group_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: SpellGroupEntity,
  repository: SpellGroupRepository,
)
class SpellGroupCollectionEditorViewModel
    with FieldControllerMixin, _SpellGroupCollectionEditorViewModelMixin {}
