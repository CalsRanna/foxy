import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// gameobject_questender 表的数据访问层
/// 复合主键: (id, quest)
class GameObjectQuestEnderRepository with RepositoryMixin {
  static const _table = 'gameobject_questender';

  Future<void> copyGameObjectQuestEnder(Map<String, dynamic> id) async {
    final original = await getGameObjectQuestEnder(id);
    if (original == null) return;
    final next = await createGameObjectQuestEnder(original.quest);
    await storeGameObjectQuestEnder(next);
  }

  /// 取指定 quest 下的下一个 id（MAX(id) + 1）
  Future<GameObjectQuestEnderEntity> createGameObjectQuestEnder(
    int questId,
  ) async {
    try {
      final result = await laconic.table(_table).where('quest', questId).select(
        ['MAX(id) as max_id'],
      ).first();
      final maxId = result.toMap()['max_id'] as int?;
      return GameObjectQuestEnderEntity(
        quest: questId,
        id: maxId == null ? 0 : maxId + 1,
      );
    } catch (e) {
      return GameObjectQuestEnderEntity(quest: questId, id: 0);
    }
  }

  Future<void> destroyGameObjectQuestEnder(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }

  /// 按复合键查找
  Future<GameObjectQuestEnderEntity?> getGameObjectQuestEnder(
    Map<String, dynamic> id,
  ) async {
    try {
      var builder = laconic.table(_table);
      id.forEach((k, v) {
        builder = builder.where(k, v);
      });
      final result = await builder.first();
      return GameObjectQuestEnderEntity.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 按 quest 搜索该任务下的所有任务结束者（带 gameobject_template JOIN，无 locale）
  Future<List<BriefGameObjectQuestEnder>> getGameObjectQuestEnders(
    int questId,
  ) async {
    try {
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
          .map((e) => BriefGameObjectQuestEnder.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> storeGameObjectQuestEnder(
    GameObjectQuestEnderEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateGameObjectQuestEnder(
    Map<String, dynamic> id,
    GameObjectQuestEnderEntity model,
  ) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    final json = model.toJson();
    for (final k in id.keys) {
      json.remove(k);
    }
    await builder.update(json);
  }
}
