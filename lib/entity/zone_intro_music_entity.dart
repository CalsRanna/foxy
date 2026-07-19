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

  Map<String, dynamic> toJson() => {
    'ID': id,
    'Name': name,
    'SoundID': soundId,
    'Priority': priority,
    'MinDelayMinutes': minDelayMinutes,
  };
}
