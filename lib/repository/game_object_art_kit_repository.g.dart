// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_art_kit_repository.dart';

mixin _GameObjectArtKitRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectArtKit(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_game_object_art_kit'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GameObjectArtKitEntity?> getGameObjectArtKit(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_game_object_art_kit'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectArtKitEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectArtKit(
    GameObjectArtKitEntity gameObjectArtKit,
  ) async {
    if (gameObjectArtKit.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(gameObjectArtKit);
    final json = _prepareWriteJson(gameObjectArtKit.toJson());
    try {
      await laconic.table('foxy.dbc_game_object_art_kit').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectArtKit(
    int originalKey,
    GameObjectArtKitEntity gameObjectArtKit,
  ) async {
    await _beforeUpdate(originalKey, gameObjectArtKit);
    final json = _prepareWriteJson(gameObjectArtKit.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_game_object_art_kit'),
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

  Future<void> _beforeStore(GameObjectArtKitEntity gameObjectArtKit) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GameObjectArtKitEntity gameObjectArtKit,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
