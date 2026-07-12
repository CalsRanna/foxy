import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class NpcVendorRepository with RepositoryMixin {
  static const _table = 'npc_vendor';

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

  Future<NpcVendorEntity?> getNpcVendor(int entry, int slot) async {
    var results = await laconic
        .table(_table)
        .where('entry', entry)
        .where('slot', slot)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return NpcVendorEntity.fromJson(results.first.toMap());
  }

  Future<NpcVendorEntity> createNpcVendor(int entry) async {
    var nextSlot = await getNextSlot(entry);
    return NpcVendorEntity(entry: entry, slot: nextSlot);
  }

  Future<void> storeNpcVendor(NpcVendorEntity vendor) async {
    await laconic.table(_table).insert([vendor.toJson()]);
  }

  Future<void> updateNpcVendor(
    int entry,
    int slot,
    NpcVendorEntity vendor,
  ) async {
    var json = vendor.toJson();
    json.remove('entry');
    // allow slot change in payload
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('slot', slot)
        .update(json);
  }

  Future<void> destroyNpcVendor(int entry, int slot) async {
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('slot', slot)
        .delete();
  }

  Future<void> copyNpcVendor(int entry, int slot) async {
    var source = await getNpcVendor(entry, slot);
    if (source == null) return;
    var nextSlot = await getNextSlot(entry);
    var json = source.toJson();
    json['slot'] = nextSlot;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveNpcVendor(NpcVendorEntity vendor) async {
    var existing = await getNpcVendor(vendor.entry, vendor.slot);
    if (existing != null) {
      await updateNpcVendor(vendor.entry, vendor.slot, vendor);
    } else {
      await storeNpcVendor(vendor);
    }
  }

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
