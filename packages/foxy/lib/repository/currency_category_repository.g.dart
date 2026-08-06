// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_category_repository.dart';

final class CurrencyCategoryFilter {
  final String id;
  final String name;

  const CurrencyCategoryFilter({this.id = '', this.name = ''});

  factory CurrencyCategoryFilter.fromJson(Map<String, dynamic> json) {
    return CurrencyCategoryFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CurrencyCategoryFilter copyWith({String? id, String? name}) {
    return CurrencyCategoryFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _CurrencyCategoryRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroyCurrencyCategory(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_currency_category'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_currency_category record not found',
      );
    }
  }

  Future<CurrencyCategoryEntity?> getCurrencyCategory(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_currency_category'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CurrencyCategoryEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getCurrencyCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveCurrencyCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeCurrencyCategory(
    CurrencyCategoryEntity currencyCategory,
  ) async {
    if (currencyCategory.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(currencyCategory);
    final json = prepareWriteJson(currencyCategory.toJson());
    try {
      await laconic.table('foxy.dbc_currency_category').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = currencyCategory.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_currency_category', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_currency_category').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_currency_category',
          );
        }
        rethrow;
      }
    }
    return currencyCategory.id;
  }

  Future<void> updateCurrencyCategory(
    int originalKey,
    CurrencyCategoryEntity currencyCategory,
  ) async {
    await _beforeUpdate(originalKey, currencyCategory);
    final json = prepareWriteJson(currencyCategory.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_currency_category'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_currency_category',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_currency_category record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CurrencyCategoryEntity currencyCategory) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CurrencyCategoryEntity currencyCategory,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
