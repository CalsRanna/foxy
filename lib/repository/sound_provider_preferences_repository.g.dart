// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_provider_preferences_repository.dart';

mixin _SoundProviderPreferencesRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class SoundProviderPreferencesFilter {
  final String id;
  final String description;

  const SoundProviderPreferencesFilter({this.id = '', this.description = ''});

  factory SoundProviderPreferencesFilter.fromJson(Map<String, dynamic> json) {
    return SoundProviderPreferencesFilter(
      id: json['id']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  SoundProviderPreferencesFilter copyWith({String? id, String? description}) {
    return SoundProviderPreferencesFilter(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'description': description};
  }
}
