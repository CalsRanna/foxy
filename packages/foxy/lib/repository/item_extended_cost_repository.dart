import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_extended_cost_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('id')
class ItemExtendedCostRepository
    with RepositoryMixin, _ItemExtendedCostRepositoryMixin {
  @override
  Future<int> copyItemExtendedCost(int key) async {
    final source = await getItemExtendedCost(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeItemExtendedCost(copied);
    return copied.id;
  }

  @override
  Future<int> countItemExtendedCosts({ItemExtendedCostFilter? filter}) async {
    return _applyFilter(laconic.table('$_table as iec'), filter).count();
  }

  @override
  Future<ItemExtendedCostEntity> createItemExtendedCost() async {
    return ItemExtendedCostEntity(id: await _getNextId());
  }

  @override
  Future<List<BriefItemExtendedCostEntity>> getBriefItemExtendedCosts({
    int page = 1,
    ItemExtendedCostFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as iec');
    const fields = [
      'iec.ID',
      'iec.HonorPoints',
      'iec.ArenaPoints',
      'iec.ArenaBracket',
      'iec.ItemID0',
      'iec.ItemID1',
      'iec.ItemID2',
      'iec.ItemID3',
      'iec.ItemID4',
      'iec.ItemCount0',
      'iec.ItemCount1',
      'iec.ItemCount2',
      'iec.ItemCount3',
      'iec.ItemCount4',
      // The first two item slots resolve against acore_world.item_template
      // (entry = DBC item ID); the zhCN override comes from
      // item_template_locale, scoped by locale the same way as the
      // item_template brief query. Icon and quality follow the
      // item_template list: displayid -> ItemDisplayInfo icon, Quality
      // for the name color.
      'it.Name as itemName0',
      'itl.Name as itemLocaleName0',
      'it.Quality as itemQuality0',
      'didi.InventoryIcon0 as itemIcon0',
      'it2.Name as itemName1',
      'itl2.Name as itemLocaleName1',
      'it2.Quality as itemQuality1',
      'didi2.InventoryIcon0 as itemIcon1',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'acore_world.item_template as it',
      (join) => join.on('iec.ItemID0', 'it.entry'),
    );
    builder = builder.leftJoin(
      'acore_world.item_template_locale as itl',
      (join) => join.on('iec.ItemID0', 'itl.ID').where('itl.locale', 'zhCN'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.leftJoin(
      'acore_world.item_template as it2',
      (join) => join.on('iec.ItemID1', 'it2.entry'),
    );
    builder = builder.leftJoin(
      'acore_world.item_template_locale as itl2',
      (join) => join.on('iec.ItemID1', 'itl2.ID').where('itl2.locale', 'zhCN'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi2',
      (join) => join.on('it2.displayid', 'didi2.ID'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('iec.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemExtendedCostEntity.fromJson(e.toMap()))
        .toList();
  }

  @override
  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemExtendedCostFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('iec.ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 2147483647) {
      throw IdExhaustedException('extended cost ID exceeds signed int32 range');
    }
    return id;
  }
}
