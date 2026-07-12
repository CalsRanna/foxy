import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/entity/item_display_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemDisplayInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_display_info';

  Future<List<BriefItemDisplayInfoEntity>> getBriefItemDisplayInfos({
    int page = 1,
    ItemDisplayInfoFilterEntity? filter,
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

  Future<int> countItemDisplayInfos({
    ItemDisplayInfoFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemDisplayInfoEntity?> getItemDisplayInfo(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ItemDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<ItemDisplayInfoEntity> createItemDisplayInfo() async {
    return ItemDisplayInfoEntity(id: await _getNextId());
  }

  Future<int> storeItemDisplayInfo(ItemDisplayInfoEntity info) async {
    var json = info.toJson();
    final nextId = info.id > 0 ? info.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateItemDisplayInfo(ItemDisplayInfoEntity info) async {
    var json = info.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', info.id).update(json);
  }

  Future<void> destroyItemDisplayInfo(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemDisplayInfo(int id) async {
    var source = await getItemDisplayInfo(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveItemDisplayInfo(ItemDisplayInfoEntity info) async {
    if (info.id == 0) {
      await storeItemDisplayInfo(info);
      return;
    }
    var existing = await getItemDisplayInfo(info.id);
    if (existing != null) {
      await updateItemDisplayInfo(info);
    } else {
      await laconic.table(_table).insert([info.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemDisplayInfoFilterEntity? filter,
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
