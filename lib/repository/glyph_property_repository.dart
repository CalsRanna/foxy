import 'package:foxy/model/glyph_property.dart';
import 'package:foxy/model/glyph_property_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GlyphPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_glyph_properties';

  Future<List<GlyphProperty>> search({
    required GlyphPropertyFilterEntity filter,
    required int page,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => GlyphProperty.fromJson(e.toMap())).toList();
  }

  Future<int> count({required GlyphPropertyFilterEntity filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GlyphProperty?> find(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return GlyphProperty.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(GlyphProperty glyphProperty) async {
    await laconic.table(_table).insert([glyphProperty.toJson()]);
  }

  Future<void> update(GlyphProperty glyphProperty) async {
    var json = glyphProperty.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', glyphProperty.id).update(json);
  }

  Future<void> destroy(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copy(int id) async {
    var source = await find(id);
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

  dynamic _applyFilter(dynamic builder, GlyphPropertyFilterEntity filter) {
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
