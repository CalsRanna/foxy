import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureQuestEnderRepository with RepositoryMixin {
  static const _table = 'creature_questender';

  Future<List<BriefCreatureQuestEnderEntity>> getBriefCreatureQuestEnders(
    int questId,
  ) async {
    final fields = <String>[
      'cqe.id',
      'cqe.quest',
      'ct.name',
      if (localeEnabled) 'ctl.Name',
    ];
    var builder = laconic.table('$_table AS cqe');
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'creature_template AS ct',
      (join) => join.on('cqe.id', 'ct.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'creature_template_locale AS ctl',
        (join) => join.on('cqe.id', 'ctl.entry').on('ctl.locale', '"zhCN"'),
      );
    }
    builder = builder.where('cqe.quest', questId);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureQuestEnderEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureQuestEnderEntity?> getCreatureQuestEnder(
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
    return CreatureQuestEnderEntity.fromJson(results.first.toMap());
  }

  Future<CreatureQuestEnderEntity> createCreatureQuestEnder(int questId) async {
    final result = await laconic.table(_table).where('quest', questId).select([
      'MAX(id) as max_id',
    ]).first();
    final maxId = result.toMap()['max_id'] as int?;
    return CreatureQuestEnderEntity(
      quest: questId,
      id: maxId == null ? 0 : maxId + 1,
    );
  }

  Future<void> storeCreatureQuestEnder(CreatureQuestEnderEntity model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateCreatureQuestEnder(
    int id,
    int quest,
    CreatureQuestEnderEntity model,
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

  Future<void> destroyCreatureQuestEnder(int id, int quest) async {
    await laconic.table(_table).where('id', id).where('quest', quest).delete();
  }

  Future<void> copyCreatureQuestEnder(int id, int quest) async {
    final original = await getCreatureQuestEnder(id, quest);
    if (original == null) return;
    final next = await createCreatureQuestEnder(original.quest);
    await storeCreatureQuestEnder(next);
  }

  Future<void> saveCreatureQuestEnder(CreatureQuestEnderEntity model) async {
    var existing = await getCreatureQuestEnder(model.id, model.quest);
    if (existing != null) {
      await updateCreatureQuestEnder(model.id, model.quest, model);
    } else {
      await storeCreatureQuestEnder(model);
    }
  }
}