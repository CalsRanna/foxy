class SoundAmbienceEntity {
  final int id;
  final int ambienceId0;
  final int ambienceId1;

  const SoundAmbienceEntity({
    this.id = 0,
    this.ambienceId0 = 0,
    this.ambienceId1 = 0,
  });

  factory SoundAmbienceEntity.fromJson(Map<String, dynamic> json) =>
      SoundAmbienceEntity(
        id: json['ID'] ?? 0,
        ambienceId0: json['AmbienceID0'] ?? 0,
        ambienceId1: json['AmbienceID1'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'AmbienceID0': ambienceId0,
    'AmbienceID1': ambienceId1,
  };
}

class BriefSoundAmbienceEntity {
  final int id;
  final int ambienceId0;
  final int ambienceId1;

  const BriefSoundAmbienceEntity({
    this.id = 0,
    this.ambienceId0 = 0,
    this.ambienceId1 = 0,
  });

  factory BriefSoundAmbienceEntity.fromJson(Map<String, dynamic> json) =>
      BriefSoundAmbienceEntity(
        id: json['ID'] ?? 0,
        ambienceId0: json['AmbienceID0'] ?? 0,
        ambienceId1: json['AmbienceID1'] ?? 0,
      );
}
