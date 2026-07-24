// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_ambience_repository.dart';

final class SoundAmbienceFilter {
  final String id;

  const SoundAmbienceFilter({this.id = ''});

  factory SoundAmbienceFilter.fromJson(Map<String, dynamic> json) {
    return SoundAmbienceFilter(id: json['id']?.toString() ?? '');
  }

  SoundAmbienceFilter copyWith({String? id}) {
    return SoundAmbienceFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
