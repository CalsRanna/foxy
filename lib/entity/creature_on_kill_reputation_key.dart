import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';

@immutable
final class CreatureOnKillReputationKey {
  final int creatureID;

  const CreatureOnKillReputationKey({required this.creatureID});

  factory CreatureOnKillReputationKey.fromEntity(
    CreatureOnKillReputationEntity value,
  ) {
    return CreatureOnKillReputationKey(creatureID: value.creatureID);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureOnKillReputationKey && creatureID == other.creatureID;
  }

  @override
  int get hashCode => creatureID.hashCode;
}
