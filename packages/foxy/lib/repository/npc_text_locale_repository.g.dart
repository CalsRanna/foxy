// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_text_locale_repository.dart';

mixin _NpcTextLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyNpcTextLocale(NpcTextLocaleKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('npc_text_locale record not found');
    }
  }

  Future<NpcTextLocaleEntity?> getNpcTextLocale(NpcTextLocaleKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTextLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeNpcTextLocale(NpcTextLocaleEntity npcTextLocale) async {
    await _beforeStore(npcTextLocale);
    final json = prepareWriteJson(npcTextLocale.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = npcTextLocale.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in npc_text_locale');
        }
        rethrow;
      }
    }
  }

  Future<void> updateNpcTextLocale(
    NpcTextLocaleKey originalKey,
    NpcTextLocaleEntity npcTextLocale,
  ) async {
    await _beforeUpdate(originalKey, npcTextLocale);
    final json = prepareWriteJson(npcTextLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in npc_text_locale');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('npc_text_locale record not found');
    }
  }

  Future<void> _beforeDestroy(NpcTextLocaleKey key) async {}

  Future<void> _beforeStore(NpcTextLocaleEntity npcTextLocale) async {}

  Future<void> _beforeUpdate(
    NpcTextLocaleKey originalKey,
    NpcTextLocaleEntity npcTextLocale,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, NpcTextLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`Locale`', key.locale);
    return query;
  }
}

const _table = 'npc_text_locale';
