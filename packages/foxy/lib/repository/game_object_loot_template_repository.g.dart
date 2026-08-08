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
      throw RecordNotFoundException(
        'gameobject_loot_template record not found',
      );
    }
    final blank = await createGameObjectLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeGameObjectLootTemplate(copied);
    return GameObjectLootTemplateKey.fromEntity(copied);
  }

  Future<int> countGameObjectLootTemplates(int entry) async {
    return laconic.table(_table).where('`Entry`', entry).count();
  }

  Future<GameObjectLootTemplateEntity> createGameObjectLootTemplate(
    int entry,
  ) async {
    return GameObjectLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(_table, '`Item`', where: {'`Entry`': entry}),
    );
  }

  Future<void> destroyGameObjectLootTemplate(
    GameObjectLootTemplateKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'gameobject_loot_template record not found',
      );
    }
  }

  Future<GameObjectLootTemplateEntity?> getGameObjectLootTemplate(
    GameObjectLootTemplateKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGameObjectLootTemplateEntity>>
  getBriefGameObjectLootTemplates(int entry, {int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
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
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gameObjectLootTemplate.copyWith(
        item: await nextMaxPlusOne(
          _table,
          '`Item`',
          where: {'`Entry`': gameObjectLootTemplate.entry},
        ),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in gameobject_loot_template',
          );
        }
        rethrow;
      }
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
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in gameobject_loot_template',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'gameobject_loot_template record not found',
      );
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

const _table = 'gameobject_loot_template';
