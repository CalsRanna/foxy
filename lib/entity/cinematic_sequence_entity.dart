class BriefCinematicSequenceEntity {
  final int id;
  final int soundId;
  final int camera0;

  const BriefCinematicSequenceEntity({
    this.id = 0,
    this.soundId = 0,
    this.camera0 = 0,
  });

  factory BriefCinematicSequenceEntity.fromJson(Map<String, dynamic> json) {
    return BriefCinematicSequenceEntity(
      id: json['ID'] ?? 0,
      soundId: json['SoundID'] ?? 0,
      camera0: json['Camera0'] ?? 0,
    );
  }
}

class CinematicSequenceEntity {
  final int id;
  final int soundId;
  final int camera0;
  final int camera1;
  final int camera2;
  final int camera3;
  final int camera4;
  final int camera5;
  final int camera6;
  final int camera7;

  const CinematicSequenceEntity({
    this.id = 0,
    this.soundId = 0,
    this.camera0 = 0,
    this.camera1 = 0,
    this.camera2 = 0,
    this.camera3 = 0,
    this.camera4 = 0,
    this.camera5 = 0,
    this.camera6 = 0,
    this.camera7 = 0,
  });

  factory CinematicSequenceEntity.fromJson(Map<String, dynamic> json) {
    return CinematicSequenceEntity(
      id: json['ID'] ?? 0,
      soundId: json['SoundID'] ?? 0,
      camera0: json['Camera0'] ?? 0,
      camera1: json['Camera1'] ?? 0,
      camera2: json['Camera2'] ?? 0,
      camera3: json['Camera3'] ?? 0,
      camera4: json['Camera4'] ?? 0,
      camera5: json['Camera5'] ?? 0,
      camera6: json['Camera6'] ?? 0,
      camera7: json['Camera7'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'SoundID': soundId,
    'Camera0': camera0,
    'Camera1': camera1,
    'Camera2': camera2,
    'Camera3': camera3,
    'Camera4': camera4,
    'Camera5': camera5,
    'Camera6': camera6,
    'Camera7': camera7,
  };
}
