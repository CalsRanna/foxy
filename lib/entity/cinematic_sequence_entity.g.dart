// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinematic_sequence_entity.dart';

mixin _CinematicSequenceEntityMixin {
  static CinematicSequenceEntity fromJson(Map<String, dynamic> json) {
    return CinematicSequenceEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
      camera0: (json['Camera0'] as num?)?.toInt() ?? 0,
      camera1: (json['Camera1'] as num?)?.toInt() ?? 0,
      camera2: (json['Camera2'] as num?)?.toInt() ?? 0,
      camera3: (json['Camera3'] as num?)?.toInt() ?? 0,
      camera4: (json['Camera4'] as num?)?.toInt() ?? 0,
      camera5: (json['Camera5'] as num?)?.toInt() ?? 0,
      camera6: (json['Camera6'] as num?)?.toInt() ?? 0,
      camera7: (json['Camera7'] as num?)?.toInt() ?? 0,
    );
  }

  CinematicSequenceEntity copyWith({
    int? id,
    int? soundId,
    int? camera0,
    int? camera1,
    int? camera2,
    int? camera3,
    int? camera4,
    int? camera5,
    int? camera6,
    int? camera7,
  }) {
    final self = this as CinematicSequenceEntity;
    return CinematicSequenceEntity(
      id: id ?? self.id,
      soundId: soundId ?? self.soundId,
      camera0: camera0 ?? self.camera0,
      camera1: camera1 ?? self.camera1,
      camera2: camera2 ?? self.camera2,
      camera3: camera3 ?? self.camera3,
      camera4: camera4 ?? self.camera4,
      camera5: camera5 ?? self.camera5,
      camera6: camera6 ?? self.camera6,
      camera7: camera7 ?? self.camera7,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CinematicSequenceEntity;
    return {
      'ID': self.id,
      'SoundID': self.soundId,
      'Camera0': self.camera0,
      'Camera1': self.camera1,
      'Camera2': self.camera2,
      'Camera3': self.camera3,
      'Camera4': self.camera4,
      'Camera5': self.camera5,
      'Camera6': self.camera6,
      'Camera7': self.camera7,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CinematicSequenceEntity;
    return identical(self, other) ||
        other is CinematicSequenceEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.soundId == other.soundId &&
            self.camera0 == other.camera0 &&
            self.camera1 == other.camera1 &&
            self.camera2 == other.camera2 &&
            self.camera3 == other.camera3 &&
            self.camera4 == other.camera4 &&
            self.camera5 == other.camera5 &&
            self.camera6 == other.camera6 &&
            self.camera7 == other.camera7;
  }

  @override
  int get hashCode {
    final self = this as CinematicSequenceEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.soundId,
      self.camera0,
      self.camera1,
      self.camera2,
      self.camera3,
      self.camera4,
      self.camera5,
      self.camera6,
      self.camera7,
    ]);
  }

  @override
  String toString() {
    final self = this as CinematicSequenceEntity;
    return 'CinematicSequenceEntity('
        'id: ${self.id}, '
        'soundId: ${self.soundId}, '
        'camera0: ${self.camera0}, '
        'camera1: ${self.camera1}, '
        'camera2: ${self.camera2}, '
        'camera3: ${self.camera3}, '
        'camera4: ${self.camera4}, '
        'camera5: ${self.camera5}, '
        'camera6: ${self.camera6}, '
        'camera7: ${self.camera7}'
        ')';
  }
}

final class BriefCinematicSequenceEntity {
  final int id;
  final int soundId;
  final int camera0;

  const BriefCinematicSequenceEntity({
    this.id = 0,
    this.soundId = 0,
    this.camera0 = 0,
  });

  factory BriefCinematicSequenceEntity.fromJson(Map<String, dynamic> json) {
    return BriefCinematicSequenceEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
      camera0: (json['Camera0'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
