// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_addon_repository.dart';

mixin _GameObjectTemplateAddonRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectTemplateAddon(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'gameobject_template_addon record not found',
      );
    }
  }

  Future<GameObjectTemplateAddonEntity?> getGameObjectTemplateAddon(
    int key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<int> storeGameObjectTemplateAddon(
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) async {
    if (gameObjectTemplateAddon.entry <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(gameObjectTemplateAddon);
    final json = prepareWriteJson(gameObjectTemplateAddon.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gameObjectTemplateAddon.copyWith(
        entry: await nextMaxPlusOne(_table, '`entry`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.entry;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in gameobject_template_addon',
          );
        }
        rethrow;
      }
    }
    return gameObjectTemplateAddon.entry;
  }

  Future<void> updateGameObjectTemplateAddon(
    int originalKey,
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) async {
    await _beforeUpdate(originalKey, gameObjectTemplateAddon);
    final json = prepareWriteJson(gameObjectTemplateAddon.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in gameobject_template_addon',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'gameobject_template_addon record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`entry`', key);
  }
}

const _table = 'gameobject_template_addon';
