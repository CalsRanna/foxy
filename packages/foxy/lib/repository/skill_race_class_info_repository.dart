import 'package:foxy/entity/skill_race_class_info_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'skill_race_class_info_repository.g.dart';

@FoxyRepository()
class SkillRaceClassInfoRepository
    with RepositoryMixin, _SkillRaceClassInfoRepositoryMixin {
  Future<int> countSkillRaceClassInfos() async {
    return laconic.table(_table).count();
  }

  Future<List<SkillRaceClassInfoEntity>> getSkillRaceClassInfos() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => SkillRaceClassInfoEntity.fromJson(row.toMap()))
        .toList();
  }
}
