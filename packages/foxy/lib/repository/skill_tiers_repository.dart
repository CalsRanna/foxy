import 'package:foxy/entity/skill_tiers_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'skill_tiers_repository.g.dart';

@FoxyRepository()
class SkillTiersRepository with RepositoryMixin, _SkillTiersRepositoryMixin {
  Future<int> countAllSkillTiers() async {
    return laconic.table(_table).count();
  }

  Future<List<SkillTiersEntity>> getAllSkillTiers() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => SkillTiersEntity.fromJson(row.toMap())).toList();
  }
}
