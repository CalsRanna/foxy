import 'package:foxy/model/creature_questender.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// creature_questender 表的数据访问层
/// 复合主键: (id, quest)
class CreatureQuestenderRepository with RepositoryMixin {
  static const _table = 'creature_questender';

  /// 按 quest 搜索该任务下的所有任务结束者（带 creature_template + locale JOIN）
  Future<List<BriefCreatureQuestender>> getCreatureQuestenders(int questId) async {
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
          .map((e) => BriefCreatureQuestender.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 按复合键查找
  Future<CreatureQuestender?> getCreatureQuestender(Map<String, dynamic> id) async {
    try {
      var builder = laconic.table(_table);
      id.forEach((k, v) {
        builder = builder.where(k, v);
      });
      final result = await builder.first();
      return CreatureQuestender.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 取指定 quest 下的下一个 id（MAX(id) + 1）
  Future<CreatureQuestender> createCreatureQuestender(int questId) async {
    try {
      final result = await laconic.table(_table).where('quest', questId).select(
        ['MAX(id) as max_id'],
      ).first();
      final maxId = result.toMap()['max_id'] as int?;
      final model = CreatureQuestender();
      model.quest = questId;
      model.id = maxId == null ? 0 : maxId + 1;
      return model;
    } catch (e) {
      final model = CreatureQuestender();
      model.quest = questId;
      model.id = 0;
      return model;
    }
  }

  Future<void> storeCreatureQuestender(CreatureQuestender model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateCreatureQuestender(Map<String, dynamic> id, CreatureQuestender model) async {
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

  Future<void> destroyCreatureQuestender(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }

  Future<void> copyCreatureQuestender(Map<String, dynamic> id) async {
    final original = await getCreatureQuestender(id);
    if (original == null) return;
    final next = await createCreatureQuestender(original.quest);
    original.id = next.id;
    await storeCreatureQuestender(original);
  }
}
