import 'dart:math';

import 'package:foxy/entity/milling_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/milling_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'milling_loot_template_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: MillingLootTemplateEntity,
  flags: {'lootMode'},
  repository: MillingLootTemplateRepository,
)
class MillingLootTemplateCollectionEditorViewModel
    with
        FieldControllerMixin,
        _MillingLootTemplateCollectionEditorViewModelMixin {}
