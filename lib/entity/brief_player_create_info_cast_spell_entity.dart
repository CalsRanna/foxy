import 'package:foxy/entity/player_create_info_cast_spell_key.dart';

class BriefPlayerCreateInfoCastSpellEntity {
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
  ) => BriefPlayerCreateInfoCastSpellEntity(
    raceMask: json['raceMask'] ?? 0,
    classMask: json['classMask'] ?? 0,
    spell: json['spell'] ?? 0,
    note: json['note'] as String?,
  );

  PlayerCreateInfoCastSpellKey get key => PlayerCreateInfoCastSpellKey(
    raceMask: raceMask,
    classMask: classMask,
    spell: spell,
    note: note,
  );
}
