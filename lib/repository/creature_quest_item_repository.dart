import 'package:foxy/model/creature_questitem.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureQuestItemRepository with RepositoryMixin {
  static const _table = 'creature_questitem';

  /// 获取指定生物的所有任务物品（带物品信息）
  Future<List<CreatureQuestItem>> getByEntry(int creatureEntry) async {
    try {
      var builder = laconic.table('$_table AS cq');
      const fields = [
        'cq.*',
        'it.name',
        'itl.Name AS localeName',
        'it.Quality',
        'didi.InventoryIcon_1',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'item_template AS it',
        (join) => join.on('cq.ItemId', 'it.entry'),
      );
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('cq.ItemId', 'itl.ID').on('itl.locale', '"zhCN"'),
      );
      builder = builder.leftJoin(
        'foxy.dbc_item_display_info AS didi',
        (join) => join.on('it.displayid', 'didi.ID'),
      );
      builder = builder.where('cq.CreatureEntry', creatureEntry);
      builder = builder.orderBy('cq.Idx');
      var results = await builder.get();
      return results.map((e) => CreatureQuestItem.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 查找单条记录
  Future<CreatureQuestItem?> find(int creatureEntry, int idx) async {
    try {
      var result = await laconic
          .table(_table)
          .where('CreatureEntry', creatureEntry)
          .where('Idx', idx)
          .first();
      return CreatureQuestItem.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 新增任务物品
  Future<void> store(CreatureQuestItem questItem) async {
    await laconic.table(_table).insert([questItem.toJson()]);
  }

  /// 更新任务物品
  Future<void> update(CreatureQuestItem questItem) async {
    var json = questItem.toJson();
    json.remove('CreatureEntry');
    json.remove('Idx');
    await laconic
        .table(_table)
        .where('CreatureEntry', questItem.creatureEntry)
        .where('Idx', questItem.idx)
        .update(json);
  }

  /// 删除任务物品
  Future<void> delete(int creatureEntry, int idx) async {
    await laconic
        .table(_table)
        .where('CreatureEntry', creatureEntry)
        .where('Idx', idx)
        .delete();
  }

  /// 复制任务物品
  Future<CreatureQuestItem> copy(int creatureEntry, int idx) async {
    // 获取最大Idx
    var maxIdxResult = await laconic
        .table(_table)
        .select(['MAX(Idx) AS maxIdx'])
        .where('CreatureEntry', creatureEntry)
        .first();
    var maxIdx = (maxIdxResult.toMap()['maxIdx'] ?? 0) as int;

    // 获取源记录
    var source = await find(creatureEntry, idx);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newQuestItem = CreatureQuestItem.fromJson(source.toJson());
    newQuestItem.idx = maxIdx + 1;

    await store(newQuestItem);
    return newQuestItem;
  }

  /// 获取下一个可用的Idx
  Future<int> getNextIdx(int creatureEntry) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(Idx) AS maxIdx'])
        .where('CreatureEntry', creatureEntry)
        .first();
    var maxIdx = (maxResult.toMap()['maxIdx'] ?? 0) as int;
    return maxIdx + 1;
  }
}
