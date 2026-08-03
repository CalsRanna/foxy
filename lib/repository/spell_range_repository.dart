import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/spell_range_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'spell_range_repository.g.dart';

@FoxyRepository(SpellRangeEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class SpellRangeRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _SpellRangeRepositoryMixin {
  static const _table = 'foxy.dbc_spell_range';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copySpellRange(int key) async {
    final source = await getSpellRange(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = SpellRangeEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeSpellRange(copied);
    return copied.id;
  }

  Future<int> countSpellRanges({SpellRangeFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SpellRangeEntity> createSpellRange() async {
    return SpellRangeEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefSpellRangeEntity>> getBriefSpellRanges({
    int page = 1,
    SpellRangeFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'RangeMin0',
      'RangeMax0',
      'DisplayName_lang_zhCN',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellRangeEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SpellRangeEntity>> getSpellRanges() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SpellRangeEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SpellRangeFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'DisplayName_lang_zhCN',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
