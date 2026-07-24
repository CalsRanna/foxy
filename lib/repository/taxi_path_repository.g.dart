// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxi_path_repository.dart';

mixin _TaxiPathRepositoryMixin on RepositoryMixin {
  Future<void> destroyTaxiPath(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_taxi_path'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<TaxiPathEntity?> getTaxiPath(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_taxi_path'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return TaxiPathEntity.fromJson(results.first.toMap());
  }

  Future<void> storeTaxiPath(TaxiPathEntity taxiPath) async {
    if (taxiPath.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(taxiPath);
    final json = _prepareWriteJson(taxiPath.toJson());
    try {
      await laconic.table('foxy.dbc_taxi_path').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateTaxiPath(int originalKey, TaxiPathEntity taxiPath) async {
    await _beforeUpdate(originalKey, taxiPath);
    final json = _prepareWriteJson(taxiPath.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_taxi_path'),
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

  Future<void> _beforeStore(TaxiPathEntity taxiPath) async {}

  Future<void> _beforeUpdate(int originalKey, TaxiPathEntity taxiPath) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

final class TaxiPathFilter {
  final String id;

  const TaxiPathFilter({this.id = ''});

  factory TaxiPathFilter.fromJson(Map<String, dynamic> json) {
    return TaxiPathFilter(id: json['id']?.toString() ?? '');
  }

  TaxiPathFilter copyWith({String? id}) {
    return TaxiPathFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
