import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_default_trainer_entity.dart';

@immutable
final class CreatureDefaultTrainerKey {
  final int creatureId;

  const CreatureDefaultTrainerKey({required this.creatureId});

  factory CreatureDefaultTrainerKey.fromEntity(
    CreatureDefaultTrainerEntity value,
  ) {
    return CreatureDefaultTrainerKey(creatureId: value.creatureId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureDefaultTrainerKey && creatureId == other.creatureId;
  }

  @override
  int get hashCode => creatureId.hashCode;
}
