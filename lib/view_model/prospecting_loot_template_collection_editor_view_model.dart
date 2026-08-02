import 'dart:math';

import 'package:foxy/entity/prospecting_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/prospecting_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'prospecting_loot_template_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: ProspectingLootTemplateEntity,
  flags: {'lootMode'},
  repository: ProspectingLootTemplateRepository,
)
class ProspectingLootTemplateCollectionEditorViewModel
    with
        FieldControllerMixin,
        _ProspectingLootTemplateCollectionEditorViewModelMixin {}
