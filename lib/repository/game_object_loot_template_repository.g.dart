// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_loot_template_repository.dart';

mixin _GameObjectLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectLootTemplate(
    GameObjectLootTemplateKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('gameobject_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GameObjectLootTemplateEntity?> getGameObjectLootTemplate(
    GameObjectLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('gameobject_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectLootTemplate(
    GameObjectLootTemplateEntity gameObjectLootTemplate,
  ) async {
    await _beforeStore(gameObjectLootTemplate);
    final json = _prepareWriteJson(gameObjectLootTemplate.toJson());
    try {
      await laconic.table('gameobject_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectLootTemplate(
    GameObjectLootTemplateKey originalKey,
    GameObjectLootTemplateEntity gameObjectLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, gameObjectLootTemplate);
    final json = _prepareWriteJson(gameObjectLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('gameobject_loot_template'),
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
    GameObjectLootTemplateEntity gameObjectLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectLootTemplateKey originalKey,
    GameObjectLootTemplateEntity gameObjectLootTemplate,
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

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class GameObjectLootTemplateFilter {
  final String entry;
  final String name;

  const GameObjectLootTemplateFilter({this.entry = '', this.name = ''});

  factory GameObjectLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return GameObjectLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  GameObjectLootTemplateFilter copyWith({String? entry, String? name}) {
    return GameObjectLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
