// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_of_interest_entity.dart';

mixin _PointOfInterestEntityMixin {
  int get id;
  double get positionX;
  double get positionY;
  int get icon;
  int get flags;
  int get importance;
  String get name;

  static PointOfInterestEntity fromJson(Map<String, dynamic> json) {
    return PointOfInterestEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      positionX: (json['PositionX'] as num?)?.toDouble() ?? 0.0,
      positionY: (json['PositionY'] as num?)?.toDouble() ?? 0.0,
      icon: (json['Icon'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      importance: (json['Importance'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
    );
  }

  PointOfInterestEntity copyWith({
    int? id,
    double? positionX,
    double? positionY,
    int? icon,
    int? flags,
    int? importance,
    String? name,
  }) {
    return PointOfInterestEntity(
      id: id ?? this.id,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      icon: icon ?? this.icon,
      flags: flags ?? this.flags,
      importance: importance ?? this.importance,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'PositionX': positionX,
      'PositionY': positionY,
      'Icon': icon,
      'Flags': flags,
      'Importance': importance,
      'Name': name,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PointOfInterestEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            positionX == other.positionX &&
            positionY == other.positionY &&
            icon == other.icon &&
            flags == other.flags &&
            importance == other.importance &&
            name == other.name;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      positionX,
      positionY,
      icon,
      flags,
      importance,
      name,
    ]);
  }

  @override
  String toString() {
    return 'PointOfInterestEntity('
        'id: $id, '
        'positionX: $positionX, '
        'positionY: $positionY, '
        'icon: $icon, '
        'flags: $flags, '
        'importance: $importance, '
        'name: $name'
        ')';
  }
}
