import 'package:foxy/entity/player_create_info_entity.dart';

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
  ) => PlayerCreateInfoCastSpellKey(
    raceMask: entity.raceMask,
    classMask: entity.classMask,
    spell: entity.spell,
    note: entity.note,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerCreateInfoCastSpellKey &&
          other.raceMask == raceMask &&
          other.classMask == classMask &&
          other.spell == spell &&
          other.note == note;

  @override
  int get hashCode => Object.hash(raceMask, classMask, spell, note);
}
