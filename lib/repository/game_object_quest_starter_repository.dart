import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectQuestStarterRepository with RepositoryMixin {
  static const _table = 'gameobject_queststarter';

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

  Future<GameObjectQuestStarterEntity> createGameObjectQuestStarter(
    int questId,
  ) async {
    final result = await laconic.table(_table).where('quest', questId).select([
      'MAX(id) as max_id',
    ]).first();
    final maxId = result.toMap()['max_id'] as int?;
    return GameObjectQuestStarterEntity(
      quest: questId,
      id: maxId == null ? 0 : maxId + 1,
    );
  }

  Future<void> storeGameObjectQuestStarter(
    GameObjectQuestStarterEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateGameObjectQuestStarter(
    int id,
    int quest,
    GameObjectQuestStarterEntity model,
  ) async {
    final json = model.toJson();
    json.remove('id');
    json.remove('quest');
    await laconic
        .table(_table)
        .where('id', id)
        .where('quest', quest)
        .update(json);
  }

  Future<void> destroyGameObjectQuestStarter(int id, int quest) async {
    await laconic.table(_table).where('id', id).where('quest', quest).delete();
  }

  Future<void> copyGameObjectQuestStarter(int id, int quest) async {
    final original = await getGameObjectQuestStarter(id, quest);
    if (original == null) return;
    final next = await createGameObjectQuestStarter(original.quest);
    await storeGameObjectQuestStarter(next);
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
}