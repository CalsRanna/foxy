import 'dart:math';

import 'package:foxy/entity/item_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/item_loot_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'item_loot_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: ItemLootTemplateEntity,
  flags: {'lootMode'},
  repository: ItemLootTemplateRepository,
)
class ItemLootTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _ItemLootTemplateLinkedListViewModelMixin {}
