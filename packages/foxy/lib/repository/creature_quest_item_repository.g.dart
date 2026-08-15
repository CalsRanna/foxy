// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_quest_item_repository.dart';

mixin _CreatureQuestItemRepositoryMixin on RepositoryMixin {
  String get _table => 'creature_questitem';

  Future<CreatureQuestItemKey> copyCreatureQuestItem(
    CreatureQuestItemKey key,
  ) async {
    final source = await getCreatureQuestItem(key);
    if (source == null) {
      throw RecordNotFoundException('creature_questitem record not found');
    }
    final blank = await createCreatureQuestItem(source.creatureEntry);
    final copied = source.copyWith(
      creatureEntry: blank.creatureEntry,
      idx: blank.idx,
    );
    await storeCreatureQuestItem(copied);
    return CreatureQuestItemKey.fromEntity(copied);
  }

  Future<int> countCreatureQuestItems(int creatureEntry) async {
    return laconic
        .table(_table)
        .where('`CreatureEntry`', creatureEntry)
        .count();
  }

  Future<CreatureQuestItemEntity> createCreatureQuestItem(
    int creatureEntry,
  ) async {
    return CreatureQuestItemEntity(
      creatureEntry: creatureEntry,
      idx: await nextMaxPlusOne(
        _table,
        '`Idx`',
        where: {'`CreatureEntry`': creatureEntry},
      ),
    );
  }

  Future<void> destroyCreatureQuestItem(CreatureQuestItemKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('creature_questitem record not found');
    }
  }

  Future<CreatureQuestItemEntity?> getCreatureQuestItem(
    CreatureQuestItemKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureQuestItemEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefCreatureQuestItemEntity>> getBriefCreatureQuestItems(
    int creatureEntry, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`CreatureEntry`',
      '`Idx`',
      '`ItemId`',
      '`VerifiedBuild`',
    ]);
    builder = builder.where('`CreatureEntry`', creatureEntry);
    builder = builder.orderBy('`CreatureEntry`').orderBy('`Idx`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureQuestItemEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureQuestItem(
    CreatureQuestItemEntity creatureQuestItem,
  ) async {
    await _beforeStore(creatureQuestItem);
    final json = prepareWriteJson(creatureQuestItem.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureQuestItem.copyWith(
        idx: await nextMaxPlusOne(
          _table,
          '`Idx`',
          where: {'`CreatureEntry`': creatureQuestItem.creatureEntry},
        ),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in creature_questitem');
        }
        rethrow;
      }
    }
  }

  Future<void> updateCreatureQuestItem(
    CreatureQuestItemKey originalKey,
    CreatureQuestItemEntity creatureQuestItem,
  ) async {
    await _beforeUpdate(originalKey, creatureQuestItem);
    final json = prepareWriteJson(creatureQuestItem.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in creature_questitem');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('creature_questitem record not found');
    }
  }

  Future<void> _beforeDestroy(CreatureQuestItemKey key) async {}

  Future<void> _beforeStore(CreatureQuestItemEntity creatureQuestItem) async {}

  Future<void> _beforeUpdate(
    CreatureQuestItemKey originalKey,
    CreatureQuestItemEntity creatureQuestItem,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestItemKey key) {
    var query = builder;
    query = query.where('`CreatureEntry`', key.creatureEntry);
    query = query.where('`Idx`', key.idx);
    return query;
  }
}
