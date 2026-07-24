import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_display_info_repository.g.dart';

@FoxyRepository(ItemDisplayInfoEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('name')
class ItemDisplayInfoRepository
    with RepositoryMixin, _ItemDisplayInfoRepositoryMixin {
  static const _table = 'foxy.dbc_item_display_info';

  Future<int> copyItemDisplayInfo(int key) async {
    final source = await getItemDisplayInfo(key);
    if (source == null) {
      throw StateError('原物品显示信息不存在，可能已被其他操作修改或删除');
    }
    final copied = ItemDisplayInfoEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeItemDisplayInfo(copied);
    return copied.id;
  }

  Future<int> countItemDisplayInfos({ItemDisplayInfoFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemDisplayInfoEntity> createItemDisplayInfo() async {
    return ItemDisplayInfoEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefItemDisplayInfoEntity>> getBriefItemDisplayInfos({
    int page = 1,
    ItemDisplayInfoFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'ModelName0', 'InventoryIcon0']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ItemDisplayInfoEntity>> getItemDisplayInfos() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemDisplayInfoFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where(
        'ModelName0',
        '%${filter.name}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
