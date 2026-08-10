import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'currency_type_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'it.name')
class CurrencyTypeRepository
    with RepositoryMixin, _CurrencyTypeRepositoryMixin {
  @override
  Future<int> countCurrencyTypes({CurrencyTypeFilter? filter}) {
    final joinLocale = localeEnabled;
    var builder = laconic
        .table('$_table as ct')
        .leftJoin(
          'item_template as it',
          (join) => join.on('ct.ItemID', 'it.entry'),
        );
    if (joinLocale) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    return _applyLocaleFilter(builder, filter, joinLocale: joinLocale).count();
  }

  @override
  Future<CurrencyTypeEntity> createCurrencyType() async {
    return CurrencyTypeEntity(id: await _getNextId());
  }

  @override
  Future<List<BriefCurrencyTypeEntity>> getBriefCurrencyTypes({
    int page = 1,
    CurrencyTypeFilter? filter,
  }) async {
    final joinLocale = localeEnabled;
    var builder = laconic.table('$_table as ct').select([
      'ct.ID',
      'ct.ItemID',
      'ct.CategoryID',
      'ct.BitIndex',
      'it.name as itemName',
      if (joinLocale) 'itl.Name as localeItemName',
    ]);
    builder = builder.leftJoin(
      'item_template as it',
      (join) => join.on('ct.ItemID', 'it.entry'),
    );
    if (joinLocale) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = _applyLocaleFilter(builder, filter, joinLocale: joinLocale);
    final rows = await builder
        .orderBy('ct.ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefCurrencyTypeEntity.fromJson(row.toMap()))
        .toList();
  }

  @override
  Future<List<CurrencyTypeEntity>> getCurrencyTypes() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => CurrencyTypeEntity.fromJson(row.toMap())).toList();
  }

  // Filter implementation carrying the joinLocale parameter; the generated
  // _applyFilter (exact match only) comes from the generator, while this
  // method serves hand-written list/count queries that join items.
  QueryBuilder _applyLocaleFilter(
    QueryBuilder builder,
    CurrencyTypeFilter? filter, {
    required bool joinLocale,
  }) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ct.ID', int.tryParse(filter.id) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.whereNested((query) {
        query.where(
          'it.name',
          '%${ParseUtil.escapeLike(filter.name)}%',
          comparator: 'like',
        );
        if (joinLocale) {
          query.orWhere(
            'itl.Name',
            '%${ParseUtil.escapeLike(filter.name)}%',
            comparator: 'like',
          );
        }
      });
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw IdExhaustedException('CurrencyTypes ID exceeds DBC int32 range');
    }
    return id;
  }
}
