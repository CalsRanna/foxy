import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'npc_trainer_repository.g.dart';

@FoxyRepository(NpcTrainerEntity)
class NpcTrainerRepository with RepositoryMixin, _NpcTrainerRepositoryMixin {
  static const _table = 'trainer_spell';
  static const primaryKeyColumns = {'TrainerId', 'SpellId'};

  Future<int> countNpcTrainers(int trainerId) {
    return laconic.table(_table).where('TrainerId', trainerId).count();
  }

  Future<NpcTrainerEntity> createNpcTrainer(int trainerId) async {
    return NpcTrainerEntity(trainerId: trainerId);
  }

  Future<List<BriefNpcTrainerEntity>> getBriefNpcTrainers(
    int trainerId, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS ts');
    builder = builder.select([
      'ts.TrainerId',
      'ts.SpellId',
      'ts.MoneyCost',
      'ts.ReqSkillLine',
      'ts.ReqLevel',
      'ds.Name_lang_zhCN as spellName',
      'ds.NameSubtext_lang_zhCN as spellSubtext',
    ]);
    builder = builder.leftJoin(
      'foxy.dbc_spell AS ds',
      (join) => join.on('ts.SpellId', 'ds.ID'),
    );
    builder = builder.where('ts.TrainerId', trainerId);
    builder = builder.orderBy('ts.SpellId');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefNpcTrainerEntity.fromJson(e.toMap()))
        .toList();
  }
}
