// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_random_suffix_repository.dart';

final class ItemRandomSuffixFilter {
  final String id;
  final String name;

  const ItemRandomSuffixFilter({this.id = '', this.name = ''});

  factory ItemRandomSuffixFilter.fromJson(Map<String, dynamic> json) {
    return ItemRandomSuffixFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemRandomSuffixFilter copyWith({String? id, String? name}) {
    return ItemRandomSuffixFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _ItemRandomSuffixRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroyItemRandomSuffix(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_random_suffix record not found',
      );
    }
  }

  Future<ItemRandomSuffixEntity?> getItemRandomSuffix(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemRandomSuffixEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getItemRandomSuffixLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemRandomSuffixLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<int> storeItemRandomSuffix(
    ItemRandomSuffixEntity itemRandomSuffix,
  ) async {
    if (itemRandomSuffix.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemRandomSuffix);
    final json = prepareWriteJson(itemRandomSuffix.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemRandomSuffix.copyWith(
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
            'duplicate key in foxy.dbc_item_random_suffix',
          );
        }
        rethrow;
      }
    }
    return itemRandomSuffix.id;
  }

  Future<void> updateItemRandomSuffix(
    int originalKey,
    ItemRandomSuffixEntity itemRandomSuffix,
  ) async {
    await _beforeUpdate(originalKey, itemRandomSuffix);
    final json = prepareWriteJson(itemRandomSuffix.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_item_random_suffix',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_random_suffix record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemRandomSuffixEntity itemRandomSuffix) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemRandomSuffixEntity itemRandomSuffix,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}

const _table = 'foxy.dbc_item_random_suffix';
