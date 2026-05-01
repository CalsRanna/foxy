import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/item_set_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemSetRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_set';

  Future<List<ItemSetEntity>> getItemSets({
    int page = 1,
    ItemSetFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => ItemSetEntity.fromJson(e.toMap())).toList();
  }

  Future<List<BriefItemSetEntity>> getBriefItemSets({
    int page = 1,
    ItemSetFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'Name_lang_zhCN', 'RequiredSkill', 'RequiredSkillRank'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemSetEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countItemSets({ItemSetFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemSetEntity?> getItemSet(int id) async {
    var result = await laconic.table(_table).where('ID', id).first();
    return ItemSetEntity.fromJson(result.toMap());
  }

  Future<void> storeItemSet(ItemSetEntity itemSet) async {
    var json = itemSet.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateItemSet(ItemSetEntity itemSet) async {
    var json = itemSet.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', itemSet.id).update(json);
  }

  Future<void> destroyItemSet(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemSet(int id) async {
    var source = await getItemSet(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select(['MAX(ID) as max_id']).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, ItemSetFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name_lang_zhCN', '%${filter.name}%');
    }
    return builder;
  }
}
