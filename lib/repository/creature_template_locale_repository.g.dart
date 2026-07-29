// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_locale_repository.dart';

mixin _CreatureTemplateLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureTemplateLocale(
    CreatureTemplateLocaleKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('creature_template_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureTemplateLocaleEntity?> getCreatureTemplateLocale(
    CreatureTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('creature_template_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureTemplateLocale(
    CreatureTemplateLocaleEntity creatureTemplateLocale,
  ) async {
    await _beforeStore(creatureTemplateLocale);
    final json = prepareWriteJson(creatureTemplateLocale.toJson());
    try {
      await laconic.table('creature_template_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
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
        laconic.table('creature_template_locale'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
