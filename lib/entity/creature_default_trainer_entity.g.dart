// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_default_trainer_entity.dart';

mixin _CreatureDefaultTrainerEntityMixin {
  static CreatureDefaultTrainerEntity fromJson(Map<String, dynamic> json) {
    return CreatureDefaultTrainerEntity(
      creatureId: (json['CreatureId'] as num?)?.toInt() ?? 0,
      trainerId: (json['TrainerId'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureDefaultTrainerEntity copyWith({int? creatureId, int? trainerId}) {
    final self = this as CreatureDefaultTrainerEntity;
    return CreatureDefaultTrainerEntity(
      creatureId: creatureId ?? self.creatureId,
      trainerId: trainerId ?? self.trainerId,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureDefaultTrainerEntity;
    return {'CreatureId': self.creatureId, 'TrainerId': self.trainerId};
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureDefaultTrainerEntity;
    return identical(self, other) ||
        other is CreatureDefaultTrainerEntity &&
            self.runtimeType == other.runtimeType &&
            self.creatureId == other.creatureId &&
            self.trainerId == other.trainerId;
  }

  @override
  int get hashCode {
    final self = this as CreatureDefaultTrainerEntity;
    return Object.hashAll([self.runtimeType, self.creatureId, self.trainerId]);
  }

  @override
  String toString() {
    final self = this as CreatureDefaultTrainerEntity;
    return 'CreatureDefaultTrainerEntity('
        'creatureId: ${self.creatureId}, '
        'trainerId: ${self.trainerId}'
        ')';
  }
}
