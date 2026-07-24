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

  Future<void> updateTaxiPath(int originalKey, TaxiPathEntity entity) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_taxi_path'),
        originalKey,
      ).update(entity.toJson());
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
