import 'package:foxy/entity/vehicle_key.dart';

class BriefVehicleEntity {
  final int id;
  final int flags;
  final double turnSpeed;

  const BriefVehicleEntity({this.id = 0, this.flags = 0, this.turnSpeed = 0});

  factory BriefVehicleEntity.fromJson(Map<String, dynamic> json) {
    return BriefVehicleEntity(
      id: json['ID'] ?? 0,
      flags: json['Flags'] ?? 0,
      turnSpeed: (json['TurnSpeed'] as num?)?.toDouble() ?? 0,
    );
  }

  VehicleKey get key => VehicleKey(id: id);
}
