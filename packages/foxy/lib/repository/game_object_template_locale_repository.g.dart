// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_locale_repository.dart';

mixin _GameObjectTemplateLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectTemplateLocale(
    GameObjectTemplateLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'gameobject_template_locale record not found',
      );
    }
  }

  Future<GameObjectTemplateLocaleEntity?> getGameObjectTemplateLocale(
    GameObjectTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectTemplateLocale(
    GameObjectTemplateLocaleEntity gameObjectTemplateLocale,
  ) async {
    await _beforeStore(gameObjectTemplateLocale);
    final json = prepareWriteJson(gameObjectTemplateLocale.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gameObjectTemplateLocale.copyWith(
        entry: await nextMaxPlusOne(_table, '`entry`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in gameobject_template_locale',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateGameObjectTemplateLocale(
    GameObjectTemplateLocaleKey originalKey,
    GameObjectTemplateLocaleEntity gameObjectTemplateLocale,
  ) async {
    await _beforeUpdate(originalKey, gameObjectTemplateLocale);
    final json = prepareWriteJson(gameObjectTemplateLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in gameobject_template_locale',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'gameobject_template_locale record not found',
      );
    }
  }

  Future<void> _beforeDestroy(GameObjectTemplateLocaleKey key) async {}

  Future<void> _beforeStore(
    GameObjectTemplateLocaleEntity gameObjectTemplateLocale,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectTemplateLocaleKey originalKey,
    GameObjectTemplateLocaleEntity gameObjectTemplateLocale,
  ) async {}

  QueryBuilder _whereKey(
    QueryBuilder builder,
    GameObjectTemplateLocaleKey key,
  ) {
    var query = builder;
    query = query.where('`entry`', key.entry);
    query = query.where('`locale`', key.locale);
    return query;
  }
}

const _table = 'gameobject_template_locale';
