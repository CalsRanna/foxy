import 'package:foxy/entity/taxi_path_entity.dart';
import 'package:foxy/entity/taxi_path_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class TaxiPathRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_taxi_path';

  Future<List<BriefTaxiPathEntity>> getBriefTaxiPaths({
    int page = 1,
    TaxiPathFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefTaxiPathEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<TaxiPathEntity>> getTaxiPaths() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => TaxiPathEntity.fromJson(row.toMap())).toList();
  }

  Future<int> countTaxiPaths({TaxiPathFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<TaxiPathEntity?> getTaxiPath(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : TaxiPathEntity.fromJson(rows.first.toMap());
  }

  Future<TaxiPathEntity> createTaxiPath() async =>
      TaxiPathEntity(id: await _getNextId());

  Future<int> storeTaxiPath(TaxiPathEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateTaxiPath(TaxiPathEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  Future<void> destroyTaxiPath(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyTaxiPath(int id) async {
    final source = await getTaxiPath(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveTaxiPath(TaxiPathEntity entity) async {
    if (await getTaxiPath(entity.id) == null) {
      await storeTaxiPath(entity);
    } else {
      await updateTaxiPath(entity);
    }
  }

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    TaxiPathFilterEntity? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
