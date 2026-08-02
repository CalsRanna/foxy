import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/infrastructure/codegen/form_annotations.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

part 'creature_on_kill_reputation_linked_detail_view_model.g.dart';

@FoxyLinkedDetailViewModel(
  entity: CreatureOnKillReputationEntity,
  repository: CreatureOnKillReputationRepository,
  selects: {'maxStanding1': 0, 'maxStanding2': 0, 'teamDependent': 0},
)
class CreatureOnKillReputationLinkedDetailViewModel
    with FieldControllerMixin, _CreatureOnKillReputationLinkedDetailViewModelMixin {}
