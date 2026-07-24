// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class SoundProviderPreferencesFilterEntity {
  final String id;
  final String description;

  const SoundProviderPreferencesFilterEntity({
    this.id = '',
    this.description = '',
  });

  factory SoundProviderPreferencesFilterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return SoundProviderPreferencesFilterEntity(
      id: json['id']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  SoundProviderPreferencesFilterEntity copyWith({
    String? id,
    String? description,
  }) {
    return SoundProviderPreferencesFilterEntity(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description};
  }
}
