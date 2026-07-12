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
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Charlevel',
      'PrimaryBudget',
      'TertiaryBudget',
      'ShoulderBudget',
      'TrinketBudget',
      'WeaponBudget1H',
      'RangedBudget',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefScalingStatValueEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ScalingStatValueEntity>> getScalingStatValues() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ScalingStatValueEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countScalingStatValues({
    ScalingStatValueFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ScalingStatValueEntity?> getScalingStatValue(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ScalingStatValueEntity.fromJson(results.first.toMap());
  }

  Future<ScalingStatValueEntity> createScalingStatValue() async {
    return ScalingStatValueEntity(id: await _getNextId());
  }

  Future<int> storeScalingStatValue(ScalingStatValueEntity value) async {
    var json = value.toJson();
    final nextId = value.id > 0 ? value.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateScalingStatValue(ScalingStatValueEntity value) async {
    var json = value.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', value.id).update(json);
  }

  Future<void> destroyScalingStatValue(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyScalingStatValue(int id) async {
    var source = await getScalingStatValue(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveScalingStatValue(ScalingStatValueEntity value) async {
    if (value.id == 0) {
      await storeScalingStatValue(value);
      return;
    }
    var existing = await getScalingStatValue(value.id);
    if (existing != null) {
      await updateScalingStatValue(value);
    } else {
      await laconic.table(_table).insert([value.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ScalingStatValueFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.charlevel.isNotEmpty) {
      builder = builder.where('Charlevel', filter.charlevel);
    }
    return builder;
  }
}
