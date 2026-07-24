// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_entity.key.g.dart';

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
