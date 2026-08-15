// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_linked_spell_repository.dart';

mixin _SpellLinkedSpellRepositoryMixin on RepositoryMixin {
  String get _table => 'spell_linked_spell';

  Future<SpellLinkedSpellKey> copySpellLinkedSpell(
    SpellLinkedSpellKey key,
  ) async {
    final source = await getSpellLinkedSpell(key);
    if (source == null) {
      throw RecordNotFoundException('spell_linked_spell record not found');
    }
    final blank = await createSpellLinkedSpell(source.spellTrigger);
    final copied = source.copyWith(
      spellTrigger: blank.spellTrigger,
      spellEffect: blank.spellEffect,
      type: blank.type,
    );
    await storeSpellLinkedSpell(copied);
    return SpellLinkedSpellKey.fromEntity(copied);
  }

  Future<int> countSpellLinkedSpells(int spellTrigger) async {
    return laconic.table(_table).where('`spell_trigger`', spellTrigger).count();
  }

  Future<SpellLinkedSpellEntity> createSpellLinkedSpell(
    int spellTrigger,
  ) async {
    return SpellLinkedSpellEntity(
      spellTrigger: spellTrigger,
      spellEffect: await nextMaxPlusOne(
        _table,
        '`spell_effect`',
        where: {'`spell_trigger`': spellTrigger},
      ),
      type: await nextMaxPlusOne(
        _table,
        '`type`',
        where: {'`spell_trigger`': spellTrigger},
      ),
    );
  }

  Future<void> destroySpellLinkedSpell(SpellLinkedSpellKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_linked_spell record not found');
    }
  }

  Future<SpellLinkedSpellEntity?> getSpellLinkedSpell(
    SpellLinkedSpellKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SpellLinkedSpellEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellLinkedSpellEntity>> getBriefSpellLinkedSpells(
    int spellTrigger, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`spell_trigger`',
      '`spell_effect`',
      '`type`',
      '`comment`',
    ]);
    builder = builder.where('`spell_trigger`', spellTrigger);
    builder = builder
        .orderBy('`spell_trigger`')
        .orderBy('`spell_effect`')
        .orderBy('`type`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellLinkedSpellEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSpellLinkedSpell(
    SpellLinkedSpellEntity spellLinkedSpell,
  ) async {
    await _beforeStore(spellLinkedSpell);
    final json = prepareWriteJson(spellLinkedSpell.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      throw DuplicateKeyException('duplicate key in spell_linked_spell');
    }
  }

  Future<void> updateSpellLinkedSpell(
    SpellLinkedSpellKey originalKey,
    SpellLinkedSpellEntity spellLinkedSpell,
  ) async {
    await _beforeUpdate(originalKey, spellLinkedSpell);
    final json = prepareWriteJson(spellLinkedSpell.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_linked_spell');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('spell_linked_spell record not found');
    }
  }

  Future<void> _beforeDestroy(SpellLinkedSpellKey key) async {}

  Future<void> _beforeStore(SpellLinkedSpellEntity spellLinkedSpell) async {}

  Future<void> _beforeUpdate(
    SpellLinkedSpellKey originalKey,
    SpellLinkedSpellEntity spellLinkedSpell,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, SpellLinkedSpellKey key) {
    var query = builder;
    query = query.where('`spell_trigger`', key.spellTrigger);
    query = query.where('`spell_effect`', key.spellEffect);
    query = query.where('`type`', key.type);
    return query;
  }
}
