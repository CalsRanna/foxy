import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'sound_ambience_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_sound_ambience')
class SoundAmbienceEntity with _SoundAmbienceEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('AmbienceID0')
  final int ambienceId0;

  @FoxyBriefField()
  @FoxyFullField('AmbienceID1')
  final int ambienceId1;

  const SoundAmbienceEntity({
    this.id = 0,
    this.ambienceId0 = 0,
    this.ambienceId1 = 0,
  });

  factory SoundAmbienceEntity.fromJson(Map<String, dynamic> json) =>
      _SoundAmbienceEntityMixin.fromJson(json);
}
