import 'dart:math';

import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_area_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: SpellAreaEntity,
  selects: {'autocast': 0, 'gender': 2},
  flags: {'questEndStatus', 'questStartStatus', 'racemask'},
  repository: SpellAreaRepository,
)
class SpellAreaCollectionEditorViewModel
    with FieldControllerMixin, _SpellAreaCollectionEditorViewModelMixin {}
