// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_extended_cost_repository.dart';

final class ItemExtendedCostFilter {
  final String id;

  const ItemExtendedCostFilter({this.id = ''});

  factory ItemExtendedCostFilter.fromJson(Map<String, dynamic> json) {
    return ItemExtendedCostFilter(id: json['id']?.toString() ?? '');
  }

  ItemExtendedCostFilter copyWith({String? id}) {
    return ItemExtendedCostFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

mixin _ItemExtendedCostRepositoryMixin on RepositoryMixin {
  Future<int> copyItemExtendedCost(int key) async {
    final source = await getItemExtendedCost(key);
    if (source == null) {
      throw RecordNotFoundException(
        'foxy.dbc_item_extended_cost record not found',
      );
    }
    final blank = await createItemExtendedCost();
    final copied = source.copyWith(id: blank.id);
    await storeItemExtendedCost(copied);
    return copied.id;
  }

  Future<int> countItemExtendedCosts({ItemExtendedCostFilter? filter}) async {
    return _applyFilter(
      laconic.table('foxy.dbc_item_extended_cost'),
      filter,
    ).count();
  }

  Future<ItemExtendedCostEntity> createItemExtendedCost() async {
    return ItemExtendedCostEntity(
      id: await nextMaxPlusOne('foxy.dbc_item_extended_cost', '`ID`'),
    );
  }

  Future<void> destroyItemExtendedCost(int key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('foxy.dbc_item_extended_cost'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_extended_cost record not found',
      );
    }
  }

  Future<ItemExtendedCostEntity?> getItemExtendedCost(int key) async {
    final results = await _whereKey(
      laconic.table('foxy.dbc_item_extended_cost'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemExtendedCostEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefItemExtendedCostEntity>> getBriefItemExtendedCosts({
    int page = 1,
    ItemExtendedCostFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('foxy.dbc_item_extended_cost').select([
      '`ID`',
      '`HonorPoints`',
      '`ArenaPoints`',
      '`ArenaBracket`',
      '`ItemID0`',
      '`ItemID1`',
      '`ItemID2`',
      '`ItemID3`',
      '`ItemID4`',
      '`ItemCount0`',
      '`ItemCount1`',
      '`ItemCount2`',
      '`ItemCount3`',
      '`ItemCount4`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('`ID`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefItemExtendedCostEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ItemExtendedCostEntity>> getItemExtendedCosts() async {
    var builder = laconic.table('foxy.dbc_item_extended_cost').orderBy('`ID`');
    final results = await builder.get();
    return results
        .map((e) => ItemExtendedCostEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeItemExtendedCost(
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    if (itemExtendedCost.id <= 0) {
      throw InvalidPrimaryKeyException(
        'primary key must be assigned before store',
      );
    }
    await _beforeStore(itemExtendedCost);
    final json = prepareWriteJson(itemExtendedCost.toJson());
    try {
      await laconic.table('foxy.dbc_item_extended_cost').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = itemExtendedCost.copyWith(
        id: await nextMaxPlusOne('foxy.dbc_item_extended_cost', '`ID`'),
      );
      try {
        await laconic.table('foxy.dbc_item_extended_cost').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException(
            'duplicate key in foxy.dbc_item_extended_cost',
          );
        }
        rethrow;
      }
    }
  }

  Future<void> updateItemExtendedCost(
    int originalKey,
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    await _beforeUpdate(originalKey, itemExtendedCost);
    final json = prepareWriteJson(itemExtendedCost.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('foxy.dbc_item_extended_cost'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException(
          'duplicate key in foxy.dbc_item_extended_cost',
        );
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException(
        'foxy.dbc_item_extended_cost record not found',
      );
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemExtendedCostFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('`ID`', filter.id);
    }
    return builder;
  }

  Future<void> _beforeDestroy(int key) async {}

  Future<void> _beforeStore(ItemExtendedCostEntity itemExtendedCost) async {}

  Future<void> _beforeUpdate(
    int originalKey,
    ItemExtendedCostEntity itemExtendedCost,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('`ID`', key);
  }
}
