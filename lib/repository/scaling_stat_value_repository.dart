import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/entity/scaling_stat_value_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ScalingStatValueRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_scaling_stat_values';

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

  Future<int> countScalingStatValues({ScalingStatValueFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<ScalingStatValueEntity?> getScalingStatValue(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : ScalingStatValueEntity.fromJson(rows.first.toMap());
  }

  Future<ScalingStatValueEntity> createScalingStatValue() async {
    return ScalingStatValueEntity(
      id: await _getNextId(),
      charlevel: await _getNextCharlevel(),
    );
  }

  Future<int> storeScalingStatValue(ScalingStatValueEntity value) async {
    final id = value.id > 0 ? value.id : await _getNextId();
    final stored = value.copyWith(id: id);
    stored.validate();
    await _validateNewCharlevel(stored);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateScalingStatValue(ScalingStatValueEntity value) async {
    value.validate();
    final existing = await getScalingStatValue(value.id);
    if (existing == null) {
      throw StateError('缩放属性值 ${value.id} 不存在');
    }
    if (existing.charlevel != value.charlevel) {
      throw StateError('Charlevel 决定 DBC 物理查找顺序，不能修改既有等级');
    }
    await _validateUniqueCharlevel(value);
    final json = value.toJson()..remove('ID');
    await laconic.table(_table).where('ID', value.id).update(json);
  }

  Future<void> destroyScalingStatValue(int id) async {
    final source = await getScalingStatValue(id);
    if (source == null) return;
    final maxCharlevel = await _getMaximumCharlevel();
    if (source.charlevel != maxCharlevel) {
      throw StateError('只能删除最高 Charlevel，避免改变后续 DBC 物理查找顺序');
    }
    final references = await laconic
        .table('item_template')
        .where('ScalingStatValue', 0, comparator: '!=')
        .count();
    if (references > 0) {
      throw StateError('仍有 $references 个物品使用缩放值，不能删除等级记录');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyScalingStatValue(int id) async {
    final source = await getScalingStatValue(id);
    if (source == null) return;
    await storeScalingStatValue(
      source.copyWith(
        id: await _getNextId(),
        charlevel: await _getNextCharlevel(),
      ),
    );
  }

  Future<void> saveScalingStatValue(ScalingStatValueEntity value) async {
    final existing = value.id == 0 ? null : await getScalingStatValue(value.id);
    if (existing == null) {
      await storeScalingStatValue(value);
    } else {
      await updateScalingStatValue(value);
    }
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('ScalingStatValues ID 已超出 DBC int32 范围');
    }
    return id;
  }

  Future<int> _getNextCharlevel() async {
    final charlevel = await nextMaxPlusOne(_table, 'Charlevel');
    if (charlevel > 0x7fffffff) {
      throw StateError('ScalingStatValues Charlevel 已超出 DBC int32 范围');
    }
    return charlevel;
  }

  Future<int> _getMaximumCharlevel() async {
    return (await nextMaxPlusOne(_table, 'Charlevel')) - 1;
  }

  Future<void> _validateNewCharlevel(ScalingStatValueEntity value) async {
    final nextCharlevel = await _getNextCharlevel();
    if (value.charlevel != nextCharlevel) {
      throw StateError('新记录 Charlevel 必须是连续的下一等级 $nextCharlevel');
    }
    await _validateUniqueCharlevel(value);
  }

  Future<void> _validateUniqueCharlevel(ScalingStatValueEntity value) async {
    final duplicates = await laconic
        .table(_table)
        .where('Charlevel', value.charlevel)
        .where('ID', value.id, comparator: '!=')
        .count();
    if (duplicates > 0) {
      throw StateError('Charlevel ${value.charlevel} 已存在');
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
}
