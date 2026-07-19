import 'package:foxy/entity/player_create_info_spell_custom_key.dart';

class BriefPlayerCreateInfoSpellCustomEntity {
  final int raceMask;
  final int classMask;
  final int spell;
  final String note;

  const BriefPlayerCreateInfoSpellCustomEntity({
    this.raceMask = 0,
    this.classMask = 0,
    this.spell = 0,
    this.note = '',
  });

  factory BriefPlayerCreateInfoSpellCustomEntity.fromJson(
    Map<String, dynamic> json,
  ) => BriefPlayerCreateInfoSpellCustomEntity(
    raceMask: json['racemask'] ?? 0,
    classMask: json['classmask'] ?? 0,
    spell: json['Spell'] ?? 0,
    note: json['Note'] ?? '',
  );

  PlayerCreateInfoSpellCustomKey get key => PlayerCreateInfoSpellCustomKey(
    raceMask: raceMask,
    classMask: classMask,
    spell: spell,
  );
}
