import 'package:flutter/foundation.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';

@immutable
final class CreatureEquipTemplateKey {
  final int creatureID;
  final int id;

  const CreatureEquipTemplateKey({required this.creatureID, required this.id});

  factory CreatureEquipTemplateKey.fromEntity(
    CreatureEquipTemplateEntity value,
  ) {
    return CreatureEquipTemplateKey(creatureID: value.creatureID, id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureEquipTemplateKey &&
            creatureID == other.creatureID &&
            id == other.id;
  }

  @override
  int get hashCode => Object.hash(creatureID, id);
}
