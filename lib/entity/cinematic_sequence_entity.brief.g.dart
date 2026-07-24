// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefCinematicSequenceEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
      camera0: (json['Camera0'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
