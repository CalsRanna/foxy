// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_music_repository.dart';

final class ZoneMusicFilter {
  final String id;
  final String name;

  const ZoneMusicFilter({this.id = '', this.name = ''});

  factory ZoneMusicFilter.fromJson(Map<String, dynamic> json) {
    return ZoneMusicFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ZoneMusicFilter copyWith({String? id, String? name}) {
    return ZoneMusicFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
