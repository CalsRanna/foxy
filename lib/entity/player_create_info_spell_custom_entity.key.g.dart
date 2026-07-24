// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'player_create_info_spell_custom_entity.dart';

final class PlayerCreateInfoSpellCustomKey {
  final int raceMask;
  final int classMask;
  final int spell;

  const PlayerCreateInfoSpellCustomKey({
    required this.raceMask,
    required this.classMask,
    required this.spell,
  });

  factory PlayerCreateInfoSpellCustomKey.fromEntity(
    PlayerCreateInfoSpellCustomEntity entity,
  ) {
    return PlayerCreateInfoSpellCustomKey(
      raceMask: entity.raceMask,
      classMask: entity.classMask,
      spell: entity.spell,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PlayerCreateInfoSpellCustomKey &&
            raceMask == other.raceMask &&
            classMask == other.classMask &&
            spell == other.spell;
  }

  @override
  int get hashCode => Object.hashAll([raceMask, classMask, spell]);

  @override
  String toString() {
    return 'PlayerCreateInfoSpellCustomKey('
        'raceMask: $raceMask, '
        'classMask: $classMask, '
        'spell: $spell'
        ')';
  }
}
