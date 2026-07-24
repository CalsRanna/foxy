import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'player_create_info_spell_custom_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo_spell_custom')
class PlayerCreateInfoSpellCustomEntity
    with _PlayerCreateInfoSpellCustomEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('racemask', key: true)
  final int raceMask;

  @FoxyBriefField()
  @FoxyFullField('classmask', key: true)
  final int classMask;

  @FoxyBriefField()
  @FoxyFullField('Spell', key: true)
  final int spell;

  @FoxyBriefField()
  @FoxyFullField('Note')
  final String note;

  const PlayerCreateInfoSpellCustomEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note = '',
  });

  factory PlayerCreateInfoSpellCustomEntity.fromJson(
    Map<String, dynamic> json,
  ) => _PlayerCreateInfoSpellCustomEntityMixin.fromJson(json);
}
