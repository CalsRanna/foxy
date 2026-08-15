// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_locale_repository.dart';

mixin _PageTextLocaleRepositoryMixin on RepositoryMixin {
  String get _table => 'page_text_locale';

  Future<void> destroyPageTextLocale(PageTextLocaleKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('page_text_locale record not found');
    }
  }

  Future<PageTextLocaleEntity?> getPageTextLocale(PageTextLocaleKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PageTextLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storePageTextLocale(PageTextLocaleEntity pageTextLocale) async {
    await _beforeStore(pageTextLocale);
    final json = prepareWriteJson(pageTextLocale.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = pageTextLocale.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in page_text_locale');
        }
        rethrow;
      }
    }
  }

  Future<void> updatePageTextLocale(
    PageTextLocaleKey originalKey,
    PageTextLocaleEntity pageTextLocale,
  ) async {
    await _beforeUpdate(originalKey, pageTextLocale);
    final json = prepareWriteJson(pageTextLocale.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in page_text_locale');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('page_text_locale record not found');
    }
  }

  Future<void> _beforeDestroy(PageTextLocaleKey key) async {}

  Future<void> _beforeStore(PageTextLocaleEntity pageTextLocale) async {}

  Future<void> _beforeUpdate(
    PageTextLocaleKey originalKey,
    PageTextLocaleEntity pageTextLocale,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, PageTextLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`locale`', key.locale);
    return query;
  }
}
