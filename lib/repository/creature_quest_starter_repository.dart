import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureQuestStarterRepository with RepositoryMixin {
  static const _table = 'creature_queststarter';

  Future<List<BriefCreatureQuestStarterEntity>> getBriefCreatureQuestStarters(
    int questId,
  ) async {
    final fields = <String>[
      'cqs.id',
      'cqs.quest',
      'ct.name',
      if (localeEnabled) 'ctl.Name',
    ];
    var builder = laconic.table('$_table AS cqs');
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'creature_template AS ct',
      (join) => join.on('cqs.id', 'ct.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'creature_template_locale AS ctl',
        (join) => join.on('cqs.id', 'ctl.entry').where('ctl.locale', 'zhCN'),
      );
    }
    builder = builder.where('cqs.quest', questId);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureQuestStarterEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureQuestStarterEntity?> getCreatureQuestStarter(
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
    return CreatureQuestStarterEntity.fromJson(results.first.toMap());
  }

  Future<CreatureQuestStarterEntity> createCreatureQuestStarter(
    int questId,
  ) async {
    final result = await laconic.table(_table).where('quest', questId).select([
      'MAX(id) as max_id',
    ]).first();
    final maxId = result.toMap()['max_id'] as int?;
    return CreatureQuestStarterEntity(
      quest: questId,
      id: maxId == null ? 0 : maxId + 1,
    );
  }

  Future<void> storeCreatureQuestStarter(
    CreatureQuestStarterEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateCreatureQuestStarter(
    int id,
    int quest,
    CreatureQuestStarterEntity model,
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

  Future<void> destroyCreatureQuestStarter(int id, int quest) async {
    await laconic.table(_table).where('id', id).where('quest', quest).delete();
  }

  Future<void> copyCreatureQuestStarter(int id, int quest) async {
    final original = await getCreatureQuestStarter(id, quest);
    if (original == null) return;
    final next = await createCreatureQuestStarter(original.quest);
    await storeCreatureQuestStarter(next);
  }

  Future<void> saveCreatureQuestStarter(
    CreatureQuestStarterEntity model,
  ) async {
    var existing = await getCreatureQuestStarter(model.id, model.quest);
    if (existing != null) {
      await updateCreatureQuestStarter(model.id, model.quest, model);
    } else {
      await storeCreatureQuestStarter(model);
    }
  }
}
