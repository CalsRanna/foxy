// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefSoundProviderPreferencesEntity {
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
      id: (json['ID'] as num?)?.toInt() ?? 0,
      description: json['Description']?.toString() ?? '',
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
