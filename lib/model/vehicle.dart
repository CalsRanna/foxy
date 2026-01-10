/// 载具数据
class Vehicle {
  int id = 0;
  int flags = 0;
  double turnSpeed = 0;
  double pitchSpeed = 0;
  double pitchMin = 0;
  double pitchMax = 0;

  Vehicle();

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    flags = json['Flags'] ?? json['flags'] ?? 0;
    turnSpeed = (json['TurnSpeed'] ?? json['turnSpeed'] ?? 0).toDouble();
    pitchSpeed = (json['PitchSpeed'] ?? json['pitchSpeed'] ?? 0).toDouble();
    pitchMin = (json['PitchMin'] ?? json['pitchMin'] ?? 0).toDouble();
    pitchMax = (json['PitchMax'] ?? json['pitchMax'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Flags': flags,
      'TurnSpeed': turnSpeed,
      'PitchSpeed': pitchSpeed,
      'PitchMin': pitchMin,
      'PitchMax': pitchMax,
    };
  }
}
