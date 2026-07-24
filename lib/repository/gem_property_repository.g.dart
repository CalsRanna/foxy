// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_property_repository.dart';

mixin _GemPropertyRepositoryMixin on RepositoryMixin {
  Future<void> destroyGemProperty(int key) async {
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

  Future<void> storeGemProperty(GemPropertyEntity gemProperty) async {
    if (gemProperty.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(gemProperty);
    final json = _prepareWriteJson(gemProperty.toJson());
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
    final json = _prepareWriteJson(gemProperty.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_gem_properties'),
        originalKey,
      ).update(json);
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

  Future<void> _beforeStore(GemPropertyEntity gemProperty) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    GemPropertyEntity gemProperty,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}

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
