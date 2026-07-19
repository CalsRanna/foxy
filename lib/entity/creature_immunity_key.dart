import 'package:foxy/entity/creature_immunity_entity.dart';

class CreatureImmunityKey {
  final int id;

  const CreatureImmunityKey({required this.id});

  factory CreatureImmunityKey.fromEntity(CreatureImmunityEntity entity) =>
      CreatureImmunityKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CreatureImmunityKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
