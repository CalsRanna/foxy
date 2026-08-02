import 'dart:math';

import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/spell_linked_spell_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_linked_spell_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: SpellLinkedSpellEntity,
  selects: {'type': 0},
  repository: SpellLinkedSpellRepository,
)
class SpellLinkedSpellCollectionEditorViewModel
    with
        FieldControllerMixin,
        _SpellLinkedSpellCollectionEditorViewModelMixin {}
