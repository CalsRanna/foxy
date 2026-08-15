// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'npc_vendor_repository.dart';

mixin _NpcVendorRepositoryMixin on RepositoryMixin {
  String get _table => 'npc_vendor';

  Future<NpcVendorKey> copyNpcVendor(NpcVendorKey key) async {
    final source = await getNpcVendor(key);
    if (source == null) {
      throw RecordNotFoundException('npc_vendor record not found');
    }
    final blank = await createNpcVendor(source.entry);
    final copied = source.copyWith(
      entry: blank.entry,
      item: blank.item,
      extendedCost: blank.extendedCost,
    );
    await storeNpcVendor(copied);
    return NpcVendorKey.fromEntity(copied);
  }

  Future<int> countNpcVendors(int entry) async {
    return laconic.table(_table).where('`entry`', entry).count();
  }

  Future<NpcVendorEntity> createNpcVendor(int entry) async {
    return NpcVendorEntity(
      entry: entry,
      item: await nextMaxPlusOne(_table, '`item`', where: {'`entry`': entry}),
      extendedCost: await nextMaxPlusOne(
        _table,
        '`ExtendedCost`',
        where: {'`entry`': entry},
      ),
    );
  }

  Future<void> destroyNpcVendor(NpcVendorKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('npc_vendor record not found');
    }
  }

  Future<NpcVendorEntity?> getNpcVendor(NpcVendorKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return NpcVendorEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefNpcVendorEntity>> getBriefNpcVendors(
    int entry, {
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`entry`',
      '`slot`',
      '`item`',
      '`maxcount`',
      '`incrtime`',
      '`ExtendedCost`',
    ]);
    builder = builder.where('`entry`', entry);
    builder = builder
        .orderBy('`entry`')
        .orderBy('`item`')
        .orderBy('`ExtendedCost`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefNpcVendorEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeNpcVendor(NpcVendorEntity npcVendor) async {
    await _beforeStore(npcVendor);
    final json = prepareWriteJson(npcVendor.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      throw DuplicateKeyException('duplicate key in npc_vendor');
    }
  }

  Future<void> updateNpcVendor(
    NpcVendorKey originalKey,
    NpcVendorEntity npcVendor,
  ) async {
    await _beforeUpdate(originalKey, npcVendor);
    final json = prepareWriteJson(npcVendor.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in npc_vendor');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('npc_vendor record not found');
    }
  }

  Future<void> _beforeDestroy(NpcVendorKey key) async {}

  Future<void> _beforeStore(NpcVendorEntity npcVendor) async {}

  Future<void> _beforeUpdate(
    NpcVendorKey originalKey,
    NpcVendorEntity npcVendor,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, NpcVendorKey key) {
    var query = builder;
    query = query.where('`entry`', key.entry);
    query = query.where('`item`', key.item);
    query = query.where('`ExtendedCost`', key.extendedCost);
    return query;
  }
}
