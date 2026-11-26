import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'player_create_info_cast_spell_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('spellName')
@FoxyBriefField.text('textureFilename')
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

extension BriefPlayerCreateInfoCastSpellEntityLabel
    on BriefPlayerCreateInfoCastSpellEntity {
  /// Matching class labels, with the raw mask as a fallback.
  String get classMaskLabel => FlagItem.maskLabel(
    classMask,
    PlayerCreateInfoConstants.playerCreateClassMaskFlags,
  );

  /// Matching race labels, with the raw mask as a fallback.
  String get raceMaskLabel => FlagItem.maskLabel(
    raceMask,
    PlayerCreateInfoConstants.playerCreateRaceMaskFlags,
  );
}
