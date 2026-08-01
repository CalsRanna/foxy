// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_intro_music_entity.dart';

final class BriefZoneIntroMusicEntity {
  final int id;
  final String name;
  final int soundId;

  const BriefZoneIntroMusicEntity({
    this.id = 0,
    this.name = '',
    this.soundId = 0,
  });

  factory BriefZoneIntroMusicEntity.fromJson(Map<String, dynamic> json) {
    return BriefZoneIntroMusicEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  int get hashCode => Object.hashAll([id, name, soundId]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefZoneIntroMusicEntity &&
            id == other.id &&
            name == other.name &&
            soundId == other.soundId;
  }

  @override
  String toString() {
    return 'BriefZoneIntroMusicEntity('
        'id: $id, '
        'name: $name, '
        'soundId: $soundId'
        ')';
  }
}

mixin _ZoneIntroMusicEntityMixin {
  @override
  int get hashCode {
    final self = this as ZoneIntroMusicEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.name,
      self.soundId,
      self.priority,
      self.minDelayMinutes,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as ZoneIntroMusicEntity;
    return identical(self, other) ||
        other is ZoneIntroMusicEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.name == other.name &&
            self.soundId == other.soundId &&
            self.priority == other.priority &&
            self.minDelayMinutes == other.minDelayMinutes;
  }

  ZoneIntroMusicEntity copyWith({
    int? id,
    String? name,
    int? soundId,
    int? priority,
    int? minDelayMinutes,
  }) {
    final self = this as ZoneIntroMusicEntity;
    return ZoneIntroMusicEntity(
      id: id ?? self.id,
      name: name ?? self.name,
      soundId: soundId ?? self.soundId,
      priority: priority ?? self.priority,
      minDelayMinutes: minDelayMinutes ?? self.minDelayMinutes,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ZoneIntroMusicEntity;
    return {
      'ID': self.id,
      'Name': self.name,
      'SoundID': self.soundId,
      'Priority': self.priority,
      'MinDelayMinutes': self.minDelayMinutes,
    };
  }

  @override
  String toString() {
    final self = this as ZoneIntroMusicEntity;
    return 'ZoneIntroMusicEntity('
        'id: ${self.id}, '
        'name: ${self.name}, '
        'soundId: ${self.soundId}, '
        'priority: ${self.priority}, '
        'minDelayMinutes: ${self.minDelayMinutes}'
        ')';
  }

  static ZoneIntroMusicEntity fromJson(Map<String, dynamic> json) {
    return ZoneIntroMusicEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
      priority: (json['Priority'] as num?)?.toInt() ?? 0,
      minDelayMinutes: (json['MinDelayMinutes'] as num?)?.toInt() ?? 0,
    );
  }
}
