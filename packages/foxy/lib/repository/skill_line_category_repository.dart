import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/skill_line_category_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'skill_line_category_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class SkillLineCategoryRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _SkillLineCategoryRepositoryMixin {
  @override
  String get dbcLocaleTableName => _table;

  @override
  Future<List<DbcLocaleFieldValue>> getSkillLineCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  @override
  Future<void> saveSkillLineCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> countSkillLineCategories({SkillLineCategoryFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<List<BriefSkillLineCategoryEntity>> getBriefSkillLineCategories({
    int page = 1,
    SkillLineCategoryFilter? filter,
  }) async {
    var builder = laconic.table(_table).select(['ID', 'Name_lang_zhCN']);
    builder = _applyFilter(builder, filter).orderBy('ID');
    final rows = await builder
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefSkillLineCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<SkillLineCategoryEntity>> getSkillLineCategories() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SkillLineCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SkillLineCategoryFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'Name_lang_zhCN',
        '%${ParseUtil.escapeLike(filter.name)}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
