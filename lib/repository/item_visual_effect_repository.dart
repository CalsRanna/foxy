import 'package:foxy/entity/item_visual_effect_entity.dart';
import 'package:foxy/entity/item_visual_effect_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemVisualEffectRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_visual_effects';

  Future<int> copyItemVisualEffect(int key) async {
    final source = await getItemVisualEffect(key);
    if (source == null) {
      throw StateError('原物品视觉效果不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeItemVisualEffect(copied);
    return copied.id;
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

  Future<void> destroyItemVisualEffect(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原物品视觉效果不存在，可能已被其他操作修改或删除');
    }
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

  Future<ItemVisualEffectEntity?> getItemVisualEffect(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemVisualEffectEntity.fromJson(results.first.toMap());
  }

  Future<List<ItemVisualEffectEntity>> getItemVisualEffects() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => ItemVisualEffectEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeItemVisualEffect(ItemVisualEffectEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('物品视觉效果 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('物品视觉效果 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemVisualEffect(
    int originalKey,
    ItemVisualEffectEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原物品视觉效果不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的物品视觉效果 ID 已存在，无法保存');
      }
      rethrow;
    }
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
