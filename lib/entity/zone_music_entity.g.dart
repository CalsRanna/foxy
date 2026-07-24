// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_music_entity.dart';

mixin _ZoneMusicEntityMixin {
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
    final self = this as ZoneMusicEntity;
    return ZoneMusicEntity(
      id: id ?? self.id,
      setName: setName ?? self.setName,
      silenceIntervalMin0: silenceIntervalMin0 ?? self.silenceIntervalMin0,
      silenceIntervalMin1: silenceIntervalMin1 ?? self.silenceIntervalMin1,
      silenceIntervalMax0: silenceIntervalMax0 ?? self.silenceIntervalMax0,
      silenceIntervalMax1: silenceIntervalMax1 ?? self.silenceIntervalMax1,
      sounds0: sounds0 ?? self.sounds0,
      sounds1: sounds1 ?? self.sounds1,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ZoneMusicEntity;
    return {
      'ID': self.id,
      'SetName': self.setName,
      'SilenceIntervalMin0': self.silenceIntervalMin0,
      'SilenceIntervalMin1': self.silenceIntervalMin1,
      'SilenceIntervalMax0': self.silenceIntervalMax0,
      'SilenceIntervalMax1': self.silenceIntervalMax1,
      'Sounds0': self.sounds0,
      'Sounds1': self.sounds1,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ZoneMusicEntity;
    return identical(self, other) ||
        other is ZoneMusicEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.setName == other.setName &&
            self.silenceIntervalMin0 == other.silenceIntervalMin0 &&
            self.silenceIntervalMin1 == other.silenceIntervalMin1 &&
            self.silenceIntervalMax0 == other.silenceIntervalMax0 &&
            self.silenceIntervalMax1 == other.silenceIntervalMax1 &&
            self.sounds0 == other.sounds0 &&
            self.sounds1 == other.sounds1;
  }

  @override
  int get hashCode {
    final self = this as ZoneMusicEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.setName,
      self.silenceIntervalMin0,
      self.silenceIntervalMin1,
      self.silenceIntervalMax0,
      self.silenceIntervalMax1,
      self.sounds0,
      self.sounds1,
    ]);
  }

  @override
  String toString() {
    final self = this as ZoneMusicEntity;
    return 'ZoneMusicEntity('
        'id: ${self.id}, '
        'setName: ${self.setName}, '
        'silenceIntervalMin0: ${self.silenceIntervalMin0}, '
        'silenceIntervalMin1: ${self.silenceIntervalMin1}, '
        'silenceIntervalMax0: ${self.silenceIntervalMax0}, '
        'silenceIntervalMax1: ${self.silenceIntervalMax1}, '
        'sounds0: ${self.sounds0}, '
        'sounds1: ${self.sounds1}'
        ')';
  }
}

final class BriefZoneMusicEntity {
  final int id;
  final String setName;
  final int sounds0;
  final int sounds1;

  const BriefZoneMusicEntity({
    this.id = 0,
    this.setName = '',
    this.sounds0 = 0,
    this.sounds1 = 0,
  });

  factory BriefZoneMusicEntity.fromJson(Map<String, dynamic> json) {
    return BriefZoneMusicEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      setName: json['SetName']?.toString() ?? '',
      sounds0: (json['Sounds0'] as num?)?.toInt() ?? 0,
      sounds1: (json['Sounds1'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
