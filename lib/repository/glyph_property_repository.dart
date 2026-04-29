import 'package:foxy/entity/glyph_property.dart';
import 'package:foxy/entity/glyph_property_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GlyphPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_glyph_properties';

  Future<List<GlyphProperty>> getGlyphProperties({
    int page = 1,
    GlyphPropertyFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => GlyphProperty.fromJson(e.toMap())).toList();
  }

  Future<int> countGlyphProperties({GlyphPropertyFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GlyphProperty?> getGlyphProperty(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return GlyphProperty.fromJson(result.toMap());
  }

  Future<void> storeGlyphProperty(GlyphProperty glyphProperty) async {
    var json = glyphProperty.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateGlyphProperty(GlyphProperty glyphProperty) async {
    var json = glyphProperty.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', glyphProperty.id).update(json);
  }

  Future<void> destroyGlyphProperty(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyGlyphProperty(int id) async {
    var source = await getGlyphProperty(id);
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

  dynamic _applyFilter(dynamic builder, GlyphPropertyFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
