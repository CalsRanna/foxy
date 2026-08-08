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

mixin _GameObjectDisplayInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectDisplayInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_game_object_display_info record not found',
      );
    }
  }

  Future<GameObjectDisplayInfoEntity?> getGameObjectDisplayInfo(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<int> storeGameObjectDisplayInfo(
    GameObjectDisplayInfoEntity gameObjectDisplayInfo,
  ) async {
    if (gameObjectDisplayInfo.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(gameObjectDisplayInfo);
    final json = prepareWriteJson(gameObjectDisplayInfo.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gameObjectDisplayInfo.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_game_object_display_info',
          );
        }
        rethrow;
      }
    }
    return gameObjectDisplayInfo.id;
  }

  Future<void> updateGameObjectDisplayInfo(
    int originalKey,
    GameObjectDisplayInfoEntity gameObjectDisplayInfo,
  ) async {
    await _beforeUpdate(originalKey, gameObjectDisplayInfo);
    final json = prepareWriteJson(gameObjectDisplayInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_game_object_display_info',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_game_object_display_info record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    GameObjectDisplayInfoEntity gameObjectDisplayInfo,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GameObjectDisplayInfoEntity gameObjectDisplayInfo,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_game_object_display_info';
