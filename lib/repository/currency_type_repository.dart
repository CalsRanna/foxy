import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'currency_type_repository.g.dart';

@FoxyRepository(CurrencyTypeEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class CurrencyTypeRepository
    with RepositoryMixin, _CurrencyTypeRepositoryMixin {
  static const _table = 'foxy.dbc_currency_types';

  Future<int> countCurrencyTypes({CurrencyTypeFilter? filter}) {
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

  Future<List<BriefCurrencyTypeEntity>> getBriefCurrencyTypes({
    int page = 1,
    CurrencyTypeFilter? filter,
  }) async {
    final joinLocale = localeEnabled;
    var builder = laconic.table('$_table AS ct').select([
      'ct.ID',
      'ct.ItemID',
      'ct.CategoryID',
      'ct.BitIndex',
      'it.name AS itemName',
      if (joinLocale) 'itl.Name AS localeItemName',
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CurrencyTypeFilter? filter, {
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
}
