import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class NpcVendorRepository with RepositoryMixin {
  static const _table = 'npc_vendor';
  static const primaryKeyColumns = {'entry', 'item', 'ExtendedCost'};

  Future<NpcVendorEntity> createNpcVendor(int entry) async {
    var nextSlot = await getNextSlot(entry);
    return NpcVendorEntity(entry: entry, slot: nextSlot);
  }

  Future<void> destroyNpcVendor(int entry, int item, int extendedCost) async {
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('item', item)
        .where('ExtendedCost', extendedCost)
        .delete();
  }

  Future<List<BriefNpcVendorEntity>> getBriefNpcVendors(int entry) async {
    var builder = laconic.table('$_table AS nv');
    final fields = <String>[
      'nv.*',
      'it.name',
      if (localeEnabled) 'itl.Name AS localeName',
      'it.Quality',
      'didi.InventoryIcon0',
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
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('nv.entry', entry);
    builder = builder.orderBy('nv.slot');
    var results = await builder.get();
    return results
        .map((e) => BriefNpcVendorEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> getNextSlot(int entry) =>
      nextMaxPlusOne(_table, 'slot', where: {'entry': entry}, firstValue: 0);

  Future<NpcVendorEntity?> getNpcVendor(
    int entry,
    int item,
    int extendedCost,
  ) async {
    var results = await laconic
        .table(_table)
        .where('entry', entry)
        .where('item', item)
        .where('ExtendedCost', extendedCost)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return NpcVendorEntity.fromJson(results.first.toMap());
  }

  Future<void> saveNpcVendor(NpcVendorEntity vendor) async {
    _validate(vendor);
    var existing = await getNpcVendor(
      vendor.entry,
      vendor.item,
      vendor.extendedCost,
    );
    if (existing != null) {
      await updateNpcVendor(
        vendor.entry,
        vendor.item,
        vendor.extendedCost,
        vendor,
      );
    } else {
      await storeNpcVendor(vendor);
    }
  }

  Future<void> storeNpcVendor(NpcVendorEntity vendor) async {
    _validate(vendor);
    await laconic.table(_table).insert([vendor.toJson()]);
  }

  Future<void> updateNpcVendor(
    int entry,
    int item,
    int extendedCost,
    NpcVendorEntity vendor,
  ) async {
    _validate(vendor);
    var json = vendor.toJson();
    json.remove('entry');
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('item', item)
        .where('ExtendedCost', extendedCost)
        .update(json);
  }

  void _validate(NpcVendorEntity vendor) {
    if (vendor.maxcount > 0 && vendor.incrtime == 0) {
      throw StateError('maxcount 大于 0 时 incrtime 必须大于 0');
    }
    if (vendor.maxcount == 0 && vendor.incrtime > 0) {
      throw StateError('maxcount 为 0 时 incrtime 也必须为 0');
    }
  }
}
