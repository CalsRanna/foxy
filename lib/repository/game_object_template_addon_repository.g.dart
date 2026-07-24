// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_addon_repository.dart';

mixin _GameObjectTemplateAddonRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectTemplateAddon(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('gameobject_template_addon'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GameObjectTemplateAddonEntity?> getGameObjectTemplateAddon(
    int key,
  ) async {
    final results = await _whereKey(
      laconic.table('gameobject_template_addon'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectTemplateAddon(
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) async {
    if (gameObjectTemplateAddon.entry <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(gameObjectTemplateAddon);
    final json = _prepareWriteJson(gameObjectTemplateAddon.toJson());
    try {
      await laconic.table('gameobject_template_addon').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectTemplateAddon(
    int originalKey,
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) async {
    await _beforeUpdate(originalKey, gameObjectTemplateAddon);
    final json = _prepareWriteJson(gameObjectTemplateAddon.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('gameobject_template_addon'),
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
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GameObjectTemplateAddonEntity gameObjectTemplateAddon,
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
    return builder.where('entry', key);
  }
}
