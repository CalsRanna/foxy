import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_quest_ender_repository.g.dart';

@FoxyRepository(GameObjectQuestEnderEntity, linkKey: ['quest'])
class GameObjectQuestEnderRepository
    with RepositoryMixin, _GameObjectQuestEnderRepositoryMixin {
  static const _table = 'gameobject_questender';
  static const primaryKeyColumns = {'id', 'quest'};

  @override
  Future<int> countGameObjectQuestEnders(int quest) {
    return laconic.table(_table).where('quest', quest).count();
  }

  @override
  Future<GameObjectQuestEnderEntity> createGameObjectQuestEnder(
    int quest,
  ) async {
    return GameObjectQuestEnderEntity(quest: quest);
  }

  @override
  Future<List<BriefGameObjectQuestEnderEntity>> getBriefGameObjectQuestEnders(
    int quest, {
    int page = 1,
  }) async {
    final fields = <String>[
      'goe.id',
      'goe.quest',
      'got.name',
      if (localeEnabled) 'gotl.name as localeName',
    ];
    var builder = laconic.table('$_table as goe');
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'gameobject_template as got',
      (join) => join.on('goe.id', 'got.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'gameobject_template_locale as gotl',
        (join) =>
            join.on('got.entry', 'gotl.entry').where('gotl.locale', 'zhCN'),
      );
    }
    builder = builder.where('goe.quest', quest);
    builder = builder.orderBy('goe.id');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefGameObjectQuestEnderEntity.fromJson(e.toMap()))
        .toList();
  }
}
