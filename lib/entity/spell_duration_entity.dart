/// 法术持续时间列表/Picker 展示模型
class BriefSpellDurationEntity {
  final int id;
  final int duration;
  final int durationPerLevel;
  final int maxDuration;

  const BriefSpellDurationEntity({
    this.id = 0,
    this.duration = 0,
    this.durationPerLevel = 0,
    this.maxDuration = 0,
  });

  factory BriefSpellDurationEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellDurationEntity(
      id: json['ID'] ?? 0,
      duration: json['Duration'] ?? 0,
      durationPerLevel: json['DurationPerLevel'] ?? 0,
      maxDuration: json['MaxDuration'] ?? 0,
    );
  }

  BriefSpellDurationEntity copyWith({
    int? id,
    int? duration,
    int? durationPerLevel,
    int? maxDuration,
  }) {
    return BriefSpellDurationEntity(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      durationPerLevel: durationPerLevel ?? this.durationPerLevel,
      maxDuration: maxDuration ?? this.maxDuration,
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

  SpellDurationEntity copyWith({
    int? id,
    int? duration,
    int? durationPerLevel,
    int? maxDuration,
  }) {
    return SpellDurationEntity(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      durationPerLevel: durationPerLevel ?? this.durationPerLevel,
      maxDuration: maxDuration ?? this.maxDuration,
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
