import 'package:foxy/entity/zone_intro_music_key.dart';

class BriefZoneIntroMusicEntity {
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
      id: json['ID'] ?? 0,
      name: json['Name'] ?? '',
      soundId: json['SoundID'] ?? 0,
    );
  }

  ZoneIntroMusicKey get key => ZoneIntroMusicKey(id: id);
}
