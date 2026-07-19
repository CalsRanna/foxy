import 'package:foxy/entity/point_of_interest_entity.dart';

class PointOfInterestKey {
  final int id;

  const PointOfInterestKey({required this.id});

  factory PointOfInterestKey.fromEntity(PointOfInterestEntity entity) =>
      PointOfInterestKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PointOfInterestKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
