// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
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

  int get key => id;
}
