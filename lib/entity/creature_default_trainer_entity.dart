import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_default_trainer_entity.g.dart';

/// Creature default trainer mapping — maps to the creature_default_trainer
/// table.

@FoxyFullEntity(table: 'creature_default_trainer')
class CreatureDefaultTrainerEntity with _CreatureDefaultTrainerEntityMixin {
  @FoxyFullField('CreatureId', key: true)
  final int creatureId;

  @FoxyFullField('TrainerId')
  final int trainerId;

  const CreatureDefaultTrainerEntity({this.creatureId = 0, this.trainerId = 0});

  factory CreatureDefaultTrainerEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureDefaultTrainerEntityMixin.fromJson(json);
}
