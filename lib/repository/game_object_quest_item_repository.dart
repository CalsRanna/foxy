import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectQuestItemRepository with RepositoryMixin {
  static const _table = 'gameobject_questitem';

  Future<void> copyGameObjectQuestItem(int gameObjectEntry, int idx) async {
    var source = await getGameObjectQuestItem(gameObjectEntry, idx);
    if (source == null) return;
    var nextIdx = await getNextIdx(gameObjectEntry);
    var json = source.toJson();
    json['Idx'] = nextIdx;
    await laconic.table(_table).insert([json]);
  }

  Future<GameObjectQuestItemEntity> createGameObjectQuestItem(
    int gameObjectEntry,
  ) async {
    var nextIdx = await getNextIdx(gameObjectEntry);
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry,
      idx: nextIdx,
    );
  }

  Future<void> destroyGameObjectQuestItem(int gameObjectEntry, int idx) async {
    await laconic
        .table(_table)
        .where('GameObjectEntry', gameObjectEntry)
        .where('Idx', idx)
        .delete();
  }

  Future<List<BriefGameObjectQuestItemEntity>> getBriefGameObjectQuestItems(
    int gameObjectEntry,
  ) async {
    var builder = laconic.table('$_table AS gq');
    final fields = <String>[
      'gq.*',
      'it.name',
      if (localeEnabled) 'itl.Name AS localeName',
      'it.Quality',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('gq.ItemId', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('gq.GameObjectEntry', gameObjectEntry);
    builder = builder.orderBy('gq.Idx');
    var results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestItemEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectQuestItemEntity?> getGameObjectQuestItem(
    int gameObjectEntry,
    int idx,
  ) async {
    var results = await laconic
        .table(_table)
        .where('GameObjectEntry', gameObjectEntry)
        .where('Idx', idx)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return GameObjectQuestItemEntity.fromJson(results.first.toMap());
  }

  Future<int> getNextIdx(int gameObjectEntry) async {
    final rows = await laconic
        .table(_table)
        .select(['Idx'])
        .where('GameObjectEntry', gameObjectEntry)
        .orderBy('Idx')
        .get();
    final occupied = rows.map((row) => row.toMap()['Idx'] as int).toSet();
    for (var idx = 0; idx < 6; idx++) {
      if (!occupied.contains(idx)) return idx;
    }
    throw StateError('该游戏对象的 6 个任务物品槽位已全部占用');
  }

  Future<void> saveGameObjectQuestItem(
    GameObjectQuestItemEntity questItem,
  ) async {
    var existing = await getGameObjectQuestItem(
      questItem.gameObjectEntry,
      questItem.idx,
    );
    if (existing != null) {
      await updateGameObjectQuestItem(questItem);
    } else {
      await storeGameObjectQuestItem(questItem);
    }
  }

  Future<void> storeGameObjectQuestItem(
    GameObjectQuestItemEntity questItem,
  ) async {
    await laconic.table(_table).insert([questItem.toJson()]);
  }

  Future<void> updateGameObjectQuestItem(
    GameObjectQuestItemEntity questItem,
  ) async {
    var json = questItem.toJson();
    json.remove('GameObjectEntry');
    json.remove('Idx');
    await laconic
        .table(_table)
        .where('GameObjectEntry', questItem.gameObjectEntry)
        .where('Idx', questItem.idx)
        .update(json);
  }
}
