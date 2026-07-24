import 'package:foxy/entity/item_visuals_entity.dart';
import 'package:foxy/entity/item_visuals_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemVisualsRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_visuals';

  Future<int> copyItemVisual(int key) async {
    final source = await getItemVisual(key);
    if (source == null) {
      throw StateError('原物品视觉不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeItemVisual(copied);
    return copied.id;
  }

  Future<int> countItemVisuals({ItemVisualsFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemVisualsEntity> createItemVisual() async {
    return ItemVisualsEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyItemVisual(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原物品视觉不存在，可能已被其他操作修改或删除');
    }
  }

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

  Future<ItemVisualsEntity?> getItemVisual(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemVisualsEntity.fromJson(results.first.toMap());
  }

  Future<List<ItemVisualsEntity>> getItemVisuals() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => ItemVisualsEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeItemVisual(ItemVisualsEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('物品视觉 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('物品视觉 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemVisual(
    int originalKey,
    ItemVisualsEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原物品视觉不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的物品视觉 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemVisualsFilterEntity? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
