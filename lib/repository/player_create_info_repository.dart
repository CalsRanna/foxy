import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PlayerCreateInfoRepository with RepositoryMixin {
  static const _table = 'playercreateinfo';

  Future<void> copyPlayerCreateInfo(PlayerCreateInfoKey key) async {
    throw UnsupportedError('出生信息使用种族/职业语义主键，请新增有效组合。');
  }

  Future<int> countPlayerCreateInfos({
    PlayerCreateInfoFilterEntity? filter,
  }) async {
    var builder = _applyFilter(laconic.table(_table), filter);
    return builder.count();
  }

  Future<PlayerCreateInfoEntity> createPlayerCreateInfo() async {
    return const PlayerCreateInfoEntity();
  }

  Future<void> destroyPlayerCreateInfo(PlayerCreateInfoKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原出生信息记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefPlayerCreateInfoEntity>> getBriefPlayerCreateInfos({
    PlayerCreateInfoFilterEntity? filter,
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

  Future<PlayerCreateInfoEntity?> getPlayerCreateInfo(
    PlayerCreateInfoKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfo(PlayerCreateInfoEntity info) async {
    try {
      await laconic.table(_table).insert([info.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同种族与职业的出生信息已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfo(
    PlayerCreateInfoKey originalKey,
    PlayerCreateInfoEntity info,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(info.toJson());
      if (matchedRows == 0) {
        throw StateError('原出生信息记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的种族与职业组合已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    PlayerCreateInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.race.isNotEmpty) builder = builder.where('race', filter.race);
    if (filter.class_.isNotEmpty) {
      builder = builder.where('class', filter.class_);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoKey key) {
    return builder.where('race', key.race).where('class', key.class_);
  }
}
