import 'dart:math';

import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'npc_vendor_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: NpcVendorEntity,
  repository: NpcVendorRepository,
)
class NpcVendorLinkedListViewModel
    with FieldControllerMixin, _NpcVendorLinkedListViewModelMixin {}
