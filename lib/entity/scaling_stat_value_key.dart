import 'package:foxy/entity/scaling_stat_value_entity.dart';

class ScalingStatValueKey {
  final int id;

  const ScalingStatValueKey({required this.id});

  factory ScalingStatValueKey.fromEntity(ScalingStatValueEntity entity) {
    return ScalingStatValueKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ScalingStatValueKey && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
