// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_cast_spell_entity.dart';

final class PlayerCreateInfoCastSpellKey {
  final int raceMask;
  final int classMask;
  final int spell;
  final String? note;

  const PlayerCreateInfoCastSpellKey({
    required this.raceMask,
    required this.classMask,
    required this.spell,
    required this.note,
  });

  factory PlayerCreateInfoCastSpellKey.fromEntity(
    PlayerCreateInfoCastSpellEntity entity,
  ) {
    return PlayerCreateInfoCastSpellKey(
      raceMask: entity.raceMask,
      classMask: entity.classMask,
      spell: entity.spell,
      note: entity.note,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoCastSpellKey &&
            raceMask == other.raceMask &&
            classMask == other.classMask &&
            spell == other.spell &&
            note == other.note;
  }

  @override
  int get hashCode => Object.hashAll([raceMask, classMask, spell, note]);

  @override
  String toString() {
    return 'PlayerCreateInfoCastSpellKey('
        'raceMask: $raceMask, '
        'classMask: $classMask, '
        'spell: $spell, '
        'note: $note'
        ')';
  }
}
