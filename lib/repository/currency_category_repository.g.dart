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
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> storeCurrencyCategory(
    CurrencyCategoryEntity currencyCategory,
  ) async {
    if (currencyCategory.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(currencyCategory);
    final json = prepareWriteJson(currencyCategory.toJson());
    try {
      await laconic.table('foxy.dbc_currency_category').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
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
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
