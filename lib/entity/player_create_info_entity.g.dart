// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_entity.dart';

mixin _PlayerCreateInfoEntityMixin {
  int get race;
  int get class_;
  int get map;
  int get zone;
  double get positionX;
  double get positionY;
  double get positionZ;
  double get orientation;

  static PlayerCreateInfoEntity fromJson(Map<String, dynamic> json) {
    return PlayerCreateInfoEntity(
      race: (json['race'] as num?)?.toInt() ?? 0,
      class_: (json['class'] as num?)?.toInt() ?? 0,
      map: (json['map'] as num?)?.toInt() ?? 0,
      zone: (json['zone'] as num?)?.toInt() ?? 0,
      positionX: (json['position_x'] as num?)?.toDouble() ?? 0.0,
      positionY: (json['position_y'] as num?)?.toDouble() ?? 0.0,
      positionZ: (json['position_z'] as num?)?.toDouble() ?? 0.0,
      orientation: (json['orientation'] as num?)?.toDouble() ?? 0.0,
    );
  }

  PlayerCreateInfoEntity copyWith({
    int? race,
    int? class_,
    int? map,
    int? zone,
    double? positionX,
    double? positionY,
    double? positionZ,
    double? orientation,
  }) {
    return PlayerCreateInfoEntity(
      race: race ?? this.race,
      class_: class_ ?? this.class_,
      map: map ?? this.map,
      zone: zone ?? this.zone,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      positionZ: positionZ ?? this.positionZ,
      orientation: orientation ?? this.orientation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'race': race,
      'class': class_,
      'map': map,
      'zone': zone,
      'position_x': positionX,
      'position_y': positionY,
      'position_z': positionZ,
      'orientation': orientation,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoEntity &&
            runtimeType == other.runtimeType &&
            race == other.race &&
            class_ == other.class_ &&
            map == other.map &&
            zone == other.zone &&
            positionX == other.positionX &&
            positionY == other.positionY &&
            positionZ == other.positionZ &&
            orientation == other.orientation;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      race,
      class_,
      map,
      zone,
      positionX,
      positionY,
      positionZ,
      orientation,
    ]);
  }

  @override
  String toString() {
    return 'PlayerCreateInfoEntity('
        'race: $race, '
        'class_: $class_, '
        'map: $map, '
        'zone: $zone, '
        'positionX: $positionX, '
        'positionY: $positionY, '
        'positionZ: $positionZ, '
        'orientation: $orientation'
        ')';
  }
}
