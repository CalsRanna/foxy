import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PlayerCreateInfoRepository with RepositoryMixin {
  static const _table = 'playercreateinfo';

  Future<List<PlayerCreateInfoEntity>> getBriefPlayerCreateInfos({
    PlayerCreateInfoFilterEntity? filter,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('race').orderBy('`class`');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => PlayerCreateInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countPlayerCreateInfos({
    PlayerCreateInfoFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<PlayerCreateInfoEntity?> getPlayerCreateInfo(
    int race,
    int class_,
  ) async {
    var results = await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoEntity.fromJson(results.first.toMap());
  }

  Future<PlayerCreateInfoEntity> createPlayerCreateInfo() async {
    return const PlayerCreateInfoEntity();
  }

  Future<void> storePlayerCreateInfo(PlayerCreateInfoEntity info) async {
    await laconic.table(_table).insert([info.toJson()]);
  }

  Future<void> updatePlayerCreateInfo(
    int race,
    int class_,
    PlayerCreateInfoEntity info,
  ) async {
    var json = info.toJson();
    json.remove('race');
    json.remove('class');
    await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .update(json);
  }

  Future<void> destroyPlayerCreateInfo(int race, int class_) async {
    await laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .delete();
  }

  Future<void> copyPlayerCreateInfo(int race, int class_) async {
    var source = await getPlayerCreateInfo(race, class_);
    if (source == null) return;
    var json = source.toJson();
    json['class'] = (json['class'] as int) + 1;
    await laconic.table(_table).insert([json]);
  }

  Future<void> savePlayerCreateInfo(PlayerCreateInfoEntity info) async {
    var existing = await getPlayerCreateInfo(info.race, info.class_);
    if (existing != null) {
      await updatePlayerCreateInfo(info.race, info.class_, info);
    } else {
      await storePlayerCreateInfo(info);
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    PlayerCreateInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.race.isNotEmpty) {
      builder = builder.where('race', filter.race);
    }
    if (filter.class_.isNotEmpty) {
      builder = builder.where('class', filter.class_);
    }
    return builder;
  }
}