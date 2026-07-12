import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/entity/currency_type_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CurrencyTypeRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_currency_types';

  Future<List<BriefCurrencyTypeEntity>> getBriefCurrencyTypes({
    int page = 1,
    CurrencyTypeFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS ct');
    final fields = <String>[
      'ct.ID',
      'ct.ItemID',
      'ct.CategoryID',
      'ct.BitIndex',
      'it.name',
      if (localeEnabled) 'itl.Name as localeName',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('ct.ItemID', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID'),
      );
    }
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ct.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCurrencyTypeEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CurrencyTypeEntity>> getCurrencyTypes() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => CurrencyTypeEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countCurrencyTypes({CurrencyTypeFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CurrencyTypeEntity?> getCurrencyType(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return CurrencyTypeEntity.fromJson(results.first.toMap());
  }

  Future<CurrencyTypeEntity> createCurrencyType() async {
    return const CurrencyTypeEntity();
  }

  Future<int> storeCurrencyType(CurrencyTypeEntity currencyType) async {
    var json = currencyType.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateCurrencyType(CurrencyTypeEntity currencyType) async {
    var json = currencyType.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', currencyType.id).update(json);
  }

  Future<void> destroyCurrencyType(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyCurrencyType(int id) async {
    var source = await getCurrencyType(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCurrencyType(CurrencyTypeEntity currencyType) async {
    if (currencyType.id == 0) {
      await storeCurrencyType(currencyType);
      return;
    }
    var existing = await getCurrencyType(currencyType.id);
    if (existing != null) {
      await updateCurrencyType(currencyType);
    } else {
      await laconic.table(_table).insert([currencyType.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CurrencyTypeFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
