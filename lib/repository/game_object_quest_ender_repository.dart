import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectQuestEnderRepository with RepositoryMixin {
  static const _table = 'gameobject_questender';

  Future<List<BriefGameObjectQuestEnderEntity>> getBriefGameObjectQuestEnders(
    int questId,
  ) async {
    const fields = ['goe.id', 'goe.quest', 'got.name'];
    var builder = laconic.table('$_table AS goe');
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'gameobject_template AS got',
      (join) => join.on('goe.id', 'got.entry'),
    );
    builder = builder.where('goe.quest', questId);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestEnderEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectQuestEnderEntity?> getGameObjectQuestEnder(
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
    return GameObjectQuestEnderEntity.fromJson(results.first.toMap());
  }

  Future<GameObjectQuestEnderEntity> createGameObjectQuestEnder(
    int questId,
  ) async {
    final result = await laconic.table(_table).where('quest', questId).select([
      'MAX(id) as max_id',
    ]).first();
    final maxId = result.toMap()['max_id'] as int?;
    return GameObjectQuestEnderEntity(
      quest: questId,
      id: maxId == null ? 0 : maxId + 1,
    );
  }

  Future<void> storeGameObjectQuestEnder(
    GameObjectQuestEnderEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateGameObjectQuestEnder(
    int id,
    int quest,
    GameObjectQuestEnderEntity model,
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

  Future<void> destroyGameObjectQuestEnder(int id, int quest) async {
    await laconic.table(_table).where('id', id).where('quest', quest).delete();
  }

  Future<void> copyGameObjectQuestEnder(int id, int quest) async {
    final original = await getGameObjectQuestEnder(id, quest);
    if (original == null) return;
    final next = await createGameObjectQuestEnder(original.quest);
    await storeGameObjectQuestEnder(next);
  }

  Future<void> saveGameObjectQuestEnder(
    GameObjectQuestEnderEntity model,
  ) async {
    var existing = await getGameObjectQuestEnder(model.id, model.quest);
    if (existing != null) {
      await updateGameObjectQuestEnder(model.id, model.quest, model);
    } else {
      await storeGameObjectQuestEnder(model);
    }
  }
}
