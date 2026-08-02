import 'dart:math';

import 'package:foxy/entity/creature_template_spell_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_template_spell_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_template_spell_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: CreatureTemplateSpellEntity,
  repository: CreatureTemplateSpellRepository,
)
class CreatureTemplateSpellCollectionEditorViewModel
    with
        FieldControllerMixin,
        _CreatureTemplateSpellCollectionEditorViewModelMixin {}
