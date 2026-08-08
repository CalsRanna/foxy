import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'dbc_faction_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class DbcFactionRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _DbcFactionRepositoryMixin {

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyDbcFaction(int key) async {
    final source = await getDbcFaction(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeDbcFaction(copied);
    return copied.id;
  }

  Future<int> countDbcFactions({DbcFactionFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<DbcFactionEntity> createDbcFaction() async {
    return DbcFactionEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefDbcFactionEntity>> getBriefDbcFactions({
    int page = 1,
    DbcFactionFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Name_lang_zhCN', 'Description_lang_zhCN']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefDbcFactionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<DbcFactionEntity>> getDbcFactions() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => DbcFactionEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, DbcFactionFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
