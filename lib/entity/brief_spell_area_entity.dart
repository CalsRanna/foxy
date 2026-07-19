import 'package:foxy/entity/spell_area_key.dart';

class BriefSpellAreaEntity {
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

  factory BriefSpellAreaEntity.fromJson(Map<String, dynamic> json) =>
      BriefSpellAreaEntity(
        spell: json['spell'] ?? 0,
        area: json['area'] ?? 0,
        questStart: json['quest_start'] ?? 0,
        questEnd: json['quest_end'] ?? 0,
        auraSpell: json['aura_spell'] ?? 0,
        racemask: json['racemask'] ?? 0,
        gender: json['gender'] ?? 2,
        questStartStatus: json['quest_start_status'] ?? 64,
        questEndStatus: json['quest_end_status'] ?? 11,
      );

  SpellAreaKey get key => SpellAreaKey(
    spell: spell,
    area: area,
    questStart: questStart,
    auraSpell: auraSpell,
    racemask: racemask,
    gender: gender,
  );
}
