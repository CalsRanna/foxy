import 'package:foxy/entity/creature_movement_info_entity.dart';

class CreatureMovementInfoKey {
  final int id;

  const CreatureMovementInfoKey({required this.id});

  factory CreatureMovementInfoKey.fromEntity(
    CreatureMovementInfoEntity entity,
  ) => CreatureMovementInfoKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatureMovementInfoKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
