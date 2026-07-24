import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/dbc_faction_template_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'dbc_faction_template_repository.g.dart';

@FoxyRepository(DbcFactionTemplateEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('faction')
@FoxyFilter.text('name')
class DbcFactionTemplateRepository
    with RepositoryMixin, _DbcFactionTemplateRepositoryMixin {
  static const _table = 'foxy.dbc_faction_template';
  static const _factionTable = 'foxy.dbc_faction';

  Future<int> copyDbcFactionTemplate(int key) async {
    final source = await getDbcFactionTemplate(key);
    if (source == null) {
      throw StateError('原阵营模板不存在，可能已被其他操作修改或删除');
    }
    final copied = DbcFactionTemplateEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeDbcFactionTemplate(copied);
    return copied.id;
  }

  Future<int> countDbcFactionTemplates({
    DbcFactionTemplateFilter? filter,
  }) async {
    var builder = laconic.table('$_table AS dft');
    if (filter != null && filter.name.isNotEmpty) {
      builder = _joinFaction(builder);
    }
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<DbcFactionTemplateEntity> createDbcFactionTemplate() async {
    return DbcFactionTemplateEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefDbcFactionTemplateEntity>> getBriefDbcFactionTemplates({
    int page = 1,
    DbcFactionTemplateFilter? filter,
  }) async {
    final offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS dft');
    builder = builder.select([
      'dft.ID',
      'dft.Faction',
      'dft.Flags',
      'dft.FactionGroup',
      'dft.FriendGroup',
      'dft.EnemyGroup',
      'df.Name_lang_zhCN AS factionNameZhCN',
      'df.Name_lang_enUS AS factionNameEnUS',
    ]);
    builder = _joinFaction(builder);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('dft.ID');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((row) => BriefDbcFactionTemplateEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<DbcFactionTemplateEntity>> getDbcFactionTemplates() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => DbcFactionTemplateEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeDbcFactionTemplate(
    DbcFactionTemplateEntity factionTemplate,
  ) async {
    if (factionTemplate.id <= 0) {
      throw StateError('阵营模板 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([factionTemplate.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('阵营模板 ${factionTemplate.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    DbcFactionTemplateFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('dft.ID', filter.id);
    }
    if (filter.faction.isNotEmpty) {
      builder = builder.where('dft.Faction', filter.faction);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.whereAny(
        ['df.Name_lang_zhCN', 'df.Name_lang_enUS'],
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _joinFaction(QueryBuilder builder) {
    return builder.leftJoin(
      '$_factionTable AS df',
      (join) => join.on('dft.Faction', 'df.ID'),
    );
  }
}
