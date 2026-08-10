import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'scaling_stat_value_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('charlevel')
class ScalingStatValueRepository
    with RepositoryMixin, _ScalingStatValueRepositoryMixin {
  @override
  Future<int> copyScalingStatValue(int key) async {
    final source = await getScalingStatValue(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(
      id: await _getNextId(),
      charlevel: await _getNextCharlevel(),
    );
    await storeScalingStatValue(copied);
    return copied.id;
  }

  @override
  Future<ScalingStatValueEntity> createScalingStatValue() async {
    return ScalingStatValueEntity(
      id: await _getNextId(),
      charlevel: await _getNextCharlevel(),
    );
  }

  @override
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

  @override
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

  @override
  Future<void> _beforeStore(ScalingStatValueEntity scalingStatValue) =>
      _validateUniqueCharlevel(scalingStatValue);

  @override
  Future<void> _beforeUpdate(
    int originalKey,
    ScalingStatValueEntity scalingStatValue,
  ) => _validateUniqueCharlevel(scalingStatValue, originalKey: originalKey);

  Future<int> _getNextCharlevel() async {
    final charlevel = await nextMaxPlusOne(_table, 'Charlevel');
    if (charlevel > 0x7fffffff) {
      throw IdExhaustedException(
        'ScalingStatValues Charlevel exceeds DBC int32 range',
      );
    }
    return charlevel;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw IdExhaustedException(
        'ScalingStatValues ID exceeds DBC int32 range',
      );
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
      throw DuplicateKeyException(
        'Charlevel ${value.charlevel} already exists',
      );
    }
  }
}
