// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_intro_music_entity.dart';

mixin _ZoneIntroMusicEntityMixin {
  int get id;
  String get name;
  int get soundId;
  int get priority;
  int get minDelayMinutes;

  static ZoneIntroMusicEntity fromJson(Map<String, dynamic> json) {
    return ZoneIntroMusicEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
      priority: (json['Priority'] as num?)?.toInt() ?? 0,
      minDelayMinutes: (json['MinDelayMinutes'] as num?)?.toInt() ?? 0,
    );
  }

  ZoneIntroMusicEntity copyWith({
    int? id,
    String? name,
    int? soundId,
    int? priority,
    int? minDelayMinutes,
  }) {
    return ZoneIntroMusicEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      soundId: soundId ?? this.soundId,
      priority: priority ?? this.priority,
      minDelayMinutes: minDelayMinutes ?? this.minDelayMinutes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'SoundID': soundId,
      'Priority': priority,
      'MinDelayMinutes': minDelayMinutes,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ZoneIntroMusicEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            soundId == other.soundId &&
            priority == other.priority &&
            minDelayMinutes == other.minDelayMinutes;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      name,
      soundId,
      priority,
      minDelayMinutes,
    ]);
  }

  @override
  String toString() {
    return 'ZoneIntroMusicEntity('
        'id: $id, '
        'name: $name, '
        'soundId: $soundId, '
        'priority: $priority, '
        'minDelayMinutes: $minDelayMinutes'
        ')';
  }
}
