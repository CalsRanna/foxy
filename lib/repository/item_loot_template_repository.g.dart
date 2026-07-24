// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_loot_template_repository.dart';

mixin _ItemLootTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemLootTemplate(ItemLootTemplateKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('item_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemLootTemplateEntity?> getItemLootTemplate(
    ItemLootTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('item_loot_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemLootTemplate(
    ItemLootTemplateEntity itemLootTemplate,
  ) async {
    await _beforeStore(itemLootTemplate);
    final json = _prepareWriteJson(itemLootTemplate.toJson());
    try {
      await laconic.table('item_loot_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemLootTemplate(
    ItemLootTemplateKey originalKey,
    ItemLootTemplateEntity itemLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, itemLootTemplate);
    final json = _prepareWriteJson(itemLootTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('item_loot_template'),
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

  Future<void> _beforeStore(ItemLootTemplateEntity itemLootTemplate) async {}

  Future<void> _beforeUpdate(
    ItemLootTemplateKey originalKey,
    ItemLootTemplateEntity itemLootTemplate,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, ItemLootTemplateKey key) {
    var query = builder;
    query = query.where('Entry', key.entry);
    query = query.where('Item', key.item);
    return query;
  }
}

final class ItemLootTemplateFilter {
  final String entry;
  final String name;

  const ItemLootTemplateFilter({this.entry = '', this.name = ''});

  factory ItemLootTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ItemLootTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemLootTemplateFilter copyWith({String? entry, String? name}) {
    return ItemLootTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}
