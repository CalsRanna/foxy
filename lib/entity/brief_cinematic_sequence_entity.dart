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

  int get key => id;
}
