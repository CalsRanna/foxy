import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_repository.g.dart';

@FoxyRepository(PlayerCreateInfoEntity)
@FoxyFilter.text('race')
@FoxyFilter.text('class_')
class PlayerCreateInfoRepository
    with RepositoryMixin, _PlayerCreateInfoRepositoryMixin {
  static const _table = 'playercreateinfo';

  Future<void> copyPlayerCreateInfo(PlayerCreateInfoKey key) async {
    throw UnsupportedError('出生信息使用种族/职业语义主键，请新增有效组合。');
  }

  Future<int> countPlayerCreateInfos({PlayerCreateInfoFilter? filter}) async {
    var builder = _applyFilter(laconic.table(_table), filter);
    return builder.count();
  }

  Future<PlayerCreateInfoEntity> createPlayerCreateInfo() async {
    return const PlayerCreateInfoEntity();
  }

  Future<List<BriefPlayerCreateInfoEntity>> getBriefPlayerCreateInfos({
    PlayerCreateInfoFilter? filter,
    int page = 1,
  }) async {
    var builder = laconic.table(_table).select([
      'race',
      'class',
      'map',
      'zone',
      'position_x',
      'position_y',
      'position_z',
      'orientation',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('race')
        .orderBy('`class`')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefPlayerCreateInfoEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    PlayerCreateInfoFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.race.isNotEmpty) builder = builder.where('race', filter.race);
    if (filter.class_.isNotEmpty) {
      builder = builder.where('class', filter.class_);
    }
    return builder;
  }
}
