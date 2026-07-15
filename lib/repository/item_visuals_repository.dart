import 'package:foxy/entity/item_visuals_entity.dart';
import 'package:foxy/entity/item_visuals_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemVisualsRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_visuals';

  Future<List<BriefItemVisualsEntity>> getBriefItemVisuals({
    int page = 1,
    ItemVisualsFilterEntity? filter,
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

  Future<List<ItemVisualsEntity>> getItemVisuals() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => ItemVisualsEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<int> countItemVisuals({ItemVisualsFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemVisualsEntity?> getItemVisual(int id) async {
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ItemVisualsEntity.fromJson(results.first.toMap());
  }

  Future<ItemVisualsEntity> createItemVisual() async {
    return ItemVisualsEntity(id: await _getNextId());
  }

  Future<int> storeItemVisual(ItemVisualsEntity entity) async {
    final id = entity.id > 0 ? entity.id : await _getNextId();
    final stored = entity.copyWith(id: id);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateItemVisual(ItemVisualsEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  Future<void> destroyItemVisual(int id) async {
    final references = await laconic
        .table('foxy.dbc_spell_item_enchantment')
        .where('ItemVisual', id)
        .count();
    if (references > 0) {
      throw StateError('物品视觉 $id 仍被 $references 条法术附魔引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemVisual(int id) async {
    final source = await getItemVisual(id);
    if (source == null) return;
    await storeItemVisual(source.copyWith(id: await _getNextId()));
  }

  Future<void> saveItemVisual(ItemVisualsEntity entity) async {
    final existing = entity.id == 0 ? null : await getItemVisual(entity.id);
    if (existing == null) {
      await storeItemVisual(entity);
    } else {
      await updateItemVisual(entity);
    }
  }

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemVisualsFilterEntity? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
