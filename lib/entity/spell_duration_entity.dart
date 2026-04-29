class SpellDurationEntity {
  final int id;
  final int duration;
  final int durationPerLevel;
  final int maxDuration;

  const SpellDurationEntity({
    this.id = 0,
    this.duration = 0,
    this.durationPerLevel = 0,
    this.maxDuration = 0,
  });

  factory SpellDurationEntity.fromJson(Map<String, dynamic> json) {
    return SpellDurationEntity(
      id: json['ID'] ?? 0,
      duration: json['Duration'] ?? 0,
      durationPerLevel: json['DurationPerLevel'] ?? 0,
      maxDuration: json['MaxDuration'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Duration': duration,
      'DurationPerLevel': durationPerLevel,
      'MaxDuration': maxDuration,
    };
  }
}
