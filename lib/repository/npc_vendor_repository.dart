import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class NpcVendorRepository with RepositoryMixin {
  static const _table = 'npc_vendor';
  static const primaryKeyColumns = {'entry', 'item', 'ExtendedCost'};

  Future<int> countNpcVendors(int entry) {
    return laconic.table(_table).where('entry', entry).count();
  }

  Future<NpcVendorEntity> createNpcVendor(int entry) async {
    final nextSlot = await nextMaxPlusOne(
      _table,
      'slot',
      where: {'entry': entry},
      firstValue: 0,
    );
    return NpcVendorEntity(entry: entry, slot: nextSlot);
  }

  Future<void> destroyNpcVendor(NpcVendorKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefNpcVendorEntity>> getBriefNpcVendors(
    int entry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS nv');
    final fields = <String>[
      'nv.entry',
      'nv.slot',
      'nv.item',
      'nv.maxcount',
      'nv.incrtime',
      'nv.ExtendedCost',
      'it.name AS itemName',
      if (localeEnabled) 'itl.Name AS itemLocaleName',
      'it.Quality AS itemQuality',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('nv.item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.where('nv.entry', entry);
    builder = builder.orderBy('nv.slot').orderBy('nv.item');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((result) => BriefNpcVendorEntity.fromJson(result.toMap()))
        .toList();
  }

  Future<NpcVendorEntity?> getNpcVendor(NpcVendorKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return NpcVendorEntity.fromJson(results.first.toMap());
  }

  Future<void> storeNpcVendor(NpcVendorEntity vendor) async {
    try {
      await laconic.table(_table).insert([vendor.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('商人物品主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateNpcVendor(
    NpcVendorKey originalKey,
    NpcVendorEntity vendor,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(vendor.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, NpcVendorKey key) {
    return builder
        .where('entry', key.entry)
        .where('item', key.item)
        .where('ExtendedCost', key.extendedCost);
  }
}
