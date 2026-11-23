// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_locale_repository.dart';

mixin _ItemTemplateLocaleRepositoryMixin on RepositoryMixin {
  String get _table => 'item_template_locale';

  Future<void> destroyItemTemplateLocale(ItemTemplateLocaleKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('item_template_locale record not found');
    }
  }

  Future<ItemTemplateLocaleEntity?> getItemTemplateLocale(
    ItemTemplateLocaleKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemTemplateLocaleEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemTemplateLocale(
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {
    await _beforeStore(itemTemplateLocale);
    final json = prepareWriteJson(itemTemplateLocale.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(
          ItemTemplateLocaleKey.fromEntity(itemTemplateLocale),
        ),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemTemplateLocale.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(ItemTemplateLocaleKey.fromEntity(retried)),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in item_template_locale');
        }
        rethrow;
      }
    }
  }

  Future<void> updateItemTemplateLocale(
    ItemTemplateLocaleKey originalKey,
    ItemTemplateLocaleEntity itemTemplateLocale,
  ) async {
    await _beforeUpdate(originalKey, itemTemplateLocale);
    final values = itemTemplateLocale.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(
          ItemTemplateLocaleKey.fromEntity(itemTemplateLocale),
        ),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
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

  Map<String, Object?> activityKey(ItemTemplateLocaleKey key) => {
    'ID': key.id,
    'locale': key.locale,
  };

  QueryBuilder _whereKey(QueryBuilder builder, ItemTemplateLocaleKey key) {
    var query = builder;
    query = query.where('`ID`', key.id);
    query = query.where('`locale`', key.locale);
    return query;
  }
}
