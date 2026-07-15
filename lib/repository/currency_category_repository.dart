import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/entity/currency_category_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CurrencyCategoryRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
  static const _table = 'foxy.dbc_currency_category';

  @override
  String get dbcLocaleTableName => _table;

  Future<List<BriefCurrencyCategoryEntity>> getBriefCurrencyCategories({
    int page = 1,
    CurrencyCategoryFilterEntity? filter,
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

  Future<int> countCurrencyCategories({CurrencyCategoryFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<CurrencyCategoryEntity?> getCurrencyCategory(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : CurrencyCategoryEntity.fromJson(rows.first.toMap());
  }

  Future<CurrencyCategoryEntity> createCurrencyCategory() async {
    return CurrencyCategoryEntity(id: await _getNextId());
  }

  Future<int> storeCurrencyCategory(CurrencyCategoryEntity category) async {
    final id = category.id > 0 ? category.id : await _getNextId();
    final stored = category.copyWith(id: id);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateCurrencyCategory(CurrencyCategoryEntity category) async {
    final json = category.toJson()..remove('ID');
    await laconic.table(_table).where('ID', category.id).update(json);
  }

  Future<void> destroyCurrencyCategory(int id) async {
    final references = await laconic
        .table('foxy.dbc_currency_types')
        .where('CategoryID', id)
        .count();
    if (references > 0) {
      throw StateError('货币分类 $id 仍被 $references 条货币引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyCurrencyCategory(int id) async {
    final source = await getCurrencyCategory(id);
    if (source == null) return;
    await storeCurrencyCategory(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveCurrencyCategory(CurrencyCategoryEntity category) async {
    final existing = category.id == 0
        ? null
        : await getCurrencyCategory(category.id);
    if (existing == null) {
      await storeCurrencyCategory(category);
    } else {
      await updateCurrencyCategory(category);
    }
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

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('CurrencyCategory ID 已超出 DBC int32 范围');
    }
    return id;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CurrencyCategoryFilterEntity? filter,
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
