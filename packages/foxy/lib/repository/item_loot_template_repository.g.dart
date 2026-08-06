// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_loot_template_repository.dart';

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

mixin _ItemLootTemplateRepositoryMixin on RepositoryMixin {
  Future<ItemLootTemplateKey> copyItemLootTemplate(
    ItemLootTemplateKey key,
  ) async {
    final source = await getItemLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('item_loot_template record not found');
    }
    final blank = await createItemLootTemplate(source.entry);
    final copied = source.copyWith(entry: blank.entry, item: blank.item);
    await storeItemLootTemplate(copied);
    return ItemLootTemplateKey.fromEntity(copied);
  }

  Future<int> countItemLootTemplates(int entry) async {
    return laconic.table('item_loot_template').where('`Entry`', entry).count();
  }

  Future<ItemLootTemplateEntity> createItemLootTemplate(int entry) async {
    return ItemLootTemplateEntity(
      entry: entry,
      item: await nextMaxPlusOne(
        'item_loot_template',
        '`Item`',
        where: {'`Entry`': entry},
      ),
    );
  }

  Future<void> destroyItemLootTemplate(ItemLootTemplateKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('item_loot_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('item_loot_template record not found');
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

  Future<List<BriefItemLootTemplateEntity>> getBriefItemLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('item_loot_template').select([
      '`Entry`',
      '`Item`',
      '`Reference`',
      '`Chance`',
      '`QuestRequired`',
      '`GroupId`',
      '`MinCount`',
      '`MaxCount`',
    ]);
    builder = builder.where('`Entry`', entry);
    builder = builder.orderBy('`Entry`').orderBy('`Item`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefItemLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeItemLootTemplate(
    ItemLootTemplateEntity itemLootTemplate,
  ) async {
    await _beforeStore(itemLootTemplate);
    final json = prepareWriteJson(itemLootTemplate.toJson());
    try {
      await laconic.table('item_loot_template').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemLootTemplate.copyWith(
        item: await nextMaxPlusOne(
          'item_loot_template',
          '`Item`',
          where: {'`Entry`': itemLootTemplate.entry},
        ),
      );
      try {
        await laconic.table('item_loot_template').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in item_loot_template');
        }
        rethrow;
      }
    }
  }

  Future<void> updateItemLootTemplate(
    ItemLootTemplateKey originalKey,
    ItemLootTemplateEntity itemLootTemplate,
  ) async {
    await _beforeUpdate(originalKey, itemLootTemplate);
    final json = prepareWriteJson(itemLootTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('item_loot_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in item_loot_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('item_loot_template record not found');
    }
  }

  Future<void> _beforeDestroy(ItemLootTemplateKey key) async {}

  Future<void> _beforeStore(ItemLootTemplateEntity itemLootTemplate) async {}

  Future<void> _beforeUpdate(
    ItemLootTemplateKey originalKey,
    ItemLootTemplateEntity itemLootTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, ItemLootTemplateKey key) {
    var query = builder;
    query = query.where('`Entry`', key.entry);
    query = query.where('`Item`', key.item);
    return query;
  }
}
