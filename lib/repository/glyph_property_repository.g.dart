// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_repository.dart';

final class GlyphPropertyFilter {
  final String id;

  const GlyphPropertyFilter({this.id = ''});

  factory GlyphPropertyFilter.fromJson(Map<String, dynamic> json) {
    return GlyphPropertyFilter(id: json['id']?.toString() ?? '');
  }

  GlyphPropertyFilter copyWith({String? id}) {
    return GlyphPropertyFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

mixin _GlyphPropertyRepositoryMixin on RepositoryMixin {
  Future<int> copyGlyphProperty(int key) async {
    final source = await getGlyphProperty(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createGlyphProperty();
    final copied = source.copyWith(id: blank.id);
    await storeGlyphProperty(copied);
    return copied.id;
  }

  Future<int> countGlyphProperties({GlyphPropertyFilter? filter}) async {
    return _applyFilter(
      laconic.table('foxy.dbc_glyph_properties'),
      filter,
    ).count();
  }

  Future<GlyphPropertyEntity> createGlyphProperty() async {
    return GlyphPropertyEntity(
      id: await nextMaxPlusOne('foxy.dbc_glyph_properties', '`ID`'),
    );
  }

  Future<void> destroyGlyphProperty(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_glyph_properties'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GlyphPropertyEntity?> getGlyphProperty(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_glyph_properties'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GlyphPropertyEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGlyphPropertyEntity>> getBriefGlyphProperties({
    int page = 1,
    GlyphPropertyFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_glyph_properties').select([
      '`ID`',
      '`SpellID`',
      '`GlyphSlotFlags`',
      '`SpellIconID`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGlyphPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GlyphPropertyEntity>> getGlyphProperties() async {
    var builder = laconic.table('foxy.dbc_glyph_properties').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => GlyphPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeGlyphProperty(GlyphPropertyEntity glyphProperty) async {
    if (glyphProperty.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(glyphProperty);
    final json = prepareWriteJson(glyphProperty.toJson());
    try {
      await laconic.table('foxy.dbc_glyph_properties').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGlyphProperty(
    int originalKey,
    GlyphPropertyEntity glyphProperty,
  ) async {
    await _beforeUpdate(originalKey, glyphProperty);
    final json = prepareWriteJson(glyphProperty.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_glyph_properties'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, GlyphPropertyFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(GlyphPropertyEntity glyphProperty) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GlyphPropertyEntity glyphProperty,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
