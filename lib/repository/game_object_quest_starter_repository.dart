import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectQuestStarterRepository with RepositoryMixin {
  static const _table = 'gameobject_queststarter';

  Future<GameObjectQuestStarterEntity> createGameObjectQuestStarter(
    int questId,
  ) async {
    return GameObjectQuestStarterEntity(quest: questId);
  }

  Future<void> destroyGameObjectQuestStarter(int id, int quest) async {
    await laconic.table(_table).where('id', id).where('quest', quest).delete();
  }

  Future<List<BriefGameObjectQuestStarterEntity>>
  getBriefGameObjectQuestStarters(int questId) async {
    const fields = ['gos.id', 'gos.quest', 'got.name'];
    var builder = laconic.table('$_table AS gos');
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'gameobject_template AS got',
      (join) => join.on('gos.id', 'got.entry'),
    );
    builder = builder.where('gos.quest', questId);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestStarterEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectQuestStarterEntity?> getGameObjectQuestStarter(
    int id,
    int quest,
  ) async {
    var results = await laconic
        .table(_table)
        .where('id', id)
        .where('quest', quest)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return GameObjectQuestStarterEntity.fromJson(results.first.toMap());
  }

  Future<void> saveGameObjectQuestStarter(
    GameObjectQuestStarterEntity model,
  ) async {
    var existing = await getGameObjectQuestStarter(model.id, model.quest);
    if (existing != null) {
      await updateGameObjectQuestStarter(model.id, model.quest, model);
    } else {
      await storeGameObjectQuestStarter(model);
    }
  }

  Future<void> storeGameObjectQuestStarter(
    GameObjectQuestStarterEntity model,
  ) async {
    _validate(model.id, model.quest);
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateGameObjectQuestStarter(
    int id,
    int quest,
    GameObjectQuestStarterEntity model,
  ) async {
    _validate(model.id, model.quest);
    await laconic
        .table(_table)
        .where('id', id)
        .where('quest', quest)
        .update(model.toJson());
  }

  void _validate(int id, int quest) {
    if (id <= 0 || quest <= 0) {
      throw ArgumentError('游戏对象编号和任务编号必须大于 0');
    }
  }
}
