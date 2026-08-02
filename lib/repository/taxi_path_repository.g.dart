// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxi_path_repository.dart';

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

mixin _TaxiPathRepositoryMixin on RepositoryMixin {
  Future<void> destroyTaxiPath(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_taxi_path'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_taxi_path record not found');
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
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(taxiPath);
    final json = prepareWriteJson(taxiPath.toJson());
    try {
      await laconic.table('foxy.dbc_taxi_path').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_taxi_path');
      }
      rethrow;
    }
  }

  Future<void> updateTaxiPath(int originalKey, TaxiPathEntity taxiPath) async {
    await _beforeUpdate(originalKey, taxiPath);
    final json = prepareWriteJson(taxiPath.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_taxi_path'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_taxi_path');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_taxi_path record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(TaxiPathEntity taxiPath) async {}

  Future<void> _beforeUpdate(int originalKey, TaxiPathEntity taxiPath) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
