// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_area_repository.dart';

mixin _SpellAreaRepositoryMixin on RepositoryMixin {
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
    return laconic.table('spell_area').where('`spell`', spell).count();
  }

  Future<SpellAreaEntity> createSpellArea(int spell) async {
    return SpellAreaEntity(
      spell: spell,
      area: await nextMaxPlusOne(
        'spell_area',
        '`area`',
        where: {'spell': spell},
      ),
      questStart: await nextMaxPlusOne(
        'spell_area',
        '`quest_start`',
        where: {'spell': spell},
      ),
      auraSpell: await nextMaxPlusOne(
        'spell_area',
        '`aura_spell`',
        where: {'spell': spell},
      ),
      racemask: await nextMaxPlusOne(
        'spell_area',
        '`racemask`',
        where: {'spell': spell},
      ),
      gender: await nextMaxPlusOne(
        'spell_area',
        '`gender`',
        where: {'spell': spell},
      ),
    );
  }

  Future<void> destroySpellArea(SpellAreaKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('spell_area'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_area record not found');
    }
  }

  Future<SpellAreaEntity?> getSpellArea(SpellAreaKey key) async {
    final results = await _whereKey(
      laconic.table('spell_area'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellAreaEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellAreaEntity>> getBriefSpellAreas(
    int spell, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('spell_area').select([
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
      await laconic.table('spell_area').insert([json]);
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
    final json = prepareWriteJson(spellArea.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('spell_area'),
        originalKey,
      ).update(json);
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
