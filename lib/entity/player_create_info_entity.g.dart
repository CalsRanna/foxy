// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_entity.dart';

mixin _PlayerCreateInfoEntityMixin {
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
    final self = this as PlayerCreateInfoEntity;
    return PlayerCreateInfoEntity(
      race: race ?? self.race,
      class_: class_ ?? self.class_,
      map: map ?? self.map,
      zone: zone ?? self.zone,
      positionX: positionX ?? self.positionX,
      positionY: positionY ?? self.positionY,
      positionZ: positionZ ?? self.positionZ,
      orientation: orientation ?? self.orientation,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as PlayerCreateInfoEntity;
    return {
      'race': self.race,
      'class': self.class_,
      'map': self.map,
      'zone': self.zone,
      'position_x': self.positionX,
      'position_y': self.positionY,
      'position_z': self.positionZ,
      'orientation': self.orientation,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as PlayerCreateInfoEntity;
    return identical(self, other) ||
        other is PlayerCreateInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.race == other.race &&
            self.class_ == other.class_ &&
            self.map == other.map &&
            self.zone == other.zone &&
            self.positionX == other.positionX &&
            self.positionY == other.positionY &&
            self.positionZ == other.positionZ &&
            self.orientation == other.orientation;
  }

  @override
  int get hashCode {
    final self = this as PlayerCreateInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.race,
      self.class_,
      self.map,
      self.zone,
      self.positionX,
      self.positionY,
      self.positionZ,
      self.orientation,
    ]);
  }

  @override
  String toString() {
    final self = this as PlayerCreateInfoEntity;
    return 'PlayerCreateInfoEntity('
        'race: ${self.race}, '
        'class_: ${self.class_}, '
        'map: ${self.map}, '
        'zone: ${self.zone}, '
        'positionX: ${self.positionX}, '
        'positionY: ${self.positionY}, '
        'positionZ: ${self.positionZ}, '
        'orientation: ${self.orientation}'
        ')';
  }
}

final class PlayerCreateInfoKey {
  final int race;
  final int class_;

  const PlayerCreateInfoKey({required this.race, required this.class_});

  factory PlayerCreateInfoKey.fromEntity(PlayerCreateInfoEntity entity) {
    return PlayerCreateInfoKey(race: entity.race, class_: entity.class_);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoKey &&
            race == other.race &&
            class_ == other.class_;
  }

  @override
  int get hashCode => Object.hashAll([race, class_]);

  @override
  String toString() {
    return 'PlayerCreateInfoKey('
        'race: $race, '
        'class_: $class_'
        ')';
  }
}

final class BriefPlayerCreateInfoEntity {
  final int race;
  final int class_;
  final int map;
  final int zone;
  final double positionX;
  final double positionY;
  final double positionZ;
  final double orientation;

  const BriefPlayerCreateInfoEntity({
    this.race = 0,
    this.class_ = 0,
    this.map = 0,
    this.zone = 0,
    this.positionX = 0.0,
    this.positionY = 0.0,
    this.positionZ = 0.0,
    this.orientation = 0.0,
  });

  factory BriefPlayerCreateInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefPlayerCreateInfoEntity(
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

  PlayerCreateInfoKey get key {
    return PlayerCreateInfoKey(race: race, class_: class_);
  }
}
