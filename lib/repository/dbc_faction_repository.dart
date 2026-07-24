import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'dbc_faction_repository.g.dart';

@FoxyRepository(DbcFactionEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class DbcFactionRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _DbcFactionRepositoryMixin {
  static const _table = 'foxy.dbc_faction';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyDbcFaction(int key) async {
    final source = await getDbcFaction(key);
    if (source == null) {
      throw StateError('原阵营不存在，可能已被其他操作修改或删除');
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

  Future<List<DbcLocaleFieldValue>> getDbcFactionLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<List<DbcFactionEntity>> getDbcFactions() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => DbcFactionEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveDbcFactionLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  QueryBuilder _applyFilter(QueryBuilder builder, DbcFactionFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
