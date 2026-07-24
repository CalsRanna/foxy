// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'spell_area_entity.dart';

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

  factory SpellAreaKey.fromEntity(SpellAreaEntity entity) {
    return SpellAreaKey(
      spell: entity.spell,
      area: entity.area,
      questStart: entity.questStart,
      auraSpell: entity.auraSpell,
      racemask: entity.racemask,
      gender: entity.gender,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellAreaKey &&
            spell == other.spell &&
            area == other.area &&
            questStart == other.questStart &&
            auraSpell == other.auraSpell &&
            racemask == other.racemask &&
            gender == other.gender;
  }

  @override
  int get hashCode =>
      Object.hashAll([spell, area, questStart, auraSpell, racemask, gender]);

  @override
  String toString() {
    return 'SpellAreaKey('
        'spell: $spell, '
        'area: $area, '
        'questStart: $questStart, '
        'auraSpell: $auraSpell, '
        'racemask: $racemask, '
        'gender: $gender'
        ')';
  }
}
