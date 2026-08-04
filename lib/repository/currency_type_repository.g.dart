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
      throw RecordNotFoundException('foxy.dbc_currency_types record not found');
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
      throw RecordNotFoundException('foxy.dbc_currency_types record not found');
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(currencyType);
    final json = prepareWriteJson(currencyType.toJson());
    try {
      await laconic.table('foxy.dbc_currency_types').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = currencyType.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_currency_types', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_currency_types').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_currency_types',
          );
        }
        rethrow;
      }
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
        throw DuplicateKeyException('duplicate key in foxy.dbc_currency_types');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_currency_types record not found');
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
