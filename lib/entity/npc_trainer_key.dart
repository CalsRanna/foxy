import 'package:flutter/foundation.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';

@immutable
final class NpcTrainerKey {
  final int trainerId;
  final int spellId;

  const NpcTrainerKey({required this.trainerId, required this.spellId});

  factory NpcTrainerKey.fromEntity(NpcTrainerEntity value) {
    return NpcTrainerKey(trainerId: value.trainerId, spellId: value.spellId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcTrainerKey &&
            trainerId == other.trainerId &&
            spellId == other.spellId;
  }

  @override
  int get hashCode => Object.hash(trainerId, spellId);
}
