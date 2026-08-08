import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy_annotation/entity_annotations.dart';

part 'player_create_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo')
class PlayerCreateInfoEntity with _PlayerCreateInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('race', key: true)
  final int race;

  @FoxyBriefField()
  @FoxyFullField('class', key: true)
  final int class_;

  @FoxyBriefField()
  @FoxyFullField('map')
  final int map;

  @FoxyBriefField()
  @FoxyFullField('zone')
  final int zone;

  @FoxyBriefField()
  @FoxyFullField('position_x')
  final double positionX;

  @FoxyBriefField()
  @FoxyFullField('position_y')
  final double positionY;

  @FoxyBriefField()
  @FoxyFullField('position_z')
  final double positionZ;

  @FoxyBriefField()
  @FoxyFullField('orientation')
  final double orientation;

  const PlayerCreateInfoEntity({
    this.race = 0,
    this.class_ = 0,
    this.map = 0,
    this.zone = 0,
    this.positionX = 0,
    this.positionY = 0,
    this.positionZ = 0,
    this.orientation = 0,
  });

  factory PlayerCreateInfoEntity.fromJson(Map<String, dynamic> json) =>
      _PlayerCreateInfoEntityMixin.fromJson(json);
}

extension BriefPlayerCreateInfoEntityLabel on BriefPlayerCreateInfoEntity {
  /// 种族标签（人类/兽人/…），未知值回退为原始数字。
  String get raceLabel => kPlayerRaceOptions[race] ?? race.toString();

  /// 职业标签（战士/圣骑士/…），未知值回退为原始数字。
  String get classLabel => kPlayerClassOptions[class_] ?? class_.toString();
}
