import 'package:foxy/entity/creature_model_info_entity.dart';

class CreatureModelInfoKey {
  final int displayId;

  const CreatureModelInfoKey({required this.displayId});

  factory CreatureModelInfoKey.fromEntity(CreatureModelInfoEntity entity) =>
      CreatureModelInfoKey(displayId: entity.displayId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatureModelInfoKey && other.displayId == displayId;

  @override
  int get hashCode => displayId.hashCode;
}
