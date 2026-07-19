import 'package:foxy/entity/brief_scaling_stat_value_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/entity/scaling_stat_value_filter_entity.dart';
import 'package:foxy/entity/scaling_stat_value_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ScalingStatValueRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_scaling_stat_values';

  Future<ScalingStatValueKey> copyScalingStatValue(
    ScalingStatValueKey key,
  ) async {
    final source = await getScalingStatValue(key);
    if (source == null) {
      throw StateError('原缩放属性值不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(
      id: await _getNextId(),
      charlevel: await _getNextCharlevel(),
    );
    await storeScalingStatValue(copied);
    return ScalingStatValueKey.fromEntity(copied);
  }

  Future<int> countScalingStatValues({ScalingStatValueFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<ScalingStatValueEntity> createScalingStatValue() async {
    return ScalingStatValueEntity(
      id: await _getNextId(),
      charlevel: await _getNextCharlevel(),
    );
  }

  Future<void> destroyScalingStatValue(ScalingStatValueKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原缩放属性值不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefScalingStatValueEntity>> getBriefScalingStatValues({
    int page = 1,
    ScalingStatValueFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'Charlevel',
      'PrimaryBudget',
      'TertiaryBudget',
      'ShoulderBudget',
      'TrinketBudget',
      'WeaponBudget1H',
      'RangedBudget',
    ]);
    builder = _applyFilter(builder, filter);
    final rows = await builder
        .orderBy('Charlevel')
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefScalingStatValueEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<ScalingStatValueEntity?> getScalingStatValue(
    ScalingStatValueKey key,
  ) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : ScalingStatValueEntity.fromJson(rows.first.toMap());
  }

  Future<List<ScalingStatValueEntity>> getScalingStatValues() async {
    final rows = await laconic
        .table(_table)
        .orderBy('Charlevel')
        .orderBy('ID')
        .get();
    return rows
        .map((row) => ScalingStatValueEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeScalingStatValue(ScalingStatValueEntity value) async {
    if (value.id <= 0) {
      throw StateError('缩放属性值 ID 必须在新建表单打开时显式分配');
    }
    await _validateUniqueCharlevel(value);
    try {
      await laconic.table(_table).insert([value.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('缩放属性值 ${value.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateScalingStatValue(
    ScalingStatValueKey originalKey,
    ScalingStatValueEntity value,
  ) async {
    await _validateUniqueCharlevel(value, originalKey: originalKey);
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(value.toJson());
      if (matchedRows == 0) {
        throw StateError('原缩放属性值不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的缩放属性值 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ScalingStatValueFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.charlevel.isNotEmpty) {
      builder = builder.where('Charlevel', filter.charlevel);
    }
    return builder;
  }

  Future<int> _getNextCharlevel() async {
    final charlevel = await nextMaxPlusOne(_table, 'Charlevel');
    if (charlevel > 0x7fffffff) {
      throw StateError('ScalingStatValues Charlevel 已超出 DBC int32 范围');
    }
    return charlevel;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('ScalingStatValues ID 已超出 DBC int32 范围');
    }
    return id;
  }

  Future<void> _validateUniqueCharlevel(
    ScalingStatValueEntity value, {
    ScalingStatValueKey? originalKey,
  }) async {
    var builder = laconic.table(_table).where('Charlevel', value.charlevel);
    if (originalKey != null) {
      builder = builder.where('ID', originalKey.id, comparator: '!=');
    }
    final duplicates = await builder.count();
    if (duplicates > 0) {
      throw StateError('Charlevel ${value.charlevel} 已存在');
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, ScalingStatValueKey key) {
    return builder.where('ID', key.id);
  }
}
