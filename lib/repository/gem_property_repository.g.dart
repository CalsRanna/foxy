// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_property_repository.dart';

final class GemPropertyFilter {
  final String id;

  const GemPropertyFilter({this.id = ''});

  factory GemPropertyFilter.fromJson(Map<String, dynamic> json) {
    return GemPropertyFilter(id: json['id']?.toString() ?? '');
  }

  GemPropertyFilter copyWith({String? id}) {
    return GemPropertyFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

mixin _GemPropertyRepositoryMixin on RepositoryMixin {
  Future<int> copyGemProperty(int key) async {
    final source = await getGemProperty(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createGemProperty();
    final copied = source.copyWith(id: blank.id);
    await storeGemProperty(copied);
    return copied.id;
  }

  Future<int> countGemProperties({GemPropertyFilter? filter}) async {
    return _applyFilter(
      laconic.table('foxy.dbc_gem_properties'),
      filter,
    ).count();
  }

  Future<GemPropertyEntity> createGemProperty() async {
    return GemPropertyEntity(
      id: await nextMaxPlusOne('foxy.dbc_gem_properties', '`ID`'),
    );
  }

  Future<void> destroyGemProperty(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_gem_properties'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<GemPropertyEntity?> getGemProperty(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_gem_properties'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return GemPropertyEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefGemPropertyEntity>> getBriefGemProperties({
    int page = 1,
    GemPropertyFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_gem_properties').select([
      '`ID`',
      '`Enchant_ID`',
      '`Maxcount_inv`',
      '`Maxcount_item`',
      '`Type`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGemPropertyEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GemPropertyEntity>> getGemProperties() async {
    var builder = laconic.table('foxy.dbc_gem_properties').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => GemPropertyEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeGemProperty(GemPropertyEntity gemProperty) async {
    if (gemProperty.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(gemProperty);
    final json = prepareWriteJson(gemProperty.toJson());
    try {
      await laconic.table('foxy.dbc_gem_properties').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateGemProperty(
    int originalKey,
    GemPropertyEntity gemProperty,
  ) async {
    await _beforeUpdate(originalKey, gemProperty);
    final json = prepareWriteJson(gemProperty.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_gem_properties'),
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

  QueryBuilder _applyFilter(QueryBuilder builder, GemPropertyFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(GemPropertyEntity gemProperty) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GemPropertyEntity gemProperty,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
