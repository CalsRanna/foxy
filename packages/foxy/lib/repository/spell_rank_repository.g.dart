// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_rank_repository.dart';

mixin _SpellRankRepositoryMixin on RepositoryMixin {
  Future<SpellRankKey> copySpellRank(SpellRankKey key) async {
    final source = await getSpellRank(key);
    if (source == null) {
      throw RecordNotFoundException('spell_ranks record not found');
    }
    final blank = await createSpellRank(source.firstSpellId);
    final copied = source.copyWith(
      firstSpellId: blank.firstSpellId,
      rank: blank.rank,
    );
    await storeSpellRank(copied);
    return SpellRankKey.fromEntity(copied);
  }

  Future<int> countSpellRanks(int firstSpellId) async {
    return laconic
        .table(_table)
        .where('`first_spell_id`', firstSpellId)
        .count();
  }

  Future<SpellRankEntity> createSpellRank(int firstSpellId) async {
    return SpellRankEntity(
      firstSpellId: firstSpellId,
      rank: await nextMaxPlusOne(
        _table,
        '`rank`',
        where: {'`first_spell_id`': firstSpellId},
      ),
    );
  }

  Future<void> destroySpellRank(SpellRankKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_ranks record not found');
    }
  }

  Future<SpellRankEntity?> getSpellRank(SpellRankKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellRankEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellRankEntity>> getBriefSpellRanks(
    int firstSpellId, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`first_spell_id`',
      '`spell_id`',
      '`rank`',
    ]);
    builder = builder.where('`first_spell_id`', firstSpellId);
    builder = builder.orderBy('`first_spell_id`').orderBy('`rank`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellRankEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSpellRank(SpellRankEntity spellRank) async {
    await _beforeStore(spellRank);
    final json = prepareWriteJson(spellRank.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellRank.copyWith(
        rank: await nextMaxPlusOne(
          _table,
          '`rank`',
          where: {'`first_spell_id`': spellRank.firstSpellId},
        ),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in spell_ranks');
        }
        rethrow;
      }
    }
  }

  Future<void> updateSpellRank(
    SpellRankKey originalKey,
    SpellRankEntity spellRank,
  ) async {
    await _beforeUpdate(originalKey, spellRank);
    final json = prepareWriteJson(spellRank.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_ranks');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('spell_ranks record not found');
    }
  }

  Future<void> _beforeDestroy(SpellRankKey key) async {}

  Future<void> _beforeStore(SpellRankEntity spellRank) async {}

  Future<void> _beforeUpdate(
    SpellRankKey originalKey,
    SpellRankEntity spellRank,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, SpellRankKey key) {
    var query = builder;
    query = query.where('`first_spell_id`', key.firstSpellId);
    query = query.where('`rank`', key.rank);
    return query;
  }
}

const _table = 'spell_ranks';
