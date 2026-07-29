// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_locale_repository.dart';

mixin _GameObjectTemplateLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectTemplateLocale(
    GameObjectTemplateLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('gameobject_template_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GameObjectTemplateLocaleEntity?> getGameObjectTemplateLocale(
    GameObjectTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('gameobject_template_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectTemplateLocale(
    GameObjectTemplateLocaleEntity gameObjectTemplateLocale,
  ) async {
    await _beforeStore(gameObjectTemplateLocale);
    final json = prepareWriteJson(gameObjectTemplateLocale.toJson());
    try {
      await laconic.table('gameobject_template_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
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
        laconic.table('gameobject_template_locale'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
