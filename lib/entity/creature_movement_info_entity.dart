/// DBC 生物移动信息，对应 `foxy.dbc_creature_movement_info` 表。
class CreatureMovementInfoEntity {
  final int id;
  final double smoothFacingChaseRate;

  const CreatureMovementInfoEntity({
    this.id = 0,
    this.smoothFacingChaseRate = 0,
  });

  factory CreatureMovementInfoEntity.fromJson(Map<String, dynamic> json) {
    return CreatureMovementInfoEntity(
      id: json['ID'] ?? 0,
      smoothFacingChaseRate:
          (json['SmoothFacingChaseRate'] as num?)?.toDouble() ?? 0,
    );
  }

  CreatureMovementInfoEntity copyWith({
    int? id,
    double? smoothFacingChaseRate,
  }) {
    return CreatureMovementInfoEntity(
      id: id ?? this.id,
      smoothFacingChaseRate:
          smoothFacingChaseRate ?? this.smoothFacingChaseRate,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'SmoothFacingChaseRate': smoothFacingChaseRate};
  }
}
