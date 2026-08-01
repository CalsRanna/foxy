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

mixin _ItemSetRepositoryMixin on RepositoryMixin {
  Future<int> copyItemSet(int key) async {
    final source = await getItemSet(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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

  Future<void> storeItemSet(ItemSetEntity itemSet) async {
    if (itemSet.id <= 0) {
      throw StateError('主键必须在新建时显式分配');
    }
    await _beforeStore(itemSet);
    final json = prepareWriteJson(itemSet.toJson());
    try {
      await laconic.table('foxy.dbc_item_set').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
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
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
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
