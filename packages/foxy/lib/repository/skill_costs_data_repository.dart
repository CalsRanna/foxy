import 'package:foxy/entity/skill_costs_data_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'skill_costs_data_repository.g.dart';

@FoxyRepository()
class SkillCostsDataRepository
    with RepositoryMixin, _SkillCostsDataRepositoryMixin {

  Future<int> countSkillCostsDatas() async {
    return laconic.table(_table).count();
  }

  Future<List<SkillCostsDataEntity>> getSkillCostsDatas() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SkillCostsDataEntity.fromJson(row.toMap()))
        .toList();
  }
}
