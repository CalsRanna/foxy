// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_ambience_entity.dart';

mixin _SoundAmbienceEntityMixin {
  int get id;
  int get ambienceId0;
  int get ambienceId1;

  static SoundAmbienceEntity fromJson(Map<String, dynamic> json) {
    return SoundAmbienceEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      ambienceId0: (json['AmbienceID0'] as num?)?.toInt() ?? 0,
      ambienceId1: (json['AmbienceID1'] as num?)?.toInt() ?? 0,
    );
  }

  SoundAmbienceEntity copyWith({int? id, int? ambienceId0, int? ambienceId1}) {
    return SoundAmbienceEntity(
      id: id ?? this.id,
      ambienceId0: ambienceId0 ?? this.ambienceId0,
      ambienceId1: ambienceId1 ?? this.ambienceId1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'AmbienceID0': ambienceId0, 'AmbienceID1': ambienceId1};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SoundAmbienceEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            ambienceId0 == other.ambienceId0 &&
            ambienceId1 == other.ambienceId1;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, ambienceId0, ambienceId1]);
  }

  @override
  String toString() {
    return 'SoundAmbienceEntity('
        'id: $id, '
        'ambienceId0: $ambienceId0, '
        'ambienceId1: $ambienceId1'
        ')';
  }
}
