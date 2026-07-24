// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_music_entity.dart';

mixin _ZoneMusicEntityMixin {
  int get id;
  String get setName;
  int get silenceIntervalMin0;
  int get silenceIntervalMin1;
  int get silenceIntervalMax0;
  int get silenceIntervalMax1;
  int get sounds0;
  int get sounds1;

  static ZoneMusicEntity fromJson(Map<String, dynamic> json) {
    return ZoneMusicEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      setName: json['SetName']?.toString() ?? '',
      silenceIntervalMin0: (json['SilenceIntervalMin0'] as num?)?.toInt() ?? 0,
      silenceIntervalMin1: (json['SilenceIntervalMin1'] as num?)?.toInt() ?? 0,
      silenceIntervalMax0: (json['SilenceIntervalMax0'] as num?)?.toInt() ?? 0,
      silenceIntervalMax1: (json['SilenceIntervalMax1'] as num?)?.toInt() ?? 0,
      sounds0: (json['Sounds0'] as num?)?.toInt() ?? 0,
      sounds1: (json['Sounds1'] as num?)?.toInt() ?? 0,
    );
  }

  ZoneMusicEntity copyWith({
    int? id,
    String? setName,
    int? silenceIntervalMin0,
    int? silenceIntervalMin1,
    int? silenceIntervalMax0,
    int? silenceIntervalMax1,
    int? sounds0,
    int? sounds1,
  }) {
    return ZoneMusicEntity(
      id: id ?? this.id,
      setName: setName ?? this.setName,
      silenceIntervalMin0: silenceIntervalMin0 ?? this.silenceIntervalMin0,
      silenceIntervalMin1: silenceIntervalMin1 ?? this.silenceIntervalMin1,
      silenceIntervalMax0: silenceIntervalMax0 ?? this.silenceIntervalMax0,
      silenceIntervalMax1: silenceIntervalMax1 ?? this.silenceIntervalMax1,
      sounds0: sounds0 ?? this.sounds0,
      sounds1: sounds1 ?? this.sounds1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SetName': setName,
      'SilenceIntervalMin0': silenceIntervalMin0,
      'SilenceIntervalMin1': silenceIntervalMin1,
      'SilenceIntervalMax0': silenceIntervalMax0,
      'SilenceIntervalMax1': silenceIntervalMax1,
      'Sounds0': sounds0,
      'Sounds1': sounds1,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ZoneMusicEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            setName == other.setName &&
            silenceIntervalMin0 == other.silenceIntervalMin0 &&
            silenceIntervalMin1 == other.silenceIntervalMin1 &&
            silenceIntervalMax0 == other.silenceIntervalMax0 &&
            silenceIntervalMax1 == other.silenceIntervalMax1 &&
            sounds0 == other.sounds0 &&
            sounds1 == other.sounds1;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      setName,
      silenceIntervalMin0,
      silenceIntervalMin1,
      silenceIntervalMax0,
      silenceIntervalMax1,
      sounds0,
      sounds1,
    ]);
  }

  @override
  String toString() {
    return 'ZoneMusicEntity('
        'id: $id, '
        'setName: $setName, '
        'silenceIntervalMin0: $silenceIntervalMin0, '
        'silenceIntervalMin1: $silenceIntervalMin1, '
        'silenceIntervalMax0: $silenceIntervalMax0, '
        'silenceIntervalMax1: $silenceIntervalMax1, '
        'sounds0: $sounds0, '
        'sounds1: $sounds1'
        ')';
  }
}
