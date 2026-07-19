import 'package:foxy/entity/player_create_info_key.dart';

class BriefPlayerCreateInfoEntity {
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
    this.positionX = 0,
    this.positionY = 0,
    this.positionZ = 0,
    this.orientation = 0,
  });

  factory BriefPlayerCreateInfoEntity.fromJson(Map<String, dynamic> json) =>
      BriefPlayerCreateInfoEntity(
        race: json['race'] ?? 0,
        class_: json['class'] ?? 0,
        map: json['map'] ?? 0,
        zone: json['zone'] ?? 0,
        positionX: (json['position_x'] as num?)?.toDouble() ?? 0,
        positionY: (json['position_y'] as num?)?.toDouble() ?? 0,
        positionZ: (json['position_z'] as num?)?.toDouble() ?? 0,
        orientation: (json['orientation'] as num?)?.toDouble() ?? 0,
      );

  PlayerCreateInfoKey get key =>
      PlayerCreateInfoKey(race: race, class_: class_);
}
