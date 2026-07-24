// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_display_info_repository.dart';

final class GameObjectDisplayInfoFilter {
  final String id;
  final String modelName;

  const GameObjectDisplayInfoFilter({this.id = '', this.modelName = ''});

  factory GameObjectDisplayInfoFilter.fromJson(Map<String, dynamic> json) {
    return GameObjectDisplayInfoFilter(
      id: json['id']?.toString() ?? '',
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  GameObjectDisplayInfoFilter copyWith({String? id, String? modelName}) {
    return GameObjectDisplayInfoFilter(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}
