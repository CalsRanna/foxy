// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_duration_entity.dart';

mixin _SpellDurationEntityMixin {
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
    final self = this as SpellDurationEntity;
    return SpellDurationEntity(
      id: id ?? self.id,
      duration: duration ?? self.duration,
      durationPerLevel: durationPerLevel ?? self.durationPerLevel,
      maxDuration: maxDuration ?? self.maxDuration,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellDurationEntity;
    return {
      'ID': self.id,
      'Duration': self.duration,
      'DurationPerLevel': self.durationPerLevel,
      'MaxDuration': self.maxDuration,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellDurationEntity;
    return identical(self, other) ||
        other is SpellDurationEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.duration == other.duration &&
            self.durationPerLevel == other.durationPerLevel &&
            self.maxDuration == other.maxDuration;
  }

  @override
  int get hashCode {
    final self = this as SpellDurationEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.duration,
      self.durationPerLevel,
      self.maxDuration,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellDurationEntity;
    return 'SpellDurationEntity('
        'id: ${self.id}, '
        'duration: ${self.duration}, '
        'durationPerLevel: ${self.durationPerLevel}, '
        'maxDuration: ${self.maxDuration}'
        ')';
  }
}

final class BriefSpellDurationEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      duration: (json['Duration'] as num?)?.toInt() ?? 0,
      durationPerLevel: (json['DurationPerLevel'] as num?)?.toInt() ?? 0,
      maxDuration: (json['MaxDuration'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
