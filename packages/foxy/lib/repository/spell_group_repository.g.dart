// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_group_repository.dart';

mixin _SpellGroupRepositoryMixin on RepositoryMixin {
  String get _table => 'spell_group';

  Future<SpellGroupKey> copySpellGroup(SpellGroupKey key) async {
    final source = await getSpellGroup(key);
    if (source == null) {
      throw RecordNotFoundException('spell_group record not found');
    }
    final blank = await createSpellGroup(source.spellId);
    final copied = source.copyWith(id: blank.id, spellId: blank.spellId);
    await storeSpellGroup(copied);
    return SpellGroupKey.fromEntity(copied);
  }

  Future<int> countSpellGroups(int spellId) async {
    return laconic.table(_table).where('`spell_id`', spellId).count();
  }

  Future<SpellGroupEntity> createSpellGroup(int spellId) async {
    return SpellGroupEntity(
      spellId: spellId,
      id: await nextMaxPlusOne(_table, '`id`', where: {'`spell_id`': spellId}),
    );
  }

  Future<void> destroySpellGroup(SpellGroupKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_group record not found');
    }
  }

  Future<SpellGroupEntity?> getSpellGroup(SpellGroupKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellGroupEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellGroupEntity>> getBriefSpellGroups(
    int spellId, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select(['`id`', '`spell_id`']);
    builder = builder.where('`spell_id`', spellId);
    builder = builder.orderBy('`id`').orderBy('`spell_id`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellGroupEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSpellGroup(SpellGroupEntity spellGroup) async {
    await _beforeStore(spellGroup);
    final json = prepareWriteJson(spellGroup.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellGroup.copyWith(
        id: await nextMaxPlusOne(
          _table,
          '`id`',
          where: {'`spell_id`': spellGroup.spellId},
        ),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in spell_group');
        }
        rethrow;
      }
    }
  }

  Future<void> updateSpellGroup(
    SpellGroupKey originalKey,
    SpellGroupEntity spellGroup,
  ) async {
    await _beforeUpdate(originalKey, spellGroup);
    final json = prepareWriteJson(spellGroup.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_group');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('spell_group record not found');
    }
  }

  Future<void> _beforeDestroy(SpellGroupKey key) async {}

  Future<void> _beforeStore(SpellGroupEntity spellGroup) async {}

  Future<void> _beforeUpdate(
    SpellGroupKey originalKey,
    SpellGroupEntity spellGroup,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, SpellGroupKey key) {
    var query = builder;
    query = query.where('`id`', key.id);
    query = query.where('`spell_id`', key.spellId);
    return query;
  }
}
