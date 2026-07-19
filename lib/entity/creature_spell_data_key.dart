import 'package:foxy/entity/creature_spell_data_entity.dart';

class CreatureSpellDataKey {
  final int id;

  const CreatureSpellDataKey({required this.id});

  factory CreatureSpellDataKey.fromEntity(CreatureSpellDataEntity entity) =>
      CreatureSpellDataKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CreatureSpellDataKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
