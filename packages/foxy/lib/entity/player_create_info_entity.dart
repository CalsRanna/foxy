import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'player_create_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo')
class PlayerCreateInfoEntity with _PlayerCreateInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFieldMeaning.enumValues(
    '种族',
    values: PlayerCreateInfoConstants.playerRaceOptions,
  )
  @FoxyFullField('race', key: true)
  final int race;

  @FoxyBriefField()
  @FoxyFieldMeaning.enumValues(
    '职业',
    values: PlayerCreateInfoConstants.playerClassOptions,
  )
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
  /// Class label, with the numeric value as a fallback.
  String get classLabel =>
      PlayerCreateInfoConstants.playerClassOptions[class_] ?? class_.toString();

  /// Race label, with the numeric value as a fallback.
  String get raceLabel =>
      PlayerCreateInfoConstants.playerRaceOptions[race] ?? race.toString();
}
