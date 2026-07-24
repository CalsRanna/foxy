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

  Future<void> updateGemProperty(
    int originalKey,
    GemPropertyEntity gemProperty,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_gem_properties'),
        originalKey,
      ).update(gemProperty.toJson());
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
