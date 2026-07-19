import 'package:foxy/entity/vehicle_entity.dart';

class VehicleKey {
  final int id;

  const VehicleKey({required this.id});

  factory VehicleKey.fromEntity(VehicleEntity entity) =>
      VehicleKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is VehicleKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
