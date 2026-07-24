// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_type_repository.dart';

mixin _CurrencyTypeRepositoryMixin on RepositoryMixin {
  Future<void> destroyCurrencyType(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_currency_types'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CurrencyTypeEntity?> getCurrencyType(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_currency_types'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CurrencyTypeEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCurrencyType(CurrencyTypeEntity currencyType) async {
    if (currencyType.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(currencyType);
    final json = _prepareWriteJson(currencyType.toJson());
    try {
      await laconic.table('foxy.dbc_currency_types').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCurrencyType(
    int originalKey,
    CurrencyTypeEntity currencyType,
  ) async {
    await _beforeUpdate(originalKey, currencyType);
    final json = _prepareWriteJson(currencyType.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_currency_types'),
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

  Future<void> _beforeStore(CurrencyTypeEntity currencyType) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CurrencyTypeEntity currencyType,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class CurrencyTypeFilter {
  final String id;
  final String name;

  const CurrencyTypeFilter({this.id = '', this.name = ''});

  factory CurrencyTypeFilter.fromJson(Map<String, dynamic> json) {
    return CurrencyTypeFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  CurrencyTypeFilter copyWith({String? id, String? name}) {
    return CurrencyTypeFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
