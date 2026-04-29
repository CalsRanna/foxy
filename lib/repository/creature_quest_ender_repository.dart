import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// creature_questender 表的数据访问层
/// 复合主键: (id, quest)
class CreatureQuestEnderRepository with RepositoryMixin {
  static const _table = 'creature_questender';

  /// 按 quest 搜索该任务下的所有任务结束者（带 creature_template + locale JOIN）
  Future<List<BriefCreatureQuestEnderEntity>> getCreatureQuestEnders(
    int questId,
  ) async {
    try {
      const fields = ['cqe.id', 'cqe.quest', 'ct.name', 'ctl.Name'];
      var builder = laconic.table('$_table AS cqe');
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'creature_template AS ct',
        (join) => join.on('cqe.id', 'ct.entry'),
      );
      builder = builder.leftJoin(
        'creature_template_locale AS ctl',
        (join) => join.on('cqe.id', 'ctl.entry').on('ctl.locale', '"zhCN"'),
      );
      builder = builder.where('cqe.quest', questId);
      final results = await builder.get();
      return results
          .map((e) => BriefCreatureQuestEnderEntity.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 按复合键查找
  Future<CreatureQuestEnderEntity?> getCreatureQuestEnder(
    Map<String, dynamic> id,
  ) async {
    try {
      var builder = laconic.table(_table);
      id.forEach((k, v) {
        builder = builder.where(k, v);
      });
      final result = await builder.first();
      return CreatureQuestEnderEntity.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 取指定 quest 下的下一个 id（MAX(id) + 1）
  Future<CreatureQuestEnderEntity> createCreatureQuestEnder(int questId) async {
    try {
      final result = await laconic.table(_table).where('quest', questId).select(
        ['MAX(id) as max_id'],
      ).first();
      final maxId = result.toMap()['max_id'] as int?;
      return CreatureQuestEnderEntity(
        quest: questId,
        id: maxId == null ? 0 : maxId + 1,
      );
    } catch (e) {
      return CreatureQuestEnderEntity(quest: questId, id: 0);
    }
  }

  Future<void> storeCreatureQuestEnder(CreatureQuestEnderEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateCreatureQuestEnder(
    Map<String, dynamic> id,
    CreatureQuestEnderEntity model,
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

  Future<void> destroyCreatureQuestEnder(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }

  Future<void> copyCreatureQuestEnder(Map<String, dynamic> id) async {
    final original = await getCreatureQuestEnder(id);
    if (original == null) return;
    final next = await createCreatureQuestEnder(original.quest);
    await storeCreatureQuestEnder(next);
  }
}
