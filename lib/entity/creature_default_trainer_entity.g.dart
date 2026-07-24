// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_default_trainer_entity.dart';

mixin _CreatureDefaultTrainerEntityMixin {
  int get creatureId;
  int get trainerId;

  static CreatureDefaultTrainerEntity fromJson(Map<String, dynamic> json) {
    return CreatureDefaultTrainerEntity(
      creatureId: (json['CreatureId'] as num?)?.toInt() ?? 0,
      trainerId: (json['TrainerId'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureDefaultTrainerEntity copyWith({int? creatureId, int? trainerId}) {
    return CreatureDefaultTrainerEntity(
      creatureId: creatureId ?? this.creatureId,
      trainerId: trainerId ?? this.trainerId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'CreatureId': creatureId, 'TrainerId': trainerId};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureDefaultTrainerEntity &&
            runtimeType == other.runtimeType &&
            creatureId == other.creatureId &&
            trainerId == other.trainerId;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, creatureId, trainerId]);
  }

  @override
  String toString() {
    return 'CreatureDefaultTrainerEntity('
        'creatureId: $creatureId, '
        'trainerId: $trainerId'
        ')';
  }
}
