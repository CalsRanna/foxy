import 'package:foxy/entity/brief_currency_category_entity.dart';
import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/entity/currency_category_filter_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CurrencyCategoryRepository
    with RepositoryMixin, DbcLocaleRepositoryMixin {
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

  Future<int> countCurrencyCategories({CurrencyCategoryFilterEntity? filter}) {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<CurrencyCategoryEntity> createCurrencyCategory() async {
    return CurrencyCategoryEntity(id: await _getNextId());
  }

  Future<void> destroyCurrencyCategory(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原货币分类不存在，可能已被其他操作修改或删除');
    }
  }

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

  Future<CurrencyCategoryEntity?> getCurrencyCategory(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : CurrencyCategoryEntity.fromJson(rows.first.toMap());
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

  Future<void> storeCurrencyCategory(CurrencyCategoryEntity category) async {
    if (category.id <= 0) {
      throw StateError('货币分类 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([category.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('货币分类 ${category.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCurrencyCategory(
    int originalKey,
    CurrencyCategoryEntity category,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(category.toJson());
      if (matchedRows == 0) {
        throw StateError('原货币分类不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的货币分类 ID 已存在，无法保存');
      }
      rethrow;
    }
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

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('CurrencyCategory ID 已超出 DBC int32 范围');
    }
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
