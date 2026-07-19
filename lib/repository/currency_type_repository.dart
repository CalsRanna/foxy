import 'package:foxy/entity/brief_currency_type_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/entity/currency_type_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CurrencyTypeRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_currency_types';

  Future<int> countCurrencyTypes({CurrencyTypeFilterEntity? filter}) {
    final joinLocale = localeEnabled;
    var builder = laconic
        .table('$_table AS ct')
        .leftJoin(
          'item_template AS it',
          (join) => join.on('ct.ItemID', 'it.entry'),
        );
    if (joinLocale) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    return _applyFilter(builder, filter, joinLocale: joinLocale).count();
  }

  Future<CurrencyTypeEntity> createCurrencyType() async {
    return CurrencyTypeEntity(id: await _getNextId());
  }

  Future<void> destroyCurrencyType(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原货币不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCurrencyTypeEntity>> getBriefCurrencyTypes({
    int page = 1,
    CurrencyTypeFilterEntity? filter,
  }) async {
    final joinLocale = localeEnabled;
    var builder = laconic.table('$_table AS ct').select([
      'ct.ID',
      'ct.ItemID',
      'ct.CategoryID',
      'ct.BitIndex',
      'it.name',
      if (joinLocale) 'itl.Name AS localeName',
    ]);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('ct.ItemID', 'it.entry'),
    );
    if (joinLocale) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter, joinLocale: joinLocale);
    final rows = await builder
        .orderBy('ct.ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefCurrencyTypeEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<CurrencyTypeEntity?> getCurrencyType(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : CurrencyTypeEntity.fromJson(rows.first.toMap());
  }

  Future<List<CurrencyTypeEntity>> getCurrencyTypes() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => CurrencyTypeEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeCurrencyType(CurrencyTypeEntity currencyType) async {
    if (currencyType.id <= 0) {
      throw StateError('货币 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([currencyType.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('货币 ID、物品或位索引已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCurrencyType(
    int originalKey,
    CurrencyTypeEntity currencyType,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(currencyType.toJson());
      if (matchedRows == 0) {
        throw StateError('原货币不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的货币 ID、物品或位索引已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CurrencyTypeFilterEntity? filter, {
    required bool joinLocale,
  }) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ct.ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.whereNested((query) {
        query.where('it.name', '%${filter.name}%', comparator: 'like');
        if (joinLocale) {
          query.orWhere('itl.Name', '%${filter.name}%', comparator: 'like');
        }
      });
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('CurrencyTypes ID 已超出 DBC int32 范围');
    }
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
