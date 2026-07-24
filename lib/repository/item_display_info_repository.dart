import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_display_info_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'ItemDisplayInfoFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'name',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class ItemDisplayInfoRepository with RepositoryMixin {
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

  Future<void> destroyItemDisplayInfo(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原物品显示信息不存在，可能已被其他操作修改或删除');
    }
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

  Future<ItemDisplayInfoEntity?> getItemDisplayInfo(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<List<ItemDisplayInfoEntity>> getItemDisplayInfos() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeItemDisplayInfo(ItemDisplayInfoEntity info) async {
    if (info.id <= 0) {
      throw StateError('物品显示信息 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([info.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('物品显示信息 ${info.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemDisplayInfo(
    int originalKey,
    ItemDisplayInfoEntity info,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(info.toJson());
      if (matchedRows == 0) {
        throw StateError('原物品显示信息不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的物品显示信息 ID 已存在，无法保存');
      }
      rethrow;
    }
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

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
