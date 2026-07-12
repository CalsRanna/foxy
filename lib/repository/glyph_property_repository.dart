import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/entity/glyph_property_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GlyphPropertyRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_glyph_properties';

  Future<List<BriefGlyphPropertyEntity>> getBriefGlyphProperties({
    int page = 1,
    GlyphPropertyFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'SpellID', 'GlyphSlotFlags', 'SpellIconID'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGlyphPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GlyphPropertyEntity>> getGlyphProperties() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => GlyphPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countGlyphProperties({GlyphPropertyFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GlyphPropertyEntity?> getGlyphProperty(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return GlyphPropertyEntity.fromJson(results.first.toMap());
  }

  Future<GlyphPropertyEntity> createGlyphProperty() async {
    return GlyphPropertyEntity(id: await _getNextId());
  }

  Future<int> storeGlyphProperty(GlyphPropertyEntity glyphProperty) async {
    var json = glyphProperty.toJson();
    final nextId = glyphProperty.id > 0 ? glyphProperty.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateGlyphProperty(GlyphPropertyEntity glyphProperty) async {
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

  Future<void> saveGlyphProperty(GlyphPropertyEntity glyphProperty) async {
    if (glyphProperty.id == 0) {
      await storeGlyphProperty(glyphProperty);
      return;
    }
    var existing = await getGlyphProperty(glyphProperty.id);
    if (existing != null) {
      await updateGlyphProperty(glyphProperty);
    } else {
      await laconic.table(_table).insert([glyphProperty.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GlyphPropertyFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
