import 'package:foxy/entity/creature_immunity_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_immunity_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('comment')
class CreatureImmunityRepository
    with RepositoryMixin, _CreatureImmunityRepositoryMixin {
  static const _table = 'creature_immunities';

  Future<int> copyCreatureImmunity(int key) async {
    final source = await getCreatureImmunity(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = CreatureImmunityEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeCreatureImmunity(copied);
    return copied.id;
  }

  Future<int> countCreatureImmunities({CreatureImmunityFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureImmunityEntity> createCreatureImmunity() async {
    return CreatureImmunityEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefCreatureImmunityEntity>> getBriefCreatureImmunities({
    int page = 1,
    CreatureImmunityFilter? filter,
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureImmunityFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.comment.isNotEmpty) {
      builder = builder.where(
        'Comment',
        '%${escapeLike(filter.comment)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
