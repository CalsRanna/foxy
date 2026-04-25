import 'package:foxy/model/game_object_questitem.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectQuestItemRepository with RepositoryMixin {
  static const _table = 'gameobject_questitem';

  Future<List<GameObjectQuestItem>> getByEntry(int gameObjectEntry) async {
    try {
      var builder = laconic.table('$_table AS gq');
      const fields = [
        'gq.*',
        'it.name',
        'itl.Name AS localeName',
        'it.Quality',
        'didi.InventoryIcon_1',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'item_template AS it',
        (join) => join.on('gq.ItemId', 'it.entry'),
      );
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
      );
      builder = builder.leftJoin(
        'foxy.dbc_item_display_info AS didi',
        (join) => join.on('it.displayid', 'didi.ID'),
      );
      builder = builder.where('gq.GameObjectEntry', gameObjectEntry);
      builder = builder.orderBy('gq.Idx');
      var results = await builder.get();
      return results
          .map((e) => GameObjectQuestItem.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<GameObjectQuestItem?> find(int gameObjectEntry, int idx) async {
    try {
      var result = await laconic
          .table(_table)
          .where('GameObjectEntry', gameObjectEntry)
          .where('Idx', idx)
          .first();
      return GameObjectQuestItem.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(GameObjectQuestItem questItem) async {
    await laconic.table(_table).insert([questItem.toJson()]);
  }

  Future<void> update(GameObjectQuestItem questItem) async {
    var json = questItem.toJson();
    json.remove('GameObjectEntry');
    json.remove('Idx');
    await laconic
        .table(_table)
        .where('GameObjectEntry', questItem.gameObjectEntry)
        .where('Idx', questItem.idx)
        .update(json);
  }

  Future<void> delete(int gameObjectEntry, int idx) async {
    await laconic
        .table(_table)
        .where('GameObjectEntry', gameObjectEntry)
        .where('Idx', idx)
        .delete();
  }

  Future<GameObjectQuestItem> copy(int gameObjectEntry, int idx) async {
    var maxIdxResult = await laconic
        .table(_table)
        .select(['MAX(Idx) AS maxIdx'])
        .where('GameObjectEntry', gameObjectEntry)
        .first();
    var maxIdx = (maxIdxResult.toMap()['maxIdx'] ?? 0) as int;
    var source = await find(gameObjectEntry, idx);
    if (source == null) throw Exception('源记录不存在');
    var newQuestItem = GameObjectQuestItem.fromJson(source.toJson());
    newQuestItem.idx = maxIdx + 1;
    await store(newQuestItem);
    return newQuestItem;
  }

  Future<int> getNextIdx(int gameObjectEntry) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(Idx) AS maxIdx'])
        .where('GameObjectEntry', gameObjectEntry)
        .first();
    var maxIdx = (maxResult.toMap()['maxIdx'] ?? 0) as int;
    return maxIdx + 1;
  }
}
