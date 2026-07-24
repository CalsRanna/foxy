// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'npc_trainer_entity.dart';

final class NpcTrainerKey {
  final int trainerId;
  final int spellId;

  const NpcTrainerKey({required this.trainerId, required this.spellId});

  factory NpcTrainerKey.fromEntity(NpcTrainerEntity entity) {
    return NpcTrainerKey(trainerId: entity.trainerId, spellId: entity.spellId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcTrainerKey &&
            trainerId == other.trainerId &&
            spellId == other.spellId;
  }

  @override
  int get hashCode => Object.hashAll([trainerId, spellId]);

  @override
  String toString() {
    return 'NpcTrainerKey('
        'trainerId: $trainerId, '
        'spellId: $spellId'
        ')';
  }
}
