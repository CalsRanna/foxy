import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'scaling_stat_value_repository.g.dart';

@FoxyRepository(ScalingStatValueEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('charlevel')
class ScalingStatValueRepository
    with RepositoryMixin, _ScalingStatValueRepositoryMixin {
  static const _table = 'foxy.dbc_scaling_stat_values';

  @override
  Future<void> _beforeStore(ScalingStatValueEntity scalingStatValue) =>
      _validateUniqueCharlevel(scalingStatValue);

  @override
  Future<void> _beforeUpdate(
    int originalKey,
    ScalingStatValueEntity scalingStatValue,
  ) => _validateUniqueCharlevel(scalingStatValue, originalKey: originalKey);

  Future<int> copyScalingStatValue(int key) async {
    final source = await getScalingStatValue(key);
    if (source == null) {
      throw StateError('原缩放属性值不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(
      id: await _getNextId(),
      charlevel: await _getNextCharlevel(),
    );
    await storeScalingStatValue(copied);
    return copied.id;
  }

  Future<int> countScalingStatValues({ScalingStatValueFilter? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<ScalingStatValueEntity> createScalingStatValue() async {
    return ScalingStatValueEntity(
      id: await _getNextId(),
      charlevel: await _getNextCharlevel(),
    );
  }

  Future<List<BriefScalingStatValueEntity>> getBriefScalingStatValues({
    int page = 1,
    ScalingStatValueFilter? filter,
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ScalingStatValueFilter? filter,
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
    int? originalKey,
  }) async {
    var builder = laconic.table(_table).where('Charlevel', value.charlevel);
    if (originalKey != null) {
      builder = builder.where('ID', originalKey, comparator: '!=');
    }
    final duplicates = await builder.count();
    if (duplicates > 0) {
      throw StateError('Charlevel ${value.charlevel} 已存在');
    }
  }
}
