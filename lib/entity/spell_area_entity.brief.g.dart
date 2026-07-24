// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'spell_area_entity.key.g.dart';

final class BriefSpellAreaEntity {
  final int spell;
  final int area;
  final int questStart;
  final int questEnd;
  final int auraSpell;
  final int racemask;
  final int gender;
  final int questStartStatus;
  final int questEndStatus;

  const BriefSpellAreaEntity({
    this.spell = 0,
    this.area = 0,
    this.questStart = 0,
    this.questEnd = 0,
    this.auraSpell = 0,
    this.racemask = 0,
    this.gender = 2,
    this.questStartStatus = 64,
    this.questEndStatus = 11,
  });

  factory BriefSpellAreaEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellAreaEntity(
      spell: (json['spell'] as num?)?.toInt() ?? 0,
      area: (json['area'] as num?)?.toInt() ?? 0,
      questStart: (json['quest_start'] as num?)?.toInt() ?? 0,
      questEnd: (json['quest_end'] as num?)?.toInt() ?? 0,
      auraSpell: (json['aura_spell'] as num?)?.toInt() ?? 0,
      racemask: (json['racemask'] as num?)?.toInt() ?? 0,
      gender: (json['gender'] as num?)?.toInt() ?? 2,
      questStartStatus: (json['quest_start_status'] as num?)?.toInt() ?? 64,
      questEndStatus: (json['quest_end_status'] as num?)?.toInt() ?? 11,
    );
  }

  SpellAreaKey get key {
    return SpellAreaKey(
      spell: spell,
      area: area,
      questStart: questStart,
      auraSpell: auraSpell,
      racemask: racemask,
      gender: gender,
    );
  }
}
