import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/entity/currency_type_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CurrencyTypeRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_currency_types';

  Future<List<CurrencyTypeEntity>> getCurrencyTypes({
    int page = 1,
    CurrencyTypeFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => CurrencyTypeEntity.fromJson(e.toMap())).toList();
  }

  Future<List<BriefCurrencyTypeEntity>> getBriefCurrencyTypes({
    int page = 1,
    CurrencyTypeFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'ItemID', 'CategoryID', 'BitIndex'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCurrencyTypeEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countCurrencyTypes({CurrencyTypeFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CurrencyTypeEntity?> getCurrencyType(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return CurrencyTypeEntity.fromJson(result.toMap());
  }

  Future<void> storeCurrencyType(CurrencyTypeEntity currencyType) async {
    var json = currencyType.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
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

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select(['MAX(ID) as max_id']).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, CurrencyTypeFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
