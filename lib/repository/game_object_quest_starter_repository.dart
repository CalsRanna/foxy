import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_quest_starter_repository.g.dart';

@FoxyRepository(GameObjectQuestStarterEntity)
class GameObjectQuestStarterRepository
    with RepositoryMixin, _GameObjectQuestStarterRepositoryMixin {
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

  Future<List<BriefGameObjectQuestStarterEntity>>
  getBriefGameObjectQuestStarters(int questId, {int page = 1}) async {
    final fields = <String>[
      'gos.id',
      'gos.quest',
      'got.name',
      if (localeEnabled) 'gotl.name AS localeName',
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
}
