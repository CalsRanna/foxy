// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_repository.dart';

final class GlyphPropertyFilter {
  final String id;
  final String spellId;

  const GlyphPropertyFilter({this.id = '', this.spellId = ''});

  factory GlyphPropertyFilter.fromJson(Map<String, dynamic> json) {
    return GlyphPropertyFilter(
      id: json['id']?.toString() ?? '',
      spellId: json['spellId']?.toString() ?? '',
    );
  }

  GlyphPropertyFilter copyWith({String? id, String? spellId}) {
    return GlyphPropertyFilter(
      id: id ?? this.id,
      spellId: spellId ?? this.spellId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'spellId': spellId};
  }
}

mixin _GlyphPropertyRepositoryMixin on RepositoryMixin {
  String get _table => 'foxy.dbc_glyph_properties';

  Future<int> copyGlyphProperty(int key) async {
    final source = await getGlyphProperty(key);
    if (source == null) {
      throw RecordNotFoundException(
        'foxy.dbc_glyph_properties record not found',
      );
    }
    final blank = await createGlyphProperty();
    final copied = source.copyWith(id: blank.id);
    return storeGlyphProperty(copied);
  }

  Future<int> countGlyphProperties({GlyphPropertyFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<GlyphPropertyEntity> createGlyphProperty() async {
    return GlyphPropertyEntity(id: await nextMaxPlusOne(_table, '`ID`'));
  }

  Future<void> destroyGlyphProperty(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_glyph_properties record not found',
      );
    }
  }

  Future<GlyphPropertyEntity?> getGlyphProperty(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GlyphPropertyEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGlyphPropertyEntity>> getBriefGlyphProperties({
    int page = 1,
    GlyphPropertyFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
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
    var builder = laconic.table(_table).orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => GlyphPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<int> storeGlyphProperty(GlyphPropertyEntity glyphProperty) async {
    if (glyphProperty.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(glyphProperty);
    final json = prepareWriteJson(glyphProperty.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(glyphProperty.id),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = glyphProperty.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(retried.id),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_glyph_properties',
          );
        }
        rethrow;
      }
    }
    return glyphProperty.id;
  }

  Future<void> updateGlyphProperty(
    int originalKey,
    GlyphPropertyEntity glyphProperty,
  ) async {
    await _beforeUpdate(originalKey, glyphProperty);
    final values = glyphProperty.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(glyphProperty.id),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_glyph_properties',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_glyph_properties record not found',
      );
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, GlyphPropertyFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.spellId.isNotEmpty) {
      builder = builder.where('`SpellID`', filter.spellId);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(GlyphPropertyEntity glyphProperty) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GlyphPropertyEntity glyphProperty,
  ) async {}

  Map<String, Object?> activityKey(int key) => {'ID': key};

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
