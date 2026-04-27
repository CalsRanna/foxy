class SpellDuration {
  int id = 0;
  int duration = 0;
  int durationPerLevel = 0;
  int maxDuration = 0;

  SpellDuration();

  SpellDuration.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    duration = json['Duration'] ?? 0;
    durationPerLevel = json['DurationPerLevel'] ?? 0;
    maxDuration = json['MaxDuration'] ?? 0;
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
