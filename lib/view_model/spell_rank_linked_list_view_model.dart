import 'dart:math';

import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/repository/spell_rank_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'spell_rank_linked_list_view_model.g.dart';

@FoxyLinkedListViewModel(
  entity: SpellRankEntity,
  repository: SpellRankRepository,
)
class SpellRankLinkedListViewModel
    with FieldControllerMixin, _SpellRankLinkedListViewModelMixin {}
