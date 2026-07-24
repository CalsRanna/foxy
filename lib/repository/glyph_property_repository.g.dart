// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_repository.dart';

mixin _GlyphPropertyRepositoryMixin on RepositoryMixin {
  Future<void> destroyGlyphProperty(int key) async {
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

  Future<void> updateGlyphProperty(
    int originalKey,
    GlyphPropertyEntity glyphProperty,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_glyph_properties'),
        originalKey,
      ).update(glyphProperty.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
