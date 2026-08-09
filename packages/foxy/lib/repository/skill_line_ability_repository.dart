import 'package:foxy/entity/skill_line_ability_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'skill_line_ability_repository.g.dart';

@FoxyRepository(linkKey: ['skillLine'])
class SkillLineAbilityRepository
    with RepositoryMixin, _SkillLineAbilityRepositoryMixin {

  Future<int> countAllSkillLineAbilities() async {
    return laconic.table(_table).count();
  }

  Future<List<SkillLineAbilityEntity>> getAllSkillLineAbilities() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SkillLineAbilityEntity.fromJson(row.toMap()))
        .toList();
  }
}
