import 'package:foxy/entity/scaling_stat_distribution_entity.dart';

class ScalingStatDistributionKey {
  final int id;

  const ScalingStatDistributionKey({required this.id});

  factory ScalingStatDistributionKey.fromEntity(
    ScalingStatDistributionEntity entity,
  ) {
    return ScalingStatDistributionKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ScalingStatDistributionKey && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
