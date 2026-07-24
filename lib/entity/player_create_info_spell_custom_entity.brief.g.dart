// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_spell_custom_entity.key.g.dart';

final class BriefPlayerCreateInfoSpellCustomEntity {
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
  ) {
    return BriefPlayerCreateInfoSpellCustomEntity(
      raceMask: (json['racemask'] as num?)?.toInt() ?? 0,
      classMask: (json['classmask'] as num?)?.toInt() ?? 0,
      spell: (json['Spell'] as num?)?.toInt() ?? 0,
      note: json['Note']?.toString() ?? '',
    );
  }

  PlayerCreateInfoSpellCustomKey get key {
    return PlayerCreateInfoSpellCustomKey(
      raceMask: raceMask,
      classMask: classMask,
      spell: spell,
    );
  }
}
