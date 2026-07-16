class BriefZoneIntroMusicEntity {
  final int id;
  final String name;
  final int soundId;

  const BriefZoneIntroMusicEntity({
    this.id = 0,
    this.name = '',
    this.soundId = 0,
  });

  factory BriefZoneIntroMusicEntity.fromJson(Map<String, dynamic> json) =>
      BriefZoneIntroMusicEntity(
        id: json['ID'] ?? 0,
        name: json['Name'] ?? '',
        soundId: json['SoundID'] ?? 0,
      );
}

class ZoneIntroMusicEntity {
  final int id;
  final String name;
  final int soundId;
  final int priority;
  final int minDelayMinutes;

  const ZoneIntroMusicEntity({
    this.id = 0,
    this.name = '',
    this.soundId = 0,
    this.priority = 0,
    this.minDelayMinutes = 0,
  });

  factory ZoneIntroMusicEntity.fromJson(Map<String, dynamic> json) =>
      ZoneIntroMusicEntity(
        id: json['ID'] ?? 0,
        name: json['Name'] ?? '',
        soundId: json['SoundID'] ?? 0,
        priority: json['Priority'] ?? 0,
        minDelayMinutes: json['MinDelayMinutes'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'Name': name,
    'SoundID': soundId,
    'Priority': priority,
    'MinDelayMinutes': minDelayMinutes,
  };
}
