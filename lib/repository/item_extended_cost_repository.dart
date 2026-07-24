import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_extended_cost_repository.g.dart';

@FoxyRepository(ItemExtendedCostEntity)
@FoxyFilter.text('id')
class ItemExtendedCostRepository
    with RepositoryMixin, _ItemExtendedCostRepositoryMixin {
  static const _table = 'foxy.dbc_item_extended_cost';

  Future<int> copyItemExtendedCost(int key) async {
    final source = await getItemExtendedCost(key);
    if (source == null) {
      throw StateError('原扩展价格不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeItemExtendedCost(copied);
    return copied.id;
  }

  Future<int> countItemExtendedCosts({ItemExtendedCostFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemExtendedCostEntity> createItemExtendedCost() async {
    return ItemExtendedCostEntity(id: await _getNextId());
  }

  Future<List<BriefItemExtendedCostEntity>> getBriefItemExtendedCosts({
    int page = 1,
    ItemExtendedCostFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'HonorPoints',
      'ArenaPoints',
      'ArenaBracket',
      'ItemID0',
      'ItemID1',
      'ItemID2',
      'ItemID3',
      'ItemID4',
      'ItemCount0',
      'ItemCount1',
      'ItemCount2',
      'ItemCount3',
      'ItemCount4',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemExtendedCostEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ItemExtendedCostEntity>> getItemExtendedCosts() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemExtendedCostEntity.fromJson(e.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemExtendedCostFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 2147483647) {
      throw StateError('扩展价格编号已超出 signed int32 范围');
    }
    return id;
  }
}
