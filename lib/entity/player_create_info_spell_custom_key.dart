import 'package:foxy/entity/player_create_info_entity.dart';

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
  ) => PlayerCreateInfoSpellCustomKey(
    raceMask: entity.racemask,
    classMask: entity.classmask,
    spell: entity.spell,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerCreateInfoSpellCustomKey &&
          other.raceMask == raceMask &&
          other.classMask == classMask &&
          other.spell == spell;

  @override
  int get hashCode => Object.hash(raceMask, classMask, spell);
}
