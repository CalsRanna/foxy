import 'package:foxy/entity/brief_creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureQuestEnderRepository with RepositoryMixin {
  static const _table = 'creature_questender';
  static const primaryKeyColumns = {'id', 'quest'};

  Future<int> countCreatureQuestEnders(int questId) {
    return laconic.table(_table).where('quest', questId).count();
  }

  Future<CreatureQuestEnderEntity> createCreatureQuestEnder(int questId) async {
    return CreatureQuestEnderEntity(quest: questId);
  }

  Future<void> destroyCreatureQuestEnder(CreatureQuestEnderKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureQuestEnderEntity>> getBriefCreatureQuestEnders(
    int questId, {
    int page = 1,
  }) async {
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
        (join) => join.on('cqe.id', 'ctl.entry').where('ctl.locale', 'zhCN'),
      );
    }
    builder = builder.where('cqe.quest', questId);
    builder = builder.orderBy('cqe.id');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefCreatureQuestEnderEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureQuestEnderEntity?> getCreatureQuestEnder(
    CreatureQuestEnderKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureQuestEnderEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCreatureQuestEnder(CreatureQuestEnderEntity model) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物任务结束关系主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureQuestEnder(
    CreatureQuestEnderKey originalKey,
    CreatureQuestEnderEntity model,
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
        throw StateError('修改后的生物任务结束关系主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, CreatureQuestEnderKey key) {
    return builder.where('id', key.id).where('quest', key.quest);
  }
}
