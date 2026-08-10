import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/skill_line_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'skill_line_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'DisplayName_lang_zhCN')
class SkillLineRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin, _SkillLineRepositoryMixin {
  @override
  String get dbcLocaleTableName => _table;

  @override
  Future<List<DbcLocaleFieldValue>> getSkillLineLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  @override
  Future<void> saveSkillLineLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  @override
  Future<int> copySkillLine(int key) async {
    final source = await getSkillLine(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = SkillLineEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeSkillLine(copied);
    return copied.id;
  }

  @override
  Future<int> countSkillLines({SkillLineFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  @override
  Future<SkillLineEntity> createSkillLine() async =>
      SkillLineEntity(id: await nextMaxPlusOne(_table, 'ID'));

  @override
  Future<List<BriefSkillLineEntity>> getBriefSkillLines({
    int page = 1,
    SkillLineFilter? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'CategoryID',
      'DisplayName_lang_zhCN as displayNameZhCN',
    ]);
    builder = _applyFilter(builder, filter).orderBy('ID');
    final rows = await builder
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefSkillLineEntity.fromJson(row.toMap()))
        .toList();
  }

  @override
  Future<List<SkillLineEntity>> getSkillLines() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => SkillLineEntity.fromJson(row.toMap())).toList();
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, SkillLineFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'DisplayName_lang_zhCN',
        '%${ParseUtil.escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
