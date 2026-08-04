import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_quest_starter_repository.g.dart';

@FoxyRepository(GameObjectQuestStarterEntity, linkKey: ['quest'])
class GameObjectQuestStarterRepository
    with RepositoryMixin, _GameObjectQuestStarterRepositoryMixin {
  static const _table = 'gameobject_queststarter';
  static const primaryKeyColumns = {'id', 'quest'};

  @override
  Future<int> countGameObjectQuestStarters(int quest) {
    return laconic.table(_table).where('quest', quest).count();
  }

  @override
  Future<GameObjectQuestStarterEntity> createGameObjectQuestStarter(
    int quest,
  ) async {
    return GameObjectQuestStarterEntity(quest: quest);
  }

  @override
  Future<List<BriefGameObjectQuestStarterEntity>>
  getBriefGameObjectQuestStarters(int quest, {int page = 1}) async {
    final fields = <String>[
      'gos.id',
      'gos.quest',
      'got.name',
      if (localeEnabled) 'gotl.name as localeName',
    ];
    var builder = laconic.table('$_table as gos');
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'gameobject_template as got',
      (join) => join.on('gos.id', 'got.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'gameobject_template_locale as gotl',
        (join) =>
            join.on('got.entry', 'gotl.entry').where('gotl.locale', 'zhCN'),
      );
    }
    builder = builder.where('gos.quest', quest);
    builder = builder.orderBy('gos.id');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestStarterEntity.fromJson(e.toMap()))
        .toList();
  }
}
