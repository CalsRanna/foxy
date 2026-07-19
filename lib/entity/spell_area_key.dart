import 'package:foxy/entity/spell_area_entity.dart';

final class SpellAreaKey {
  final int spell;
  final int area;
  final int questStart;
  final int auraSpell;
  final int racemask;
  final int gender;

  const SpellAreaKey({
    required this.spell,
    required this.area,
    required this.questStart,
    required this.auraSpell,
    required this.racemask,
    required this.gender,
  });

  factory SpellAreaKey.fromEntity(SpellAreaEntity entity) => SpellAreaKey(
    spell: entity.spell,
    area: entity.area,
    questStart: entity.questStart,
    auraSpell: entity.auraSpell,
    racemask: entity.racemask,
    gender: entity.gender,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellAreaKey &&
          other.spell == spell &&
          other.area == area &&
          other.questStart == questStart &&
          other.auraSpell == auraSpell &&
          other.racemask == racemask &&
          other.gender == gender;

  @override
  int get hashCode =>
      Object.hash(spell, area, questStart, auraSpell, racemask, gender);
}
