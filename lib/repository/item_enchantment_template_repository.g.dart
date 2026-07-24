// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_enchantment_template_repository.dart';

mixin _ItemEnchantmentTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemEnchantmentTemplate(
    ItemEnchantmentTemplateKey key,
  ) async {
    final deletedRows = await _whereKey(
      laconic.table('item_enchantment_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemEnchantmentTemplateEntity?> getItemEnchantmentTemplate(
    ItemEnchantmentTemplateKey key,
  ) async {
    final results = await _whereKey(
      laconic.table('item_enchantment_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemEnchantmentTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemEnchantmentTemplate(
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) async {
    await _beforeStore(itemEnchantmentTemplate);
    final json = _prepareWriteJson(itemEnchantmentTemplate.toJson());
    try {
      await laconic.table('item_enchantment_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemEnchantmentTemplate(
    ItemEnchantmentTemplateKey originalKey,
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) async {
    await _beforeUpdate(originalKey, itemEnchantmentTemplate);
    final json = _prepareWriteJson(itemEnchantmentTemplate.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('item_enchantment_template'),
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

  Future<void> _beforeStore(
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    ItemEnchantmentTemplateKey originalKey,
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
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

  QueryBuilder _whereKey(QueryBuilder builder, ItemEnchantmentTemplateKey key) {
    var query = builder;
    query = query.where('entry', key.entry);
    query = query.where('ench', key.ench);
    return query;
  }
}

final class ItemEnchantmentTemplateFilter {
  final String entry;

  const ItemEnchantmentTemplateFilter({this.entry = ''});

  factory ItemEnchantmentTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ItemEnchantmentTemplateFilter(
      entry: json['entry']?.toString() ?? '',
    );
  }

  ItemEnchantmentTemplateFilter copyWith({String? entry}) {
    return ItemEnchantmentTemplateFilter(entry: entry ?? this.entry);
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry};
  }
}
