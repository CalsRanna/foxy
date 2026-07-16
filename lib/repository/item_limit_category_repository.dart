import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/item_limit_category_entity.dart';
import 'package:foxy/entity/item_limit_category_filter_entity.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemLimitCategoryRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_item_limit_category';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> countItemLimitCategories({
    ItemLimitCategoryFilterEntity? filter,
  }) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<List<BriefItemLimitCategoryEntity>> getBriefItemLimitCategories({
    int page = 1,
    ItemLimitCategoryFilterEntity? filter,
  }) async {
    var builder = _applyFilter(laconic.table(_table), filter);
    builder = builder
        .select(['ID', 'Name_lang_zhCN', 'Quantity', 'Flags'])
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize);
    final rows = await builder.get();
    return rows
        .map((row) => BriefItemLimitCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<ItemLimitCategoryEntity>> getItemLimitCategories() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => ItemLimitCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getItemLimitCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemLimitCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemLimitCategoryFilterEntity? filter,
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
