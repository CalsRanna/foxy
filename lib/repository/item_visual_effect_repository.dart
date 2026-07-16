import 'package:foxy/entity/item_visual_effect_entity.dart';
import 'package:foxy/entity/item_visual_effect_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemVisualEffectRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_visual_effects';

  Future<void> copyItemVisualEffect(int id) async {
    final source = await getItemVisualEffect(id);
    if (source == null) return;
    await storeItemVisualEffect(
      source.copyWith(id: await nextMaxPlusOne(_table, 'ID')),
    );
  }

  Future<int> countItemVisualEffects({
    ItemVisualEffectFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemVisualEffectEntity> createItemVisualEffect() async {
    return ItemVisualEffectEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyItemVisualEffect(int id) async {
    final slot0 = await _countSlot('Slot0', id);
    final slot1 = await _countSlot('Slot1', id);
    final slot2 = await _countSlot('Slot2', id);
    final slot3 = await _countSlot('Slot3', id);
    final slot4 = await _countSlot('Slot4', id);
    final references = slot0 + slot1 + slot2 + slot3 + slot4;
    if (references > 0) {
      throw StateError('物品视觉效果 $id 仍被 $references 个视觉槽引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefItemVisualEffectEntity>> getBriefItemVisualEffects({
    int page = 1,
    ItemVisualEffectFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select(const ['ID', 'Model']);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefItemVisualEffectEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<ItemVisualEffectEntity?> getItemVisualEffect(int id) async {
    final results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ItemVisualEffectEntity.fromJson(results.first.toMap());
  }

  Future<List<ItemVisualEffectEntity>> getItemVisualEffects() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => ItemVisualEffectEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> saveItemVisualEffect(ItemVisualEffectEntity entity) async {
    final existing = entity.id == 0
        ? null
        : await getItemVisualEffect(entity.id);
    if (existing == null) {
      await storeItemVisualEffect(entity);
    } else {
      await updateItemVisualEffect(entity);
    }
  }

  Future<int> storeItemVisualEffect(ItemVisualEffectEntity entity) async {
    final id = entity.id > 0 ? entity.id : await nextMaxPlusOne(_table, 'ID');
    final stored = entity.copyWith(id: id);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateItemVisualEffect(ItemVisualEffectEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemVisualEffectFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.model.isNotEmpty) {
      builder = builder.where('Model', '%${filter.model}%', comparator: 'like');
    }
    return builder;
  }

  Future<int> _countSlot(String column, int id) {
    return laconic.table('foxy.dbc_item_visuals').where(column, id).count();
  }
}
