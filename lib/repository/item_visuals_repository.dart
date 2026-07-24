import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/item_visuals_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_visuals_repository.g.dart';

@FoxyRepository(ItemVisualsEntity)
@FoxyFilter.text('id')
class ItemVisualsRepository with RepositoryMixin, _ItemVisualsRepositoryMixin {
  static const _table = 'foxy.dbc_item_visuals';

  Future<int> copyItemVisual(int key) async {
    final source = await getItemVisuals(key);
    if (source == null) {
      throw StateError('原物品视觉不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeItemVisuals(copied);
    return copied.id;
  }

  Future<int> countItemVisuals({ItemVisualsFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemVisualsEntity> createItemVisual() async {
    return ItemVisualsEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefItemVisualsEntity>> getBriefItemVisuals({
    int page = 1,
    ItemVisualsFilter? filter,
  }) async {
    var builder = laconic.table(_table).select(const [
      'ID',
      'Slot0',
      'Slot1',
      'Slot2',
      'Slot3',
      'Slot4',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefItemVisualsEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<ItemVisualsEntity>> getAllItemVisuals() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => ItemVisualsEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, ItemVisualsFilter? filter) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
