import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_quest_item_repository.g.dart';

@FoxyRepository(linkKey: ['gameObjectEntry'])
class GameObjectQuestItemRepository
    with RepositoryMixin, _GameObjectQuestItemRepositoryMixin {
  static const primaryKeyColumns = {'GameObjectEntry', 'Idx'};

  @override
  Future<GameObjectQuestItemKey> copyGameObjectQuestItem(
    GameObjectQuestItemKey key,
  ) async {
    final source = await getGameObjectQuestItem(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final blank = await createGameObjectQuestItem(source.gameObjectEntry);
    final candidate = source.copyWith(idx: blank.idx);
    await storeGameObjectQuestItem(candidate);
    return GameObjectQuestItemKey.fromEntity(candidate);
  }

  @override
  Future<int> countGameObjectQuestItems(int gameObjectEntry) {
    return laconic
        .table(_table)
        .where('GameObjectEntry', gameObjectEntry)
        .count();
  }

  @override
  Future<GameObjectQuestItemEntity> createGameObjectQuestItem(
    int gameObjectEntry,
  ) async {
    return GameObjectQuestItemEntity(
      gameObjectEntry: gameObjectEntry,
      idx: await getNextIdx(gameObjectEntry),
    );
  }

  @override
  Future<List<BriefGameObjectQuestItemEntity>> getBriefGameObjectQuestItems(
    int gameObjectEntry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table as gq');
    final fields = <String>[
      'gq.GameObjectEntry',
      'gq.Idx',
      'gq.ItemId',
      'gq.VerifiedBuild',
      'it.name as itemName',
      if (localeEnabled) 'itl.Name as itemLocaleName',
      'it.Quality as itemQuality',
      'didi.InventoryIcon0 as itemIcon',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template as it',
      (join) => join.on('gq.ItemId', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi',
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
    throw ValidationException(
      'all 6 quest item slots of this game object are occupied',
    );
  }
}
