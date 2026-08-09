// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_template_repository.dart';

final class ItemTemplateFilter {
  final String entry;
  final String name;

  const ItemTemplateFilter({this.entry = '', this.name = ''});

  factory ItemTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ItemTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemTemplateFilter copyWith({String? entry, String? name}) {
    return ItemTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name};
  }
}

mixin _ItemTemplateRepositoryMixin on RepositoryMixin {
  Future<int> copyItemTemplate(int key) async {
    final source = await getItemTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('item_template record not found');
    }
    final blank = await createItemTemplate();
    final copied = source.copyWith(entry: blank.entry);
    await storeItemTemplate(copied);
    return copied.entry;
  }

  Future<int> countItemTemplates({ItemTemplateFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<ItemTemplateEntity> createItemTemplate() async {
    return ItemTemplateEntity(entry: await nextMaxPlusOne(_table, '`entry`'));
  }

  Future<void> destroyItemTemplate(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('item_template record not found');
    }
  }

  Future<ItemTemplateEntity?> getItemTemplate(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefItemTemplateEntity>> getBriefItemTemplates({
    int page = 1,
    ItemTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
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
    var builder = laconic.table(_table).orderBy('`entry`');
    final results = await builder.get();
    return results.map((e) => ItemTemplateEntity.fromJson(e.toMap())).toList();
  }

  Future<int> storeItemTemplate(ItemTemplateEntity itemTemplate) async {
    if (itemTemplate.entry <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemTemplate);
    final json = prepareWriteJson(itemTemplate.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemTemplate.copyWith(
        entry: await nextMaxPlusOne(_table, '`entry`'),
      );
      try {
        await laconic.table(_table).insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return retried.entry;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in item_template');
        }
        rethrow;
      }
    }
    return itemTemplate.entry;
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
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in item_template');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('item_template record not found');
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

const _table = 'item_template';
