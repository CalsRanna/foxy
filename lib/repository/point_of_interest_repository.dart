import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/point_of_interest_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'point_of_interest_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'PointOfInterestFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'name',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class PointOfInterestRepository with RepositoryMixin {
  static const _table = 'points_of_interest';
  static const _localeTable = 'points_of_interest_locale';

  Future<int> copyPointOfInterest(int key) async {
    final source = await getPointOfInterest(key);
    if (source == null) {
      throw StateError('原兴趣点不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storePointOfInterest(copied);
    return copied.id;
  }

  Future<int> countPointsOfInterest({PointOfInterestFilter? filter}) async {
    var builder = laconic.table('$_table AS poi');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<PointOfInterestEntity> createPointOfInterest() async {
    return PointOfInterestEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyPointOfInterest(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原兴趣点不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefPointOfInterestEntity>> getBriefPointsOfInterest({
    int page = 1,
    PointOfInterestFilter? filter,
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

  Future<PointOfInterestEntity?> getPointOfInterest(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PointOfInterestEntity.fromJson(results.first.toMap());
  }

  Future<List<PointOfInterestEntity>> getPointsOfInterest() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => PointOfInterestEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storePointOfInterest(PointOfInterestEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('兴趣点 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('兴趣点 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updatePointOfInterest(
    int originalKey,
    PointOfInterestEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原兴趣点不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的兴趣点 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    PointOfInterestFilter? filter,
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
