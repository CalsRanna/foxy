import 'dart:math';

import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'npc_trainer_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: NpcTrainerEntity,
  repository: NpcTrainerRepository,
)
class NpcTrainerCollectionEditorViewModel
    with FieldControllerMixin, _NpcTrainerCollectionEditorViewModelMixin {
  void clearParent() {
    ++_refreshToken;
    parentKey.value = null;
    items.value = const [];
    editingKey.value = null;
    selectedKey.value = null;
    page.value = 1;
    total.value = 0;
    loading.value = false;
    errorMessage.value = null;
    _applyCandidate(const NpcTrainerEntity());
  }
}
