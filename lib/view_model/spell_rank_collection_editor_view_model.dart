import 'dart:math';

import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/spell_rank_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_rank_collection_editor_view_model.g.dart';

@FoxyCollectionEditorViewModel(
  entity: SpellRankEntity,
  repository: SpellRankRepository,
)
class SpellRankCollectionEditorViewModel
    with FieldControllerMixin, _SpellRankCollectionEditorViewModelMixin {}
