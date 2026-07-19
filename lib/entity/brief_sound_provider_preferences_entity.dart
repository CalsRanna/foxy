import 'package:foxy/entity/sound_provider_preferences_key.dart';

class BriefSoundProviderPreferencesEntity {
  final int id;
  final String description;
  final int flags;

  const BriefSoundProviderPreferencesEntity({
    this.id = 0,
    this.description = '',
    this.flags = 0,
  });

  factory BriefSoundProviderPreferencesEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefSoundProviderPreferencesEntity(
      id: json['ID'] ?? 0,
      description: json['Description'] ?? '',
      flags: json['Flags'] ?? 0,
    );
  }

  SoundProviderPreferencesKey get key => SoundProviderPreferencesKey(id: id);
}
