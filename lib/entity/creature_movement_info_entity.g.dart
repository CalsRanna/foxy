// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_movement_info_entity.dart';

mixin _CreatureMovementInfoEntityMixin {
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
    final self = this as CreatureMovementInfoEntity;
    return CreatureMovementInfoEntity(
      id: id ?? self.id,
      smoothFacingChaseRate:
          smoothFacingChaseRate ?? self.smoothFacingChaseRate,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureMovementInfoEntity;
    return {'ID': self.id, 'SmoothFacingChaseRate': self.smoothFacingChaseRate};
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureMovementInfoEntity;
    return identical(self, other) ||
        other is CreatureMovementInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.smoothFacingChaseRate == other.smoothFacingChaseRate;
  }

  @override
  int get hashCode {
    final self = this as CreatureMovementInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.smoothFacingChaseRate,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureMovementInfoEntity;
    return 'CreatureMovementInfoEntity('
        'id: ${self.id}, '
        'smoothFacingChaseRate: ${self.smoothFacingChaseRate}'
        ')';
  }
}
