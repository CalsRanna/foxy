import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_duration_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_spell_duration')
class SpellDurationEntity with _SpellDurationEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Duration')
  final int duration;

  @FoxyBriefField()
  @FoxyFullField('DurationPerLevel')
  final int durationPerLevel;

  @FoxyBriefField()
  @FoxyFullField('MaxDuration')
  final int maxDuration;

  const SpellDurationEntity({
    this.id = 0,
    this.duration = 0,
    this.durationPerLevel = 0,
    this.maxDuration = 0,
  });

  factory SpellDurationEntity.fromJson(Map<String, dynamic> json) =>
      _SpellDurationEntityMixin.fromJson(json);
}
