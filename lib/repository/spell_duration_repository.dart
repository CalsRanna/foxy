import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_duration_repository.g.dart';

@FoxyRepository(SpellDurationEntity)
@FoxyFilter.text('id')
class SpellDurationRepository
    with RepositoryMixin, _SpellDurationRepositoryMixin {
  static const _table = 'foxy.dbc_spell_duration';

  Future<int> copySpellDuration(int key) async {
    final source = await getSpellDuration(key);
    if (source == null) {
      throw StateError('原法术持续时间不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeSpellDuration(copied);
    return copied.id;
  }

  Future<int> countSpellDurations({SpellDurationFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellDurationEntity> createSpellDuration() async {
    return SpellDurationEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefSpellDurationEntity>> getBriefSpellDurations({
    int page = 1,
    SpellDurationFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'Duration',
      'DurationPerLevel',
      'MaxDuration',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellDurationEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellDurationEntity>> getSpellDurations() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellDurationEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SpellDurationFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
