// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinematic_sequence_entity.dart';

mixin _CinematicSequenceEntityMixin {
  int get id;
  int get soundId;
  int get camera0;
  int get camera1;
  int get camera2;
  int get camera3;
  int get camera4;
  int get camera5;
  int get camera6;
  int get camera7;

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
    return CinematicSequenceEntity(
      id: id ?? this.id,
      soundId: soundId ?? this.soundId,
      camera0: camera0 ?? this.camera0,
      camera1: camera1 ?? this.camera1,
      camera2: camera2 ?? this.camera2,
      camera3: camera3 ?? this.camera3,
      camera4: camera4 ?? this.camera4,
      camera5: camera5 ?? this.camera5,
      camera6: camera6 ?? this.camera6,
      camera7: camera7 ?? this.camera7,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SoundID': soundId,
      'Camera0': camera0,
      'Camera1': camera1,
      'Camera2': camera2,
      'Camera3': camera3,
      'Camera4': camera4,
      'Camera5': camera5,
      'Camera6': camera6,
      'Camera7': camera7,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CinematicSequenceEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            soundId == other.soundId &&
            camera0 == other.camera0 &&
            camera1 == other.camera1 &&
            camera2 == other.camera2 &&
            camera3 == other.camera3 &&
            camera4 == other.camera4 &&
            camera5 == other.camera5 &&
            camera6 == other.camera6 &&
            camera7 == other.camera7;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      soundId,
      camera0,
      camera1,
      camera2,
      camera3,
      camera4,
      camera5,
      camera6,
      camera7,
    ]);
  }

  @override
  String toString() {
    return 'CinematicSequenceEntity('
        'id: $id, '
        'soundId: $soundId, '
        'camera0: $camera0, '
        'camera1: $camera1, '
        'camera2: $camera2, '
        'camera3: $camera3, '
        'camera4: $camera4, '
        'camera5: $camera5, '
        'camera6: $camera6, '
        'camera7: $camera7'
        ')';
  }
}
