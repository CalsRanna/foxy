import 'package:foxy/model/gem_property.dart';
import 'package:foxy/model/gem_property_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GemPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_gem_properties';

  Future<List<GemProperty>> getGemProperties({
    required GemPropertyFilterEntity filter,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => GemProperty.fromJson(e.toMap())).toList();
  }

  Future<int> countGemProperties({required GemPropertyFilterEntity filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GemProperty?> getGemProperty(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return GemProperty.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeGemProperty(GemProperty gemProperty) async {
    var json = gemProperty.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateGemProperty(GemProperty gemProperty) async {
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

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, GemPropertyFilterEntity filter) {
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
