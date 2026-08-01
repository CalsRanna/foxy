// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_type_repository.dart';

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

mixin _CurrencyTypeRepositoryMixin on RepositoryMixin {
  Future<int> copyCurrencyType(int key) async {
    final source = await getCurrencyType(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createCurrencyType();
    final copied = source.copyWith(id: blank.id);
    await storeCurrencyType(copied);
    return copied.id;
  }

  Future<int> countCurrencyTypes({CurrencyTypeFilter? filter}) async {
    return _applyFilter(
      laconic.table('foxy.dbc_currency_types'),
      filter,
    ).count();
  }

  Future<CurrencyTypeEntity> createCurrencyType() async {
    return CurrencyTypeEntity(
      id: await nextMaxPlusOne('foxy.dbc_currency_types', '`ID`'),
    );
  }

  Future<void> destroyCurrencyType(int key) async {
    await _beforeDestroy(key);
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

  Future<List<BriefCurrencyTypeEntity>> getBriefCurrencyTypes({
    int page = 1,
    CurrencyTypeFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_currency_types').select([
      '`ID`',
      '`ItemID`',
      '`CategoryID`',
      '`BitIndex`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefCurrencyTypeEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CurrencyTypeEntity>> getCurrencyTypes() async {
    var builder = laconic.table('foxy.dbc_currency_types').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => CurrencyTypeEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeCurrencyType(CurrencyTypeEntity currencyType) async {
    if (currencyType.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(currencyType);
    final json = prepareWriteJson(currencyType.toJson());
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
    final json = prepareWriteJson(currencyType.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_currency_types'),
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

  QueryBuilder _applyFilter(QueryBuilder builder, CurrencyTypeFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`it.name`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(CurrencyTypeEntity currencyType) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    CurrencyTypeEntity currencyType,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
