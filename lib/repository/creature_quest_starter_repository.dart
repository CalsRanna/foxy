import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_quest_starter_repository.g.dart';

@FoxyRepository(CreatureQuestStarterEntity)
class CreatureQuestStarterRepository
    with RepositoryMixin, _CreatureQuestStarterRepositoryMixin {
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
}
