import 'package:foxy/model/gameobject_queststarter.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// gameobject_queststarter 表的数据访问层
/// 复合主键: (id, quest)
class GameobjectQueststarterRepository with RepositoryMixin {
  static const _table = 'gameobject_queststarter';

  /// 按 quest 搜索该任务下的所有任务给予者（带 gameobject_template JOIN，无 locale）
  Future<List<BriefGameobjectQueststarter>> getGameobjectQueststarters(int questId) async {
    try {
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
          .map((e) => BriefGameobjectQueststarter.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 按复合键查找
  Future<GameobjectQueststarter?> getGameobjectQueststarter(Map<String, dynamic> id) async {
    try {
      var builder = laconic.table(_table);
      id.forEach((k, v) {
        builder = builder.where(k, v);
      });
      final result = await builder.first();
      return GameobjectQueststarter.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 取指定 quest 下的下一个 id（MAX(id) + 1）
  Future<GameobjectQueststarter> createGameobjectQueststarter(int questId) async {
    try {
      final result = await laconic.table(_table).where('quest', questId).select(
        ['MAX(id) as max_id'],
      ).first();
      final maxId = result.toMap()['max_id'] as int?;
      final model = GameobjectQueststarter();
      model.quest = questId;
      model.id = maxId == null ? 0 : maxId + 1;
      return model;
    } catch (e) {
      final model = GameobjectQueststarter();
      model.quest = questId;
      model.id = 0;
      return model;
    }
  }

  Future<void> storeGameobjectQueststarter(GameobjectQueststarter model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateGameobjectQueststarter(
    Map<String, dynamic> id,
    GameobjectQueststarter model,
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

  Future<void> destroyGameobjectQueststarter(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }

  Future<void> copyGameobjectQueststarter(Map<String, dynamic> id) async {
    final original = await getGameobjectQueststarter(id);
    if (original == null) return;
    final next = await createGameobjectQueststarter(original.quest);
    original.id = next.id;
    await storeGameobjectQueststarter(original);
  }
}
