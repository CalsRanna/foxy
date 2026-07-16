import 'package:foxy/entity/liquid_type_entity.dart';
import 'package:foxy/entity/liquid_type_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class LiquidTypeRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_liquid_type';

  Future<void> copyLiquidType(int id) async {
    final source = await getLiquidType(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countLiquidTypes({LiquidTypeFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<LiquidTypeEntity> createLiquidType() async =>
      LiquidTypeEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyLiquidType(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefLiquidTypeEntity>> getBriefLiquidTypes({
    int page = 1,
    LiquidTypeFilterEntity? filter,
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

  Future<LiquidTypeEntity?> getLiquidType(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : LiquidTypeEntity.fromJson(rows.first.toMap());
  }

  Future<List<LiquidTypeEntity>> getLiquidTypes() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => LiquidTypeEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveLiquidType(LiquidTypeEntity entity) async {
    if (await getLiquidType(entity.id) == null) {
      await storeLiquidType(entity);
    } else {
      await updateLiquidType(entity);
    }
  }

  Future<int> storeLiquidType(LiquidTypeEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateLiquidType(LiquidTypeEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    LiquidTypeFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name', '%${filter.name}%', comparator: 'like');
    }
    return builder;
  }
}
