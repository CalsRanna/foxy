// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_enchantment_template_repository.dart';

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

mixin _ItemEnchantmentTemplateRepositoryMixin on RepositoryMixin {
  String get _table => 'item_enchantment_template';

  Future<void> destroyItemEnchantmentTemplate(
    ItemEnchantmentTemplateKey key,
  ) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'item_enchantment_template record not found',
      );
    }
  }

  Future<ItemEnchantmentTemplateEntity?> getItemEnchantmentTemplate(
    ItemEnchantmentTemplateKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemEnchantmentTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> storeItemEnchantmentTemplate(
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) async {
    await _beforeStore(itemEnchantmentTemplate);
    final json = prepareWriteJson(itemEnchantmentTemplate.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      throw DuplicateKeyException('duplicate key in item_enchantment_template');
    }
  }

  Future<void> updateItemEnchantmentTemplate(
    ItemEnchantmentTemplateKey originalKey,
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) async {
    await _beforeUpdate(originalKey, itemEnchantmentTemplate);
    final json = prepareWriteJson(itemEnchantmentTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in item_enchantment_template',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'item_enchantment_template record not found',
      );
    }
  }

  Future<void> _beforeDestroy(ItemEnchantmentTemplateKey key) async {}

  Future<void> _beforeStore(
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) async {}

  Future<void> _beforeUpdate(
    ItemEnchantmentTemplateKey originalKey,
    ItemEnchantmentTemplateEntity itemEnchantmentTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, ItemEnchantmentTemplateKey key) {
    var query = builder;
    query = query.where('`entry`', key.entry);
    query = query.where('`ench`', key.ench);
    return query;
  }
}
