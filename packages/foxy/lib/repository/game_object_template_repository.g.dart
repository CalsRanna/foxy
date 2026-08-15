// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_object_template_repository.dart';

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

mixin _GameObjectTemplateRepositoryMixin on RepositoryMixin {
  String get _table => 'gameobject_template';

  Future<int> copyGameObjectTemplate(int key) async {
    final source = await getGameObjectTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('gameobject_template record not found');
    }
    final blank = await createGameObjectTemplate();
    final copied = source.copyWith(entry: blank.entry);
    await storeGameObjectTemplate(copied);
    return copied.entry;
  }

  Future<int> countGameObjectTemplates({
    GameObjectTemplateFilter? filter,
  }) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<GameObjectTemplateEntity> createGameObjectTemplate() async {
    return GameObjectTemplateEntity(
      entry: await nextMaxPlusOne(_table, '`entry`'),
    );
  }

  Future<void> destroyGameObjectTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('gameobject_template record not found');
    }
  }

  Future<GameObjectTemplateEntity?> getGameObjectTemplate(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGameObjectTemplateEntity>> getBriefGameObjectTemplates({
    int page = 1,
    GameObjectTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`entry`',
      '`type`',
      '`name`',
      '`size`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`entry`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GameObjectTemplateEntity>> getGameObjectTemplates() async {
    var builder = laconic.table(_table).orderBy('`entry`');
    final results = await builder.get();
    return results
        .map((e) => GameObjectTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> storeGameObjectTemplate(
    GameObjectTemplateEntity gameObjectTemplate,
  ) async {
    if (gameObjectTemplate.entry <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(gameObjectTemplate);
    final json = prepareWriteJson(gameObjectTemplate.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = gameObjectTemplate.copyWith(
        entry: await nextMaxPlusOne(_table, '`entry`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.entry;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in gameobject_template');
        }
        rethrow;
      }
    }
    return gameObjectTemplate.entry;
  }

  Future<void> updateGameObjectTemplate(
    int originalKey,
    GameObjectTemplateEntity gameObjectTemplate,
  ) async {
    await _beforeUpdate(originalKey, gameObjectTemplate);
    final json = prepareWriteJson(gameObjectTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in gameobject_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('gameobject_template record not found');
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GameObjectTemplateFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('`entry`', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`name`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    GameObjectTemplateEntity gameObjectTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GameObjectTemplateEntity gameObjectTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`entry`', key);
  }
}
