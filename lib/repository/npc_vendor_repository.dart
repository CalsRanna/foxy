import 'package:foxy/model/npc_vendor.dart';
import 'package:foxy/repository/repository_mixin.dart';

class NpcVendorRepository with RepositoryMixin {
  static const _table = 'npc_vendor';

  /// 获取指定NPC的所有商品（带物品信息）
  Future<List<NpcVendor>> getByEntry(int entry) async {
    try {
      var builder = laconic.table('$_table AS nv');
      const fields = [
        'nv.*',
        'it.name',
        'itl.Name AS localeName',
        'it.Quality',
        'didi.InventoryIcon_1',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'item_template AS it',
        (join) => join.on('nv.item', 'it.entry'),
      );
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
      );
      builder = builder.leftJoin(
        'foxy.dbc_item_display_info AS didi',
        (join) => join.on('it.displayid', 'didi.ID'),
      );
      builder = builder.where('nv.entry', entry);
      builder = builder.orderBy('nv.slot');
      var results = await builder.get();
      return results.map((e) => NpcVendor.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 查找单条记录
  Future<NpcVendor?> find(int entry, int slot) async {
    try {
      var result = await laconic
          .table(_table)
          .where('entry', entry)
          .where('slot', slot)
          .first();
      return NpcVendor.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 新增商品
  Future<void> store(NpcVendor vendor) async {
    await laconic.table(_table).insert([vendor.toJson()]);
  }

  /// 更新商品
  Future<void> update(NpcVendor vendor, {int? oldSlot}) async {
    var json = vendor.toJson();
    json.remove('entry');
    if (oldSlot == null) json.remove('slot');
    await laconic
        .table(_table)
        .where('entry', vendor.entry)
        .where('slot', oldSlot ?? vendor.slot)
        .update(json);
  }

  /// 删除商品
  Future<void> delete(int entry, int slot) async {
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('slot', slot)
        .delete();
  }

  /// 复制商品
  Future<NpcVendor> copy(int entry, int slot) async {
    // 获取最大slot
    var maxSlotResult = await laconic
        .table(_table)
        .select(['MAX(slot) AS maxSlot'])
        .where('entry', entry)
        .first();
    var maxSlot = (maxSlotResult.toMap()['maxSlot'] ?? 0) as int;

    // 获取源记录
    var source = await find(entry, slot);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newVendor = NpcVendor.fromJson(source.toJson());
    newVendor.slot = maxSlot + 1;

    await store(newVendor);
    return newVendor;
  }

  /// 获取下一个可用的slot
  Future<int> getNextSlot(int entry) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(slot) AS maxSlot'])
        .where('entry', entry)
        .first();
    var maxSlot = (maxResult.toMap()['maxSlot'] ?? -1) as int;
    return maxSlot + 1;
  }
}
