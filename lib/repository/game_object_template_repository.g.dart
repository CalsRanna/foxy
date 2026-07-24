// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_repository.dart';

mixin _GameObjectTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyGameObjectTemplate(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('gameobject_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GameObjectTemplateEntity?> getGameObjectTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('gameobject_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectTemplate(
    GameObjectTemplateEntity gameObjectTemplate,
  ) async {
    if (gameObjectTemplate.entry <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(gameObjectTemplate);
    final json = _prepareWriteJson(gameObjectTemplate.toJson());
    try {
      await laconic.table('gameobject_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectTemplate(
    int originalKey,
    GameObjectTemplateEntity gameObjectTemplate,
  ) async {
    await _beforeUpdate(originalKey, gameObjectTemplate);
    final json = _prepareWriteJson(gameObjectTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('gameobject_template'),
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
    GameObjectTemplateEntity gameObjectTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GameObjectTemplateEntity gameObjectTemplate,
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
    return builder.where('entry', key);
  }
}

final class GameObjectTemplateFilter {
  final String entry;
  final String name;

  const GameObjectTemplateFilter({this.entry = '', this.name = ''});

  factory GameObjectTemplateFilter.fromJson(Map<String, dynamic> json) {
    return GameObjectTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  GameObjectTemplateFilter copyWith({String? entry, String? name}) {
    return GameObjectTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
