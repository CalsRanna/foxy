// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_display_info_repository.dart';

final class ItemDisplayInfoFilter {
  final String id;
  final String name;

  const ItemDisplayInfoFilter({this.id = '', this.name = ''});

  factory ItemDisplayInfoFilter.fromJson(Map<String, dynamic> json) {
    return ItemDisplayInfoFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemDisplayInfoFilter copyWith({String? id, String? name}) {
    return ItemDisplayInfoFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _ItemDisplayInfoRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemDisplayInfo(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_display_info'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_display_info record not found',
      );
    }
  }

  Future<ItemDisplayInfoEntity?> getItemDisplayInfo(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_display_info'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemDisplayInfo(
    ItemDisplayInfoEntity itemDisplayInfo,
  ) async {
    if (itemDisplayInfo.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemDisplayInfo);
    final json = prepareWriteJson(itemDisplayInfo.toJson());
    try {
      await laconic.table('foxy.dbc_item_display_info').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemDisplayInfo.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_item_display_info', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_item_display_info').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_item_display_info',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateItemDisplayInfo(
    int originalKey,
    ItemDisplayInfoEntity itemDisplayInfo,
  ) async {
    await _beforeUpdate(originalKey, itemDisplayInfo);
    final json = prepareWriteJson(itemDisplayInfo.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_display_info'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_item_display_info',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_display_info record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemDisplayInfoEntity itemDisplayInfo) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemDisplayInfoEntity itemDisplayInfo,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
