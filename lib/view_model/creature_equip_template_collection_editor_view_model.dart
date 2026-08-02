import 'dart:math';

import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_equip_template_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: CreatureEquipTemplateEntity,
  repository: CreatureEquipTemplateRepository,
)
class CreatureEquipTemplateCollectionEditorViewModel
    with
        FieldControllerMixin,
        _CreatureEquipTemplateCollectionEditorViewModelMixin {}
