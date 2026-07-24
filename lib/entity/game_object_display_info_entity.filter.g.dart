// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class GameObjectDisplayInfoFilterEntity {
  final String id;
  final String modelName;

  const GameObjectDisplayInfoFilterEntity({this.id = '', this.modelName = ''});

  factory GameObjectDisplayInfoFilterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return GameObjectDisplayInfoFilterEntity(
      id: json['id']?.toString() ?? '',
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  GameObjectDisplayInfoFilterEntity copyWith({String? id, String? modelName}) {
    return GameObjectDisplayInfoFilterEntity(
      id: id ?? this.id,
      modelName: modelName ?? this.modelName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'modelName': modelName};
  }
}
