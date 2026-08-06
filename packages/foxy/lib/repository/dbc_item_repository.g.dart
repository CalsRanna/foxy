// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_item_repository.dart';

final class DbcItemFilter {
  final String id;
  final bool handEquippableOnly;

  const DbcItemFilter({this.id = '', this.handEquippableOnly = false});

  factory DbcItemFilter.fromJson(Map<String, dynamic> json) {
    return DbcItemFilter(
      id: json['id']?.toString() ?? '',
      handEquippableOnly: json['handEquippableOnly'] as bool? ?? false,
    );
  }

  DbcItemFilter copyWith({String? id, bool? handEquippableOnly}) {
    return DbcItemFilter(
      id: id ?? this.id,
      handEquippableOnly: handEquippableOnly ?? this.handEquippableOnly,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'handEquippableOnly': handEquippableOnly};
  }
}

mixin _DbcItemRepositoryMixin on RepositoryMixin {
  Future<void> destroyDbcItem(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_item record not found');
    }
  }

  Future<DbcItemEntity?> getDbcItem(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return DbcItemEntity.fromJson(results.first.toMap());
  }

  Future<int> storeDbcItem(DbcItemEntity dbcItem) async {
    if (dbcItem.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(dbcItem);
    final json = prepareWriteJson(dbcItem.toJson());
    try {
      await laconic.table('foxy.dbc_item').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = dbcItem.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_item', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_item').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_item');
        }
        rethrow;
      }
    }
    return dbcItem.id;
  }

  Future<void> updateDbcItem(int originalKey, DbcItemEntity dbcItem) async {
    await _beforeUpdate(originalKey, dbcItem);
    final json = prepareWriteJson(dbcItem.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_item');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_item record not found');
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(DbcItemEntity dbcItem) async {}

  Future<void> _beforeUpdate(int originalKey, DbcItemEntity dbcItem) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
