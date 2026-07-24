// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_vendor_repository.dart';

mixin _NpcVendorRepositoryMixin on RepositoryMixin {
  Future<void> destroyNpcVendor(NpcVendorKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('npc_vendor'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<NpcVendorEntity?> getNpcVendor(NpcVendorKey key) async {
    final results = await _whereKey(
      laconic.table('npc_vendor'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return NpcVendorEntity.fromJson(results.first.toMap());
  }

  Future<void> storeNpcVendor(NpcVendorEntity npcVendor) async {
    await _beforeStore(npcVendor);
    final json = _prepareWriteJson(npcVendor.toJson());
    try {
      await laconic.table('npc_vendor').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateNpcVendor(
    NpcVendorKey originalKey,
    NpcVendorEntity npcVendor,
  ) async {
    await _beforeUpdate(originalKey, npcVendor);
    final json = _prepareWriteJson(npcVendor.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('npc_vendor'),
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

  Future<void> _beforeStore(NpcVendorEntity npcVendor) async {}

  Future<void> _beforeUpdate(
    NpcVendorKey originalKey,
    NpcVendorEntity npcVendor,
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

  QueryBuilder _whereKey(QueryBuilder builder, NpcVendorKey key) {
    var query = builder;
    query = query.where('entry', key.entry);
    query = query.where('item', key.item);
    query = query.where('ExtendedCost', key.extendedCost);
    return query;
  }
}
