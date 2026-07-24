import 'package:foxy/entity/brief_game_object_quest_starter_entity.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GameObjectQuestStarterRepository with RepositoryMixin {
  static const _table = 'gameobject_queststarter';
  static const primaryKeyColumns = {'id', 'quest'};

  Future<int> countGameObjectQuestStarters(int questId) {
    return laconic.table(_table).where('quest', questId).count();
  }

  Future<GameObjectQuestStarterEntity> createGameObjectQuestStarter(
    int questId,
  ) async {
    return GameObjectQuestStarterEntity(quest: questId);
  }

  Future<void> destroyGameObjectQuestStarter(
    GameObjectQuestStarterKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGameObjectQuestStarterEntity>>
  getBriefGameObjectQuestStarters(int questId, {int page = 1}) async {
    final fields = <String>[
      'gos.id',
      'gos.quest',
      'got.name',
      if (localeEnabled) 'gotl.name AS Name',
    ];
    var builder = laconic.table('$_table AS gos');
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'gameobject_template AS got',
      (join) => join.on('gos.id', 'got.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'gameobject_template_locale AS gotl',
        (join) =>
            join.on('got.entry', 'gotl.entry').where('gotl.locale', 'zhCN'),
      );
    }
    builder = builder.where('gos.quest', questId);
    builder = builder.orderBy('gos.id');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestStarterEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GameObjectQuestStarterEntity?> getGameObjectQuestStarter(
    GameObjectQuestStarterKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectQuestStarterEntity.fromJson(results.first.toMap());
  }

  Future<void> storeGameObjectQuestStarter(
    GameObjectQuestStarterEntity model,
  ) async {
    try {
      await laconic.table(_table).insert([model.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('游戏对象任务开始关系主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectQuestStarter(
    GameObjectQuestStarterKey originalKey,
    GameObjectQuestStarterEntity model,
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
        throw StateError('修改后的游戏对象任务开始关系主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, GameObjectQuestStarterKey key) {
    return builder.where('id', key.id).where('quest', key.quest);
  }
}
