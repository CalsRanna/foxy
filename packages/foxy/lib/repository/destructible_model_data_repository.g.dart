// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destructible_model_data_repository.dart';

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

mixin _DestructibleModelDataRepositoryMixin on RepositoryMixin {
  Future<void> destroyDestructibleModelData(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_destructible_model_data record not found',
      );
    }
  }

  Future<DestructibleModelDataEntity?> getDestructibleModelData(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return DestructibleModelDataEntity.fromJson(results.first.toMap());
  }

  Future<int> storeDestructibleModelData(
    DestructibleModelDataEntity destructibleModelData,
  ) async {
    if (destructibleModelData.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(destructibleModelData);
    final json = prepareWriteJson(destructibleModelData.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = destructibleModelData.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_destructible_model_data',
          );
        }
        rethrow;
      }
    }
    return destructibleModelData.id;
  }

  Future<void> updateDestructibleModelData(
    int originalKey,
    DestructibleModelDataEntity destructibleModelData,
  ) async {
    await _beforeUpdate(originalKey, destructibleModelData);
    final json = prepareWriteJson(destructibleModelData.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_destructible_model_data',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_destructible_model_data record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(
    DestructibleModelDataEntity destructibleModelData,
  ) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    DestructibleModelDataEntity destructibleModelData,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_destructible_model_data';
