// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefCreatureMovementInfoEntity {
  final int id;
  final double smoothFacingChaseRate;

  const BriefCreatureMovementInfoEntity({
    this.id = 0,
    this.smoothFacingChaseRate = 0.0,
  });

  factory BriefCreatureMovementInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureMovementInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      smoothFacingChaseRate:
          (json['SmoothFacingChaseRate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  int get key => id;
}
