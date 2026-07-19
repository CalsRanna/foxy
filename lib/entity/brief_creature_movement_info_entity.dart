import 'package:foxy/entity/creature_movement_info_key.dart';

class BriefCreatureMovementInfoEntity {
  final int id;
  final double smoothFacingChaseRate;

  const BriefCreatureMovementInfoEntity({
    this.id = 0,
    this.smoothFacingChaseRate = 0,
  });

  factory BriefCreatureMovementInfoEntity.fromJson(Map<String, dynamic> json) =>
      BriefCreatureMovementInfoEntity(
        id: json['ID'] ?? 0,
        smoothFacingChaseRate:
            (json['SmoothFacingChaseRate'] as num?)?.toDouble() ?? 0,
      );

  CreatureMovementInfoKey get key => CreatureMovementInfoKey(id: id);
}
