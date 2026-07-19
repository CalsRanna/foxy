import 'package:foxy/entity/brief_game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_ender_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GameObjectQuestEnderRepository with RepositoryMixin {
  static const _table = 'gameobject_questender';
  static const primaryKeyColumns = {'id', 'quest'};

  Future<int> countGameObjectQuestEnders(int questId) {
    return laconic.table(_table).where('quest', questId).count();
  }

  Future<GameObjectQuestEnderEntity> createGameObjectQuestEnder(
    int questId,
  ) async {
    return GameObjectQuestEnderEntity(quest: questId);
  }

  Future<void> destroyGameObjectQuestEnder(GameObjectQuestEnderKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGameObjectQuestEnderEntity>> getBriefGameObjectQuestEnders(
    int questId, {
    int page = 1,
  }) async {
    final fields = <String>[
      'goe.id',
      'goe.quest',
      'got.name',
      if (localeEnabled) 'gotl.name AS Name',
    ];
    var builder = laconic.table('$_table AS goe');
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'gameobject_template AS got',
      (join) => join.on('goe.id', 'got.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'gameobject_template_locale AS gotl',
        (join) =>
            join.on('got.entry', 'gotl.entry').where('gotl.locale', 'zhCN'),
      );
    }
    builder = builder.where('goe.quest', questId);
    builder = builder.orderBy('goe.id');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestEnderEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectQuestEnderEntity?> getGameObjectQuestEnder(
    GameObjectQuestEnderKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectQuestEnderEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectQuestEnder(
    GameObjectQuestEnderEntity model,
  ) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('游戏对象任务结束关系主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectQuestEnder(
    GameObjectQuestEnderKey originalKey,
    GameObjectQuestEnderEntity model,
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
        throw StateError('修改后的游戏对象任务结束关系主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectQuestEnderKey key) {
    return builder.where('id', key.id).where('quest', key.quest);
  }
}
