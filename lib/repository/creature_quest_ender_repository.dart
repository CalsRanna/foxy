import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_quest_ender_repository.g.dart';

@FoxyRepository(CreatureQuestEnderEntity)
class CreatureQuestEnderRepository
    with RepositoryMixin, _CreatureQuestEnderRepositoryMixin {
  static const _table = 'creature_questender';
  static const primaryKeyColumns = {'id', 'quest'};

  Future<int> countCreatureQuestEnders(int questId) {
    return laconic.table(_table).where('quest', questId).count();
  }

  Future<CreatureQuestEnderEntity> createCreatureQuestEnder(int questId) async {
    return CreatureQuestEnderEntity(quest: questId);
  }

  Future<List<BriefCreatureQuestEnderEntity>> getBriefCreatureQuestEnders(
    int questId, {
    int page = 1,
  }) async {
    final fields = <String>[
      'cqe.id',
      'cqe.quest',
      'ct.name',
      if (localeEnabled) 'ctl.Name AS localeName',
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
}
