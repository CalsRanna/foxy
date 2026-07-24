import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'zone_intro_music_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_zone_intro_music_table')
class ZoneIntroMusicEntity with _ZoneIntroMusicEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('Name')
  final String name;

  @FoxyBriefField()
  @FoxyFullField('SoundID')
  final int soundId;

  @FoxyFullField('Priority')
  final int priority;

  @FoxyFullField('MinDelayMinutes')
  final int minDelayMinutes;

  const ZoneIntroMusicEntity({
    this.id = 0,
    this.name = '',
    this.soundId = 0,
    this.priority = 0,
    this.minDelayMinutes = 0,
  });

  factory ZoneIntroMusicEntity.fromJson(Map<String, dynamic> json) =>
      _ZoneIntroMusicEntityMixin.fromJson(json);
}
