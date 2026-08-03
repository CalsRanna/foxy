// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_set_repository.dart';

final class ItemSetFilter {
  final String id;
  final String name;

  const ItemSetFilter({this.id = '', this.name = ''});

  factory ItemSetFilter.fromJson(Map<String, dynamic> json) {
    return ItemSetFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  ItemSetFilter copyWith({String? id, String? name}) {
    return ItemSetFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

mixin _ItemSetRepositoryMixin on RepositoryMixin, DbcLocaleRepositoryMixin {
  Future<int> copyItemSet(int key) async {
    final source = await getItemSet(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_item_set record not found');
    }
    final blank = await createItemSet();
    final copied = source.copyWith(id: blank.id);
    await storeItemSet(copied);
    return copied.id;
  }

  Future<int> countItemSets({ItemSetFilter? filter}) async {
    return _applyFilter(laconic.table('foxy.dbc_item_set'), filter).count();
  }

  Future<ItemSetEntity> createItemSet() async {
    return ItemSetEntity(id: await nextMaxPlusOne('foxy.dbc_item_set', '`ID`'));
  }

  Future<void> destroyItemSet(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_set'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_item_set record not found');
    }
  }

  Future<ItemSetEntity?> getItemSet(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_set'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemSetEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefItemSetEntity>> getBriefItemSets({
    int page = 1,
    ItemSetFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_item_set').select([
      '`ID`',
      '`Name_lang_zhCN`',
      '`RequiredSkill`',
      '`RequiredSkillRank`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results.map((e) => BriefItemSetEntity.fromJson(e.toMap())).toList();
  }

  Future<List<ItemSetEntity>> getItemSets() async {
    var builder = laconic.table('foxy.dbc_item_set').orderBy('`ID`');
    final results = await builder.get();
    return results.map((e) => ItemSetEntity.fromJson(e.toMap())).toList();
  }

  Future<List<DbcLocaleFieldValue>> getItemSetLocales(
    int id,
    DbcLocaleFieldDefinition field,
  ) => loadDbcLocaleField(id, field);

  Future<void> saveItemSetLocales(
    int id,
    DbcLocaleFieldDefinition field,
    List<DbcLocaleFieldValue> locales,
  ) => storeDbcLocaleField(id, field, locales);

  Future<void> storeItemSet(ItemSetEntity itemSet) async {
    if (itemSet.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemSet);
    final json = prepareWriteJson(itemSet.toJson());
    try {
      await laconic.table('foxy.dbc_item_set').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemSet.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_item_set', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_item_set').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_item_set');
        }
        rethrow;
      }
    }
  }

  Future<void> updateItemSet(int originalKey, ItemSetEntity itemSet) async {
    await _beforeUpdate(originalKey, itemSet);
    final json = prepareWriteJson(itemSet.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_set'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in foxy.dbc_item_set');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_item_set record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, ItemSetFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('`Name_lang_zhCN`', filter.name);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemSetEntity itemSet) async {}

  Future<void> _beforeUpdate(int originalKey, ItemSetEntity itemSet) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
