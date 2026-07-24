// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'player_create_info_cast_spell_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'playercreateinfo_cast_spell')
class PlayerCreateInfoCastSpellEntity
    with _PlayerCreateInfoCastSpellEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('raceMask', key: true)
  final int raceMask;

  @FoxyBriefField()
  @FoxyFullField('classMask', key: true)
  final int classMask;

  @FoxyBriefField()
  @FoxyFullField('spell', key: true)
  final int spell;

  @FoxyBriefField()
  @FoxyFullField('note', key: true)
  final String? note;

  const PlayerCreateInfoCastSpellEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note,
  });

  factory PlayerCreateInfoCastSpellEntity.fromJson(Map<String, dynamic> json) =>
      _PlayerCreateInfoCastSpellEntityMixin.fromJson(json);
}
