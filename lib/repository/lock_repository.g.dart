// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_repository.dart';

mixin _LockRepositoryMixin on RepositoryMixin {
  Future<void> destroyLock(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_lock'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<LockEntity?> getLock(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_lock'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return LockEntity.fromJson(results.first.toMap());
  }

  Future<void> updateLock(int originalKey, LockEntity lock) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table('foxy.dbc_lock'),
        originalKey,
      ).update(lock.toJson());
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

final class LockFilter {
  final String id;

  const LockFilter({this.id = ''});

  factory LockFilter.fromJson(Map<String, dynamic> json) {
    return LockFilter(id: json['id']?.toString() ?? '');
  }

  LockFilter copyWith({String? id}) {
    return LockFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
