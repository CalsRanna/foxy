import 'package:foxy/model/creature_queststarter.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// creature_queststarter 表的数据访问层
/// 复合主键: (id, quest)
class CreatureQueststarterRepository with RepositoryMixin {
  static const _table = 'creature_queststarter';

  /// 按 quest 搜索该任务下的所有任务给予者（带 creature_template + locale JOIN）
  Future<List<BriefCreatureQueststarter>> getCreatureQueststarters(int questId) async {
    try {
      const fields = ['cqs.id', 'cqs.quest', 'ct.name', 'ctl.Name'];
      var builder = laconic.table('$_table AS cqs');
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'creature_template AS ct',
        (join) => join.on('cqs.id', 'ct.entry'),
      );
      builder = builder.leftJoin(
        'creature_template_locale AS ctl',
        (join) => join.on('cqs.id', 'ctl.entry').on('ctl.locale', '"zhCN"'),
      );
      builder = builder.where('cqs.quest', questId);
      final results = await builder.get();
      return results
          .map((e) => BriefCreatureQueststarter.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 按复合键查找
  Future<CreatureQueststarter?> getCreatureQueststarter(Map<String, dynamic> id) async {
    try {
      var builder = laconic.table(_table);
      id.forEach((k, v) {
        builder = builder.where(k, v);
      });
      final result = await builder.first();
      return CreatureQueststarter.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 取指定 quest 下的下一个 id（MAX(id) + 1）
  Future<CreatureQueststarter> createCreatureQueststarter(int questId) async {
    try {
      final result = await laconic.table(_table).where('quest', questId).select(
        ['MAX(id) as max_id'],
      ).first();
      final maxId = result.toMap()['max_id'] as int?;
      return CreatureQueststarter(quest: questId, id: maxId == null ? 0 : maxId + 1);
    } catch (e) {
      return CreatureQueststarter(quest: questId, id: 0);
    }
  }

  Future<void> storeCreatureQueststarter(CreatureQueststarter model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateCreatureQueststarter(
    Map<String, dynamic> id,
    CreatureQueststarter model,
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

  Future<void> destroyCreatureQueststarter(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }

  Future<void> copyCreatureQueststarter(Map<String, dynamic> id) async {
    final original = await getCreatureQueststarter(id);
    if (original == null) return;
    final next = await createCreatureQueststarter(original.quest);
    await storeCreatureQueststarter(next);
  }
}
