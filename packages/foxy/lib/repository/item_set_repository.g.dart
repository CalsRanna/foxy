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
  String get _table => 'foxy.dbc_item_set';

  Future<int> copyItemSet(int key) async {
    final source = await getItemSet(key);
    if (source == null) {
      throw RecordNotFoundException('foxy.dbc_item_set record not found');
    }
    final blank = await createItemSet();
    final copied = source.copyWith(id: blank.id);
    return storeItemSet(copied);
  }

  Future<int> countItemSets({ItemSetFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<ItemSetEntity> createItemSet() async {
    return ItemSetEntity(id: await nextMaxPlusOne(_table, '`ID`'));
  }

  Future<void> destroyItemSet(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await trackActivityWrite(
      _table,
      beforeKey: activityKey(key),
      write: () => _whereKey(laconic.table(_table), key).delete(),
    );
    if (deletedRows == 0) {
      throw RecordNotFoundException('foxy.dbc_item_set record not found');
    }
  }

  Future<ItemSetEntity?> getItemSet(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemSetEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefItemSetEntity>> getBriefItemSets({
    int page = 1,
    ItemSetFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
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
    var builder = laconic.table(_table).orderBy('`ID`');
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

  Future<int> storeItemSet(ItemSetEntity itemSet) async {
    if (itemSet.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemSet);
    final json = prepareWriteJson(itemSet.toJson());
    try {
      await trackActivityWrite(
        _table,
        afterKey: activityKey(itemSet.id),
        write: () => laconic.table(_table).insert([json]),
      );
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemSet.copyWith(
        id: await nextMaxPlusOne(_table, '`ID`'),
      );
      try {
        await trackActivityWrite(
          _table,
          afterKey: activityKey(retried.id),
          write: () => laconic.table(_table).insert([
            prepareWriteJson(retried.toJson()),
          ]),
        );
        return retried.id;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in foxy.dbc_item_set');
        }
        rethrow;
      }
    }
    return itemSet.id;
  }

  Future<void> updateItemSet(int originalKey, ItemSetEntity itemSet) async {
    await _beforeUpdate(originalKey, itemSet);
    final values = itemSet.toJson();
    final json = prepareWriteJson(values);
    final int matchedRows;
    try {
      matchedRows = await trackActivityWrite(
        _table,
        beforeKey: activityKey(originalKey),
        afterKey: activityKey(itemSet.id),
        columns: values.keys,
        write: () => _whereKey(laconic.table(_table), originalKey).update(json),
      );
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

  Map<String, Object?> activityKey(int key) => {'ID': key};

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
