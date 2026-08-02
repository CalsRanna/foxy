// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_purchase_group_repository.dart';

final class ItemPurchaseGroupFilter {
  final String id;
  final String name;

  const ItemPurchaseGroupFilter({this.id = '', this.name = ''});

  factory ItemPurchaseGroupFilter.fromJson(Map<String, dynamic> json) {
    return ItemPurchaseGroupFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemPurchaseGroupFilter copyWith({String? id, String? name}) {
    return ItemPurchaseGroupFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _ItemPurchaseGroupRepositoryMixin
    on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<void> destroyItemPurchaseGroup(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_purchase_group'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_purchase_group record not found',
      );
    }
  }

  Future<ItemPurchaseGroupEntity?> getItemPurchaseGroup(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_purchase_group'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemPurchaseGroupEntity.fromJson(results.first.toMap());
  }

  Future<List<DbcLocaleFieldValue>> getItemPurchaseGroupLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemPurchaseGroupLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeItemPurchaseGroup(
    ItemPurchaseGroupEntity itemPurchaseGroup,
  ) async {
    if (itemPurchaseGroup.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemPurchaseGroup);
    final json = prepareWriteJson(itemPurchaseGroup.toJson());
    try {
      await laconic.table('foxy.dbc_item_purchase_group').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_item_purchase_group',
        );
      }
      rethrow;
    }
  }

  Future<void> updateItemPurchaseGroup(
    int originalKey,
    ItemPurchaseGroupEntity itemPurchaseGroup,
  ) async {
    await _beforeUpdate(originalKey, itemPurchaseGroup);
    final json = prepareWriteJson(itemPurchaseGroup.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_purchase_group'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_item_purchase_group',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_purchase_group record not found',
      );
    }
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemPurchaseGroupEntity itemPurchaseGroup) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemPurchaseGroupEntity itemPurchaseGroup,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
