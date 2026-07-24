// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_category_repository.dart';

mixin _CurrencyCategoryRepositoryMixin on RepositoryMixin {
  Future<void> destroyCurrencyCategory(int key) async {
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

  Future<void> updateCurrencyCategory(
    int originalKey,
    CurrencyCategoryEntity category,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_currency_category'),
        originalKey,
      ).update(category.toJson());
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
