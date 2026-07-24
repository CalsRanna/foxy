// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_intro_music_repository.dart';

final class ZoneIntroMusicFilter {
  final String id;
  final String name;

  const ZoneIntroMusicFilter({this.id = '', this.name = ''});

  factory ZoneIntroMusicFilter.fromJson(Map<String, dynamic> json) {
    return ZoneIntroMusicFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ZoneIntroMusicFilter copyWith({String? id, String? name}) {
    return ZoneIntroMusicFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
