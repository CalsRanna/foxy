// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_loot_template_repository.dart';

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

mixin _GameObjectLootTemplateRepositoryMixin on RepositoryMixin {
  Future<GameObjectLootTemplateKey> copyGameObjectLootTemplate(
    GameObjectLootTemplateKey key,
  ) async {
    final source = await getGameObjectLootTemplate(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createGameObjectLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeGameObjectLootTemplate(copied);
    return GameObjectLootTemplateKey.fromEntity(copied);
  }

  Future<int> countGameObjectLootTemplates(int entry) async {
    return laconic
        .table('gameobject_loot_template')
        .where('`Entry`', entry)
        .count();
  }

  Future<GameObjectLootTemplateEntity> createGameObjectLootTemplate(
    int entry,
  ) async {
    return GameObjectLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(
        'gameobject_loot_template',
        '`Item`',
        where: {'Entry': entry},
      ),
    );
  }

  Future<void> destroyGameObjectLootTemplate(
    GameObjectLootTemplateKey key,
  ) async {
    await _beforeDestroy(key);
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

  Future<List<BriefGameObjectLootTemplateEntity>>
  getBriefGameObjectLootTemplates(int entry, {int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('gameobject_loot_template').select([
      '`Entry`',
      '`Item`',
      '`Reference`',
      '`Chance`',
      '`QuestRequired`',
      '`GroupId`',
      '`MinCount`',
      '`MaxCount`',
    ]);
    builder = builder.where('`Entry`', entry);
    builder = builder.orderBy('`Entry`').orderBy('`Item`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeGameObjectLootTemplate(
    GameObjectLootTemplateEntity gameObjectLootTemplate,
  ) async {
    await _beforeStore(gameObjectLootTemplate);
    final json = prepareWriteJson(gameObjectLootTemplate.toJson());
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
    final json = prepareWriteJson(gameObjectLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('gameobject_loot_template'),
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

  Future<void> _beforeDestroy(GameObjectLootTemplateKey key) async {}

  Future<void> _beforeStore(
    GameObjectLootTemplateEntity gameObjectLootTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    GameObjectLootTemplateKey originalKey,
    GameObjectLootTemplateEntity gameObjectLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
