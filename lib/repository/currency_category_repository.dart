import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'currency_category_repository.g.dart';

@FoxyRepository(CurrencyCategoryEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class CurrencyCategoryRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _CurrencyCategoryRepositoryMixin {
  static const _table = 'foxy.dbc_currency_category';

  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyCurrencyCategory(int key) async {
    final source = await getCurrencyCategory(key);
    if (source == null) {
      throw StateError('原货币分类不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeCurrencyCategory(copied);
    return copied.id;
  }

  Future<int> countCurrencyCategories({CurrencyCategoryFilter? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<CurrencyCategoryEntity> createCurrencyCategory() async {
    return CurrencyCategoryEntity(id: await _getNextId());
  }

  Future<List<BriefCurrencyCategoryEntity>> getBriefCurrencyCategories({
    int page = 1,
    CurrencyCategoryFilter? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'Flags',
      'Name_lang_zhCN',
    ]);
    builder = _applyFilter(builder, filter);
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefCurrencyCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<CurrencyCategoryEntity>> getCurrencyCategories() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => CurrencyCategoryEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<DbcLocaleFieldValue>> getCurrencyCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveCurrencyCategoryLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CurrencyCategoryFilter? filter,
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

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('CurrencyCategory ID 已超出 DBC int32 范围');
    }
    return id;
  }
}
