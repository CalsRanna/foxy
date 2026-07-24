// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_duration_entity.dart';

mixin _SpellDurationEntityMixin {
  int get id;
  int get duration;
  int get durationPerLevel;
  int get maxDuration;

  static SpellDurationEntity fromJson(Map<String, dynamic> json) {
    return SpellDurationEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      duration: (json['Duration'] as num?)?.toInt() ?? 0,
      durationPerLevel: (json['DurationPerLevel'] as num?)?.toInt() ?? 0,
      maxDuration: (json['MaxDuration'] as num?)?.toInt() ?? 0,
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellDurationEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            duration == other.duration &&
            durationPerLevel == other.durationPerLevel &&
            maxDuration == other.maxDuration;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      duration,
      durationPerLevel,
      maxDuration,
    ]);
  }

  @override
  String toString() {
    return 'SpellDurationEntity('
        'id: $id, '
        'duration: $duration, '
        'durationPerLevel: $durationPerLevel, '
        'maxDuration: $maxDuration'
        ')';
  }
}
