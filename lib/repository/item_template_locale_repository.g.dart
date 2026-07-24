// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_locale_repository.dart';

mixin _ItemTemplateLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemTemplateLocale(ItemTemplateLocaleKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('item_template_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
    final json = _prepareWriteJson(itemTemplateLocale.toJson());
    try {
      await laconic.table('item_template_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemTemplateLocale(
    ItemTemplateLocaleKey originalKey,
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {
    await _beforeUpdate(originalKey, itemTemplateLocale);
    final json = _prepareWriteJson(itemTemplateLocale.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('item_template_locale'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {}

  Future<void> _beforeUpdate(
    ItemTemplateLocaleKey originalKey,
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, ItemTemplateLocaleKey key) {
    var query = builder;
    query = query.where('ID', key.id);
    query = query.where('locale', key.locale);
    return query;
  }
}
