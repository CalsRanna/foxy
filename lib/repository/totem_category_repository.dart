import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/totem_category_entity.dart';
import 'package:foxy/entity/totem_category_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class TotemCategoryRepository with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_totem_category';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> countTotemCategories({TotemCategoryFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<List<BriefTotemCategoryEntity>> getBriefTotemCategories({
    int page = 1,
    TotemCategoryFilterEntity? filter,
  }) async {
    var builder = _applyFilter(laconic.table(_table), filter);
    builder = builder
        .select([
          'ID',
          'Name_lang_zhCN',
          'TotemCategoryType',
          'TotemCategoryMask',
        ])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize);
    final rows = await builder.get();
    return rows
        .map((row) => BriefTotemCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<TotemCategoryEntity>> getTotemCategories() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => TotemCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getTotemCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveTotemCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    TotemCategoryFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
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
