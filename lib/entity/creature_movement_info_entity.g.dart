// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_movement_info_entity.dart';

mixin _CreatureMovementInfoEntityMixin {
  int get id;
  double get smoothFacingChaseRate;

  static CreatureMovementInfoEntity fromJson(Map<String, dynamic> json) {
    return CreatureMovementInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      smoothFacingChaseRate:
          (json['SmoothFacingChaseRate'] as num?)?.toDouble() ?? 0.0,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureMovementInfoEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            smoothFacingChaseRate == other.smoothFacingChaseRate;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, smoothFacingChaseRate]);
  }

  @override
  String toString() {
    return 'CreatureMovementInfoEntity('
        'id: $id, '
        'smoothFacingChaseRate: $smoothFacingChaseRate'
        ')';
  }
}
