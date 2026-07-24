import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'zone_music_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_zone_music')
class ZoneMusicEntity with _ZoneMusicEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('SetName')
  final String setName;

  @FoxyFullField('SilenceIntervalMin0')
  final int silenceIntervalMin0;

  @FoxyFullField('SilenceIntervalMin1')
  final int silenceIntervalMin1;

  @FoxyFullField('SilenceIntervalMax0')
  final int silenceIntervalMax0;

  @FoxyFullField('SilenceIntervalMax1')
  final int silenceIntervalMax1;

  @FoxyBriefField()
  @FoxyFullField('Sounds0')
  final int sounds0;

  @FoxyBriefField()
  @FoxyFullField('Sounds1')
  final int sounds1;

  const ZoneMusicEntity({
    this.id = 0,
    this.setName = '',
    this.silenceIntervalMin0 = 0,
    this.silenceIntervalMin1 = 0,
    this.silenceIntervalMax0 = 0,
    this.silenceIntervalMax1 = 0,
    this.sounds0 = 0,
    this.sounds1 = 0,
  });

  factory ZoneMusicEntity.fromJson(Map<String, dynamic> json) =>
      _ZoneMusicEntityMixin.fromJson(json);
}
