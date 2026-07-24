// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_cast_spell_entity.key.g.dart';

final class BriefPlayerCreateInfoCastSpellEntity {
  final int raceMask;
  final int classMask;
  final int spell;
  final String? note;

  const BriefPlayerCreateInfoCastSpellEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note,
  });

  factory BriefPlayerCreateInfoCastSpellEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefPlayerCreateInfoCastSpellEntity(
      raceMask: (json['raceMask'] as num?)?.toInt() ?? 0,
      classMask: (json['classMask'] as num?)?.toInt() ?? 0,
      spell: (json['spell'] as num?)?.toInt() ?? 0,
      note: json['note']?.toString(),
    );
  }

  PlayerCreateInfoCastSpellKey get key {
    return PlayerCreateInfoCastSpellKey(
      raceMask: raceMask,
      classMask: classMask,
      spell: spell,
      note: note,
    );
  }
}
