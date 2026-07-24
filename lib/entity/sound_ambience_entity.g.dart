// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_ambience_entity.dart';

mixin _SoundAmbienceEntityMixin {
  static SoundAmbienceEntity fromJson(Map<String, dynamic> json) {
    return SoundAmbienceEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      ambienceId0: (json['AmbienceID0'] as num?)?.toInt() ?? 0,
      ambienceId1: (json['AmbienceID1'] as num?)?.toInt() ?? 0,
    );
  }

  SoundAmbienceEntity copyWith({int? id, int? ambienceId0, int? ambienceId1}) {
    final self = this as SoundAmbienceEntity;
    return SoundAmbienceEntity(
      id: id ?? self.id,
      ambienceId0: ambienceId0 ?? self.ambienceId0,
      ambienceId1: ambienceId1 ?? self.ambienceId1,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SoundAmbienceEntity;
    return {
      'ID': self.id,
      'AmbienceID0': self.ambienceId0,
      'AmbienceID1': self.ambienceId1,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SoundAmbienceEntity;
    return identical(self, other) ||
        other is SoundAmbienceEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.ambienceId0 == other.ambienceId0 &&
            self.ambienceId1 == other.ambienceId1;
  }

  @override
  int get hashCode {
    final self = this as SoundAmbienceEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.ambienceId0,
      self.ambienceId1,
    ]);
  }

  @override
  String toString() {
    final self = this as SoundAmbienceEntity;
    return 'SoundAmbienceEntity('
        'id: ${self.id}, '
        'ambienceId0: ${self.ambienceId0}, '
        'ambienceId1: ${self.ambienceId1}'
        ')';
  }
}

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
