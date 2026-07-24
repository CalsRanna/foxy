import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureQuestStarterRepository with RepositoryMixin {
  static const _table = 'creature_queststarter';
  static const primaryKeyColumns = {'id', 'quest'};

  Future<int> countCreatureQuestStarters(int questId) {
    return laconic.table(_table).where('quest', questId).count();
  }

  Future<CreatureQuestStarterEntity> createCreatureQuestStarter(
    int questId,
  ) async {
    return CreatureQuestStarterEntity(quest: questId);
  }

  Future<void> destroyCreatureQuestStarter(CreatureQuestStarterKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureQuestStarterEntity>> getBriefCreatureQuestStarters(
    int questId, {
    int page = 1,
  }) async {
    final fields = <String>[
      'cqs.id',
      'cqs.quest',
      'ct.name',
      if (localeEnabled) 'ctl.Name AS localeName',
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
    builder = builder.orderBy('cqs.id');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureQuestStarterEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureQuestStarterEntity?> getCreatureQuestStarter(
    CreatureQuestStarterKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureQuestStarterEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureQuestStarter(
    CreatureQuestStarterEntity model,
  ) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物任务开始关系主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureQuestStarter(
    CreatureQuestStarterKey originalKey,
    CreatureQuestStarterEntity model,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(model.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物任务开始关系主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestStarterKey key) {
    return builder.where('id', key.id).where('quest', key.quest);
  }
}
