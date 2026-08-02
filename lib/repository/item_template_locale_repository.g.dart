// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_locale_repository.dart';

mixin _ItemTemplateLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemTemplateLocale(ItemTemplateLocaleKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('item_template_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('item_template_locale record not found');
    }
  }

  Future<ItemTemplateLocaleEntity?> getItemTemplateLocale(
    ItemTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('item_template_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemTemplateLocale(
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {
    await _beforeStore(itemTemplateLocale);
    final json = prepareWriteJson(itemTemplateLocale.toJson());
    try {
      await laconic.table('item_template_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in item_template_locale');
      }
      rethrow;
    }
  }

  Future<void> updateItemTemplateLocale(
    ItemTemplateLocaleKey originalKey,
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {
    await _beforeUpdate(originalKey, itemTemplateLocale);
    final json = prepareWriteJson(itemTemplateLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('item_template_locale'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in item_template_locale');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('item_template_locale record not found');
    }
  }

  Future<void> _beforeDestroy(ItemTemplateLocaleKey key) async {}

  Future<void> _beforeStore(
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {}

  Future<void> _beforeUpdate(
    ItemTemplateLocaleKey originalKey,
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, ItemTemplateLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`locale`', key.locale);
    return query;
  }
}
