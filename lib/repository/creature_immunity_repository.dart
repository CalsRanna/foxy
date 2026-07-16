import 'package:foxy/entity/creature_immunity_entity.dart';
import 'package:foxy/entity/creature_immunity_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureImmunityRepository with RepositoryMixin {
  static const _table = 'creature_immunities';

  Future<void> copyCreatureImmunity(int id) async {
    final source = await getCreatureImmunity(id);
    if (source == null) return;
    final json = source.toJson();
    json['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countCreatureImmunities({
    CreatureImmunityFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureImmunityEntity> createCreatureImmunity() async {
    return CreatureImmunityEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyCreatureImmunity(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefCreatureImmunityEntity>> getBriefCreatureImmunities({
    int page = 1,
    CreatureImmunityFilterEntity? filter,
  }) async {
    final offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'SchoolMask',
      'MechanicsMask',
      'ImmuneAoE',
      'ImmuneChain',
      'Comment',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((row) => BriefCreatureImmunityEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<CreatureImmunityEntity>> getCreatureImmunities() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => CreatureImmunityEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<CreatureImmunityEntity?> getCreatureImmunity(int id) async {
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureImmunityEntity.fromJson(results.first.toMap());
  }

  Future<void> saveCreatureImmunity(CreatureImmunityEntity immunity) async {
    final existing = await getCreatureImmunity(immunity.id);
    if (existing == null) {
      await storeCreatureImmunity(immunity);
      return;
    }
    await updateCreatureImmunity(immunity);
  }

  Future<int> storeCreatureImmunity(CreatureImmunityEntity immunity) async {
    final json = immunity.toJson();
    final nextId = immunity.id != 0
        ? immunity.id
        : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCreatureImmunity(CreatureImmunityEntity immunity) async {
    final json = immunity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', immunity.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureImmunityFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.comment.isNotEmpty) {
      builder = builder.where(
        'Comment',
        '%${filter.comment}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
