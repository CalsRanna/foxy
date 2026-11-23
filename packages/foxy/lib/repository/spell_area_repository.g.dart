// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_area_repository.dart';

mixin _SpellAreaRepositoryMixin on RepositoryMixin {
  String get _table => 'spell_area';

  Future<SpellAreaKey> copySpellArea(SpellAreaKey key) async {
    final source = await getSpellArea(key);
    if (source == null) {
      throw RecordNotFoundException('spell_area record not found');
    }
    final blank = await createSpellArea(source.spell);
    final copied = source.copyWith(
      spell: blank.spell,
      area: blank.area,
      questStart: blank.questStart,
      auraSpell: blank.auraSpell,
      racemask: blank.racemask,
      gender: blank.gender,
    );
    await storeSpellArea(copied);
    return SpellAreaKey.fromEntity(copied);
  }

  Future<int> countSpellAreas(int spell) async {
    return laconic.table(_table).where('`spell`', spell).count();
  }

  Future<SpellAreaEntity> createSpellArea(int spell) async {
    return SpellAreaEntity(
      spell: spell,
      area: await nextMaxPlusOne(_table, '`area`', where: {'`spell`': spell}),
      questStart: await nextMaxPlusOne(
        _table,
        '`quest_start`',
        where: {'`spell`': spell},
      ),
      auraSpell: await nextMaxPlusOne(
        _table,
        '`aura_spell`',
        where: {'`spell`': spell},
      ),
      racemask: await nextMaxPlusOne(
        _table,
        '`racemask`',
        where: {'`spell`': spell},
      ),
      gender: await nextMaxPlusOne(
        _table,
        '`gender`',
        where: {'`spell`': spell},
      ),
    );
  }

  Future<void> destroySpellArea(SpellAreaKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_area record not found');
    }
  }

  Future<SpellAreaEntity?> getSpellArea(SpellAreaKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellAreaEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellAreaEntity>> getBriefSpellAreas(
    int spell, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`spell`',
      '`area`',
      '`quest_start`',
      '`quest_end`',
      '`aura_spell`',
      '`racemask`',
      '`gender`',
      '`quest_start_status`',
      '`quest_end_status`',
    ]);
    builder = builder.where('`spell`', spell);
    builder = builder
        .orderBy('`spell`')
        .orderBy('`area`')
        .orderBy('`quest_start`')
        .orderBy('`aura_spell`')
        .orderBy('`racemask`')
        .orderBy('`gender`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellAreaEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSpellArea(SpellAreaEntity spellArea) async {
    await _beforeStore(spellArea);
    final json = prepareWriteJson(spellArea.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(SpellAreaKey.fromEntity(spellArea)),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      throw DuplicateKeyException('duplicate key in spell_area');
    }
  }

  Future<void> updateSpellArea(
    SpellAreaKey originalKey,
    SpellAreaEntity spellArea,
  ) async {
    await _beforeUpdate(originalKey, spellArea);
    final values = spellArea.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(SpellAreaKey.fromEntity(spellArea)),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_area');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('spell_area record not found');
    }
  }

  Future<void> _beforeDestroy(SpellAreaKey key) async {}

  Future<void> _beforeStore(SpellAreaEntity spellArea) async {}

  Future<void> _beforeUpdate(
    SpellAreaKey originalKey,
    SpellAreaEntity spellArea,
  ) async {}

  Map<String, Object?> activityKey(SpellAreaKey key) => {
    'spell': key.spell,
    'area': key.area,
    'quest_start': key.questStart,
    'aura_spell': key.auraSpell,
    'racemask': key.racemask,
    'gender': key.gender,
  };

  QueryBuilder _whereKey(QueryBuilder builder, SpellAreaKey key) {
    var query = builder;
    query = query.where('`spell`', key.spell);
    query = query.where('`area`', key.area);
    query = query.where('`quest_start`', key.questStart);
    query = query.where('`aura_spell`', key.auraSpell);
    query = query.where('`racemask`', key.racemask);
    query = query.where('`gender`', key.gender);
    return query;
  }
}
