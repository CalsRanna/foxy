// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_display_info_repository.dart';

mixin _GameObjectDisplayInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectDisplayInfo(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_game_object_display_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GameObjectDisplayInfoEntity?> getGameObjectDisplayInfo(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_game_object_display_info'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectDisplayInfo(
    GameObjectDisplayInfoEntity gameObjectDisplayInfo,
  ) async {
    if (gameObjectDisplayInfo.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(gameObjectDisplayInfo);
    final json = _prepareWriteJson(gameObjectDisplayInfo.toJson());
    try {
      await laconic.table('foxy.dbc_game_object_display_info').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectDisplayInfo(
    int originalKey,
    GameObjectDisplayInfoEntity gameObjectDisplayInfo,
  ) async {
    await _beforeUpdate(originalKey, gameObjectDisplayInfo);
    final json = _prepareWriteJson(gameObjectDisplayInfo.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_game_object_display_info'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(
    GameObjectDisplayInfoEntity gameObjectDisplayInfo,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GameObjectDisplayInfoEntity gameObjectDisplayInfo,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
