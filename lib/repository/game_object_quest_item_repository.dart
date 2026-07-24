import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_quest_item_repository.g.dart';

@FoxyRepository(GameObjectQuestItemEntity)
class GameObjectQuestItemRepository
    with RepositoryMixin, _GameObjectQuestItemRepositoryMixin {
  static const _table = 'gameobject_questitem';
  static const primaryKeyColumns = {'GameObjectEntry', 'Idx'};

  Future<GameObjectQuestItemKey> copyGameObjectQuestItem(
    GameObjectQuestItemKey sourceKey,
  ) async {
    final source = await getGameObjectQuestItem(sourceKey);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final blank = await createGameObjectQuestItem(source.gameObjectEntry);
    final candidate = source.copyWith(idx: blank.idx);
    await storeGameObjectQuestItem(candidate);
    return GameObjectQuestItemKey.fromEntity(candidate);
  }

  Future<int> countGameObjectQuestItems(int gameObjectEntry) {
    return laconic
        .table(_table)
        .where('GameObjectEntry', gameObjectEntry)
        .count();
  }

  Future<GameObjectQuestItemEntity> createGameObjectQuestItem(
    int gameObjectEntry,
  ) async {
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry,
      idx: await getNextIdx(gameObjectEntry),
    );
  }

  Future<List<BriefGameObjectQuestItemEntity>> getBriefGameObjectQuestItems(
    int gameObjectEntry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS gq');
    final fields = <String>[
      'gq.GameObjectEntry',
      'gq.Idx',
      'gq.ItemId',
      'gq.VerifiedBuild',
      'it.name AS itemName',
      if (localeEnabled) 'itl.Name AS itemLocaleName',
      'it.Quality AS itemQuality',
      'didi.InventoryIcon0 AS itemIcon',
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
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestItemEntity.fromJson(e.toMap()))
        .toList();
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
}
