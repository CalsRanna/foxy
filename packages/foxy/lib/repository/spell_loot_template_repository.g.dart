// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_loot_template_repository.dart';

mixin _SpellLootTemplateRepositoryMixin on RepositoryMixin {
  Future<SpellLootTemplateKey> copySpellLootTemplate(
    SpellLootTemplateKey key,
  ) async {
    final source = await getSpellLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('spell_loot_template record not found');
    }
    final blank = await createSpellLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeSpellLootTemplate(copied);
    return SpellLootTemplateKey.fromEntity(copied);
  }

  Future<int> countSpellLootTemplates(int entry) async {
    return laconic.table('spell_loot_template').where('`Entry`', entry).count();
  }

  Future<SpellLootTemplateEntity> createSpellLootTemplate(int entry) async {
    return SpellLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(
        'spell_loot_template',
        '`Item`',
        where: {'`Entry`': entry},
      ),
    );
  }

  Future<void> destroySpellLootTemplate(SpellLootTemplateKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('spell_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('spell_loot_template record not found');
    }
  }

  Future<SpellLootTemplateEntity?> getSpellLootTemplate(
    SpellLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('spell_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SpellLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefSpellLootTemplateEntity>> getBriefSpellLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('spell_loot_template').select([
      '`Entry`',
      '`Item`',
      '`Reference`',
      '`Chance`',
      '`QuestRequired`',
      '`LootMode`',
      '`GroupId`',
      '`MinCount`',
      '`MaxCount`',
      '`Comment`',
    ]);
    builder = builder.where('`Entry`', entry);
    builder = builder.orderBy('`Entry`').orderBy('`Item`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSpellLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeSpellLootTemplate(
    SpellLootTemplateEntity spellLootTemplate,
  ) async {
    await _beforeStore(spellLootTemplate);
    final json = prepareWriteJson(spellLootTemplate.toJson());
    try {
      await laconic.table('spell_loot_template').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = spellLootTemplate.copyWith(
        item: await nextMaxPlusOne(
          'spell_loot_template',
          '`Item`',
          where: {'`Entry`': spellLootTemplate.entry},
        ),
      );
      try {
        await laconic.table('spell_loot_template').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in spell_loot_template');
        }
        rethrow;
      }
    }
  }

  Future<void> updateSpellLootTemplate(
    SpellLootTemplateKey originalKey,
    SpellLootTemplateEntity spellLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, spellLootTemplate);
    final json = prepareWriteJson(spellLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('spell_loot_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in spell_loot_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('spell_loot_template record not found');
    }
  }

  Future<void> _beforeDestroy(SpellLootTemplateKey key) async {}

  Future<void> _beforeStore(SpellLootTemplateEntity spellLootTemplate) async {}

  Future<void> _beforeUpdate(
    SpellLootTemplateKey originalKey,
    SpellLootTemplateEntity spellLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, SpellLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
