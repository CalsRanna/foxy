import 'package:foxy/entity/destructible_model_data_entity.dart';

class DestructibleModelDataKey {
  final int id;

  const DestructibleModelDataKey({required this.id});

  factory DestructibleModelDataKey.fromEntity(
    DestructibleModelDataEntity entity,
  ) => DestructibleModelDataKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DestructibleModelDataKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
