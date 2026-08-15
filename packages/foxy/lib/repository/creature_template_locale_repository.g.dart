// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_locale_repository.dart';

mixin _CreatureTemplateLocaleRepositoryMixin on RepositoryMixin {
  String get _table => 'creature_template_locale';

  Future<void> destroyCreatureTemplateLocale(
    CreatureTemplateLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'creature_template_locale record not found',
      );
    }
  }

  Future<CreatureTemplateLocaleEntity?> getCreatureTemplateLocale(
    CreatureTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureTemplateLocale(
    CreatureTemplateLocaleEntity creatureTemplateLocale,
  ) async {
    await _beforeStore(creatureTemplateLocale);
    final json = prepareWriteJson(creatureTemplateLocale.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = creatureTemplateLocale.copyWith(
        entry: await nextMaxPlusOne(_table, '`entry`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in creature_template_locale',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateCreatureTemplateLocale(
    CreatureTemplateLocaleKey originalKey,
    CreatureTemplateLocaleEntity creatureTemplateLocale,
  ) async {
    await _beforeUpdate(originalKey, creatureTemplateLocale);
    final json = prepareWriteJson(creatureTemplateLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in creature_template_locale',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'creature_template_locale record not found',
      );
    }
  }

  Future<void> _beforeDestroy(CreatureTemplateLocaleKey key) async {}

  Future<void> _beforeStore(
    CreatureTemplateLocaleEntity creatureTemplateLocale,
  ) async {}

  Future<void> _beforeUpdate(
    CreatureTemplateLocaleKey originalKey,
    CreatureTemplateLocaleEntity creatureTemplateLocale,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, CreatureTemplateLocaleKey key) {
    var query = builder;
    query = query.where('`entry`', key.entry);
    query = query.where('`locale`', key.locale);
    return query;
  }
}
