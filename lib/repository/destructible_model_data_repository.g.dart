// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destructible_model_data_repository.dart';

mixin _DestructibleModelDataRepositoryMixin on RepositoryMixin {
  Future<void> destroyDestructibleModelData(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_destructible_model_data'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<DestructibleModelDataEntity?> getDestructibleModelData(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_destructible_model_data'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return DestructibleModelDataEntity.fromJson(results.first.toMap());
  }

  Future<void> updateDestructibleModelData(
    int originalKey,
    DestructibleModelDataEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_destructible_model_data'),
        originalKey,
      ).update(entity.toJson());
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

final class DestructibleModelDataFilter {
  final String id;

  const DestructibleModelDataFilter({this.id = ''});

  factory DestructibleModelDataFilter.fromJson(Map<String, dynamic> json) {
    return DestructibleModelDataFilter(id: json['id']?.toString() ?? '');
  }

  DestructibleModelDataFilter copyWith({String? id}) {
    return DestructibleModelDataFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
