import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'player_create_info_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'playercreateinfo')
class PlayerCreateInfoEntity with _PlayerCreateInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('race', key: true)
  final int race;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
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
