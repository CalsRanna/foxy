import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/entity/gem_property_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GemPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_gem_properties';

  Future<List<BriefGemPropertyEntity>> getBriefGemProperties({
    int page = 1,
    GemPropertyFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'Enchant_ID',
      'Maxcount_inv',
      'Maxcount_item',
      'Type',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGemPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GemPropertyEntity>> getGemProperties() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => GemPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countGemProperties({GemPropertyFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GemPropertyEntity?> getGemProperty(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return GemPropertyEntity.fromJson(results.first.toMap());
  }

  Future<GemPropertyEntity> createGemProperty() async {
    return const GemPropertyEntity();
  }

  Future<int> storeGemProperty(GemPropertyEntity gemProperty) async {
    var json = gemProperty.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateGemProperty(GemPropertyEntity gemProperty) async {
    var json = gemProperty.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', gemProperty.id).update(json);
  }

  Future<void> destroyGemProperty(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyGemProperty(int id) async {
    var source = await getGemProperty(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveGemProperty(GemPropertyEntity gemProperty) async {
    if (gemProperty.id == 0) {
      await storeGemProperty(gemProperty);
      return;
    }
    var existing = await getGemProperty(gemProperty.id);
    if (existing != null) {
      await updateGemProperty(gemProperty);
    } else {
      await laconic.table(_table).insert([gemProperty.toJson()]);
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
    GemPropertyFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
