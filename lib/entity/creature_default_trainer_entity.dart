/// 生物默认训练师映射 — 对应 creature_default_trainer 表。
class CreatureDefaultTrainerEntity {
  final int creatureId;
  final int trainerId;

  const CreatureDefaultTrainerEntity({this.creatureId = 0, this.trainerId = 0});

  factory CreatureDefaultTrainerEntity.fromJson(Map<String, dynamic> json) {
    return CreatureDefaultTrainerEntity(
      creatureId: json['CreatureId'] ?? 0,
      trainerId: json['TrainerId'] ?? 0,
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
}
