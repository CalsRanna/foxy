// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefSoundAmbienceEntity {
  final int id;
  final int ambienceId0;
  final int ambienceId1;

  const BriefSoundAmbienceEntity({
    this.id = 0,
    this.ambienceId0 = 0,
    this.ambienceId1 = 0,
  });

  factory BriefSoundAmbienceEntity.fromJson(Map<String, dynamic> json) {
    return BriefSoundAmbienceEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      ambienceId0: (json['AmbienceID0'] as num?)?.toInt() ?? 0,
      ambienceId1: (json['AmbienceID1'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
