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

mixin _GameObjectArtKitRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectArtKit(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_game_object_art_kit'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_game_object_art_kit record not found',
      );
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

  Future<int> storeGameObjectArtKit(
    GameObjectArtKitEntity gameObjectArtKit,
  ) async {
    if (gameObjectArtKit.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(gameObjectArtKit);
    final json = prepareWriteJson(gameObjectArtKit.toJson());
    try {
      await laconic.table('foxy.dbc_game_object_art_kit').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gameObjectArtKit.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_game_object_art_kit', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_game_object_art_kit').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_game_object_art_kit',
          );
        }
        rethrow;
      }
    }
    return gameObjectArtKit.id;
  }

  Future<void> updateGameObjectArtKit(
    int originalKey,
    GameObjectArtKitEntity gameObjectArtKit,
  ) async {
    await _beforeUpdate(originalKey, gameObjectArtKit);
    final json = prepareWriteJson(gameObjectArtKit.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_game_object_art_kit'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_game_object_art_kit',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_game_object_art_kit record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(GameObjectArtKitEntity gameObjectArtKit) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GameObjectArtKitEntity gameObjectArtKit,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
