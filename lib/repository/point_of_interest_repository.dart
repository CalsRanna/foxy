import 'package:foxy/entity/point_of_interest_entity.dart';
import 'package:foxy/entity/point_of_interest_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PointOfInterestRepository with RepositoryMixin {
  static const _table = 'points_of_interest';
  static const _localeTable = 'points_of_interest_locale';

  Future<List<BriefPointOfInterestEntity>> getBriefPointsOfInterest({
    int page = 1,
    PointOfInterestFilterEntity? filter,
  }) async {
    var builder = laconic.table('$_table AS poi').select([
      'poi.ID',
      'poi.Name',
      if (localeEnabled) 'poil.Name AS localeName',
    ]);
    if (localeEnabled) {
      builder = builder.leftJoin(
        '$_localeTable AS poil',
        (join) => join.on('poi.ID', 'poil.ID').where('poil.locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('poi.ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefPointOfInterestEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<PointOfInterestEntity>> getPointsOfInterest() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => PointOfInterestEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countPointsOfInterest({
    PointOfInterestFilterEntity? filter,
  }) async {
    var builder = laconic.table('$_table AS poi');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<PointOfInterestEntity?> getPointOfInterest(int id) async {
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return PointOfInterestEntity.fromJson(results.first.toMap());
  }

  Future<PointOfInterestEntity> createPointOfInterest() async {
    return PointOfInterestEntity(id: await _getNextId());
  }

  Future<int> storePointOfInterest(PointOfInterestEntity entity) async {
    final id = entity.id > 0 ? entity.id : await _getNextId();
    final json = entity.toJson()..['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updatePointOfInterest(PointOfInterestEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  Future<void> destroyPointOfInterest(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyPointOfInterest(int id) async {
    final source = await getPointOfInterest(id);
    if (source == null) return;
    await storePointOfInterest(source.copyWith(id: await _getNextId()));
  }

  Future<void> savePointOfInterest(PointOfInterestEntity entity) async {
    final existing = await getPointOfInterest(entity.id);
    if (existing == null) {
      await storePointOfInterest(entity);
    } else {
      await updatePointOfInterest(entity);
    }
  }

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    PointOfInterestFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('poi.ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'poi.Name',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
