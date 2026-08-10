import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_locale_repository_mixin.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'currency_category_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class CurrencyCategoryRepository
    with
        RepositoryMixin,
        DbcLocaleRepositoryMixin,
        _CurrencyCategoryRepositoryMixin {
  @override
  String get dbcLocaleTableName => _table;

  Future<int> copyCurrencyCategory(int key) async {
    final source = await getCurrencyCategory(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CurrencyCategoryFilter? filter,
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

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw IdExhaustedException('CurrencyCategory ID exceeds DBC int32 range');
    }
    return id;
  }
}
