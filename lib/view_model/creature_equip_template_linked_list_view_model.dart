import 'dart:math';

import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_equip_template_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: CreatureEquipTemplateEntity,
  repository: CreatureEquipTemplateRepository,
)
class CreatureEquipTemplateLinkedListViewModel
    with
        FieldControllerMixin,
        _CreatureEquipTemplateLinkedListViewModelMixin {}
