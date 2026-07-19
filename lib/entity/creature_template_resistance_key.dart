import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_template_resistance_entity.dart';

@immutable
final class CreatureTemplateResistanceKey {
  final int creatureID;
  final int school;

  const CreatureTemplateResistanceKey({
    required this.creatureID,
    required this.school,
  });

  factory CreatureTemplateResistanceKey.fromEntity(
    CreatureTemplateResistanceEntity value,
  ) {
    return CreatureTemplateResistanceKey(
      creatureID: value.creatureID,
      school: value.school,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateResistanceKey &&
            creatureID == other.creatureID &&
            school == other.school;
  }

  @override
  int get hashCode => Object.hash(creatureID, school);
}
