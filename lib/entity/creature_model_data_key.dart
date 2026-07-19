import 'package:foxy/entity/creature_model_data_entity.dart';

class CreatureModelDataKey {
  final int id;

  const CreatureModelDataKey({required this.id});

  factory CreatureModelDataKey.fromEntity(CreatureModelDataEntity entity) =>
      CreatureModelDataKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CreatureModelDataKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
