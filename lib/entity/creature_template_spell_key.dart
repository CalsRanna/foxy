import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_template_spell_entity.dart';

@immutable
final class CreatureTemplateSpellKey {
  final int creatureID;
  final int index;

  const CreatureTemplateSpellKey({
    required this.creatureID,
    required this.index,
  });

  factory CreatureTemplateSpellKey.fromEntity(
    CreatureTemplateSpellEntity value,
  ) {
    return CreatureTemplateSpellKey(
      creatureID: value.creatureID,
      index: value.index,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateSpellKey &&
            creatureID == other.creatureID &&
            index == other.index;
  }

  @override
  int get hashCode => Object.hash(creatureID, index);
}
