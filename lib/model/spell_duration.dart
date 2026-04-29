class SpellDuration {
  final int id;
  final int duration;
  final int durationPerLevel;
  final int maxDuration;

  const SpellDuration({
    this.id = 0,
    this.duration = 0,
    this.durationPerLevel = 0,
    this.maxDuration = 0,
  });

  factory SpellDuration.fromJson(Map<String, dynamic> json) {
    return SpellDuration(
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
