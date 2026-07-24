// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'creature_equip_template_entity.dart';

final class CreatureEquipTemplateKey {
  final int creatureID;
  final int id;

  const CreatureEquipTemplateKey({required this.creatureID, required this.id});

  factory CreatureEquipTemplateKey.fromEntity(
    CreatureEquipTemplateEntity entity,
  ) {
    return CreatureEquipTemplateKey(
      creatureID: entity.creatureID,
      id: entity.id,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureEquipTemplateKey &&
            creatureID == other.creatureID &&
            id == other.id;
  }

  @override
  int get hashCode => Object.hashAll([creatureID, id]);

  @override
  String toString() {
    return 'CreatureEquipTemplateKey('
        'creatureID: $creatureID, '
        'id: $id'
        ')';
  }
}
