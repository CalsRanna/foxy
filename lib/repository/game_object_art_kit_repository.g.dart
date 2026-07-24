// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_art_kit_repository.dart';

final class GameObjectArtKitFilter {
  final String id;
  final String path;

  const GameObjectArtKitFilter({this.id = '', this.path = ''});

  factory GameObjectArtKitFilter.fromJson(Map<String, dynamic> json) {
    return GameObjectArtKitFilter(
      id: json['id']?.toString() ?? '',
      path: json['path']?.toString() ?? '',
    );
  }

  GameObjectArtKitFilter copyWith({String? id, String? path}) {
    return GameObjectArtKitFilter(id: id ?? this.id, path: path ?? this.path);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'path': path};
  }
}
