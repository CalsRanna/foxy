import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/liquid_type_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'liquid_type_repository.g.dart';

@FoxyRepository(LiquidTypeEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class LiquidTypeRepository with RepositoryMixin, _LiquidTypeRepositoryMixin {
  static const _table = 'foxy.dbc_liquid_type';

  Future<int> copyLiquidType(int key) async {
    final source = await getLiquidType(key);
    if (source == null) {
      throw StateError('原液体类型不存在，可能已被其他操作修改或删除');
    }
    final copied = LiquidTypeEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeLiquidType(copied);
    return copied.id;
  }

  Future<int> countLiquidTypes({LiquidTypeFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<LiquidTypeEntity> createLiquidType() async =>
      LiquidTypeEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefLiquidTypeEntity>> getBriefLiquidTypes({
    int page = 1,
    LiquidTypeFilter? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select([
        'ID',
        'Name',
        'Flags',
        'SoundBank',
        'SpellID',
      ]),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefLiquidTypeEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<LiquidTypeEntity>> getLiquidTypes() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => LiquidTypeEntity.fromJson(row.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, LiquidTypeFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name', '%${filter.name}%', comparator: 'like');
    }
    return builder;
  }
}
