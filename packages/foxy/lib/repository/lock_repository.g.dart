// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_repository.dart';

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

mixin _LockRepositoryMixin on RepositoryMixin {
  Future<void> destroyLock(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_lock'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_lock record not found');
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

  Future<void> storeLock(LockEntity lock) async {
    if (lock.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(lock);
    final json = prepareWriteJson(lock.toJson());
    try {
      await laconic.table('foxy.dbc_lock').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = lock.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_lock', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_lock').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_lock');
        }
        rethrow;
      }
    }
  }

  Future<void> updateLock(int originalKey, LockEntity lock) async {
    await _beforeUpdate(originalKey, lock);
    final json = prepareWriteJson(lock.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_lock'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_lock');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_lock record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(LockEntity lock) async {}

  Future<void> _beforeUpdate(int originalKey, LockEntity lock) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
