// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_repository.dart';

final class ItemTemplateFilter {
  final String entry;
  final String name;
  final String description;

  const ItemTemplateFilter({
    this.entry = '',
    this.name = '',
    this.description = '',
  });

  factory ItemTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ItemTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  ItemTemplateFilter copyWith({
    String? entry,
    String? name,
    String? description,
  }) {
    return ItemTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name, 'description': description};
  }
}

mixin _ItemTemplateRepositoryMixin on RepositoryMixin {
  Future<int> copyItemTemplate(int key) async {
    final source = await getItemTemplate(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createItemTemplate();
    final copied = source.copyWith(entry: blank.entry);
    await storeItemTemplate(copied);
    return copied.entry;
  }

  Future<int> countItemTemplates({ItemTemplateFilter? filter}) async {
    return _applyFilter(laconic.table('item_template'), filter).count();
  }

  Future<ItemTemplateEntity> createItemTemplate() async {
    return ItemTemplateEntity(
      entry: await nextMaxPlusOne('item_template', '`entry`'),
    );
  }

  Future<void> destroyItemTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('item_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemTemplateEntity?> getItemTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('item_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefItemTemplateEntity>> getBriefItemTemplates({
    int page = 1,
    ItemTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('item_template').select([
      '`entry`',
      '`name`',
      '`Quality`',
      '`subclass`',
      '`InventoryType`',
      '`ItemLevel`',
      '`RequiredLevel`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`entry`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefItemTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ItemTemplateEntity>> getItemTemplates() async {
    var builder = laconic.table('item_template').orderBy('`entry`');
    final results = await builder.get();
    return results.map((e) => ItemTemplateEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeItemTemplate(ItemTemplateEntity itemTemplate) async {
    if (itemTemplate.entry <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemTemplate);
    final json = prepareWriteJson(itemTemplate.toJson());
    try {
      await laconic.table('item_template').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateItemTemplate(
    int originalKey,
    ItemTemplateEntity itemTemplate,
  ) async {
    await _beforeUpdate(originalKey, itemTemplate);
    final json = prepareWriteJson(itemTemplate.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('item_template'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, ItemTemplateFilter? filter) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('`entry`', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`name`', filter.name);
    }
    if (filter.description.isNotEmpty) {
      builder = builder.where('`description`', filter.description);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemTemplateEntity itemTemplate) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemTemplateEntity itemTemplate,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`entry`', key);
  }
}
