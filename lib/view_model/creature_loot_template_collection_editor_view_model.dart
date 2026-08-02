import 'dart:math';

import 'package:foxy/entity/creature_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_loot_template_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: CreatureLootTemplateEntity,
  flags: {'lootMode'},
  repository: CreatureLootTemplateRepository,
)
class CreatureLootTemplateCollectionEditorViewModel
    with
        FieldControllerMixin,
        _CreatureLootTemplateCollectionEditorViewModelMixin {}
