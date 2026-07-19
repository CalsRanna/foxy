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

  SoundAmbienceEntity copyWith({int? id, int? ambienceId0, int? ambienceId1}) {
    return SoundAmbienceEntity(
      id: id ?? this.id,
      ambienceId0: ambienceId0 ?? this.ambienceId0,
      ambienceId1: ambienceId1 ?? this.ambienceId1,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'AmbienceID0': ambienceId0,
    'AmbienceID1': ambienceId1,
  };
}
