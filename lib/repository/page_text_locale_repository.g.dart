// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_locale_repository.dart';

mixin _PageTextLocaleRepositoryMixin on RepositoryMixin {
  Future<void> destroyPageTextLocale(PageTextLocaleKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('page_text_locale'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<PageTextLocaleEntity?> getPageTextLocale(PageTextLocaleKey key) async {
    final results = await _whereKey(
      laconic.table('page_text_locale'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return PageTextLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storePageTextLocale(PageTextLocaleEntity pageTextLocale) async {
    await _beforeStore(pageTextLocale);
    final json = _prepareWriteJson(pageTextLocale.toJson());
    try {
      await laconic.table('page_text_locale').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePageTextLocale(
    PageTextLocaleKey originalKey,
    PageTextLocaleEntity pageTextLocale,
  ) async {
    await _beforeUpdate(originalKey, pageTextLocale);
    final json = _prepareWriteJson(pageTextLocale.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('page_text_locale'),
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

  Future<void> _beforeStore(PageTextLocaleEntity pageTextLocale) async {}

  Future<void> _beforeUpdate(
    PageTextLocaleKey originalKey,
    PageTextLocaleEntity pageTextLocale,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, PageTextLocaleKey key) {
    var query = builder;
    query = query.where('ID', key.id);
    query = query.where('locale', key.locale);
    return query;
  }
}
