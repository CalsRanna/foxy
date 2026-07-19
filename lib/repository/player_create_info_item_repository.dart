import 'package:foxy/entity/brief_player_create_info_item_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_item_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PlayerCreateInfoItemRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_item';

  Future<void> copyPlayerCreateInfoItem(PlayerCreateInfoItemKey key) async {
    throw UnsupportedError('物品 ID 是复合主键的一部分，请新增并选择有效物品。');
  }

  Future<int> countPlayerCreateInfoItems(int race, int class_) {
    return laconic
        .table(_table)
        .whereRaw('(`race` = 0 OR `race` = ?)', [race])
        .whereRaw('(`class` = 0 OR `class` = ?)', [class_])
        .count();
  }

  Future<PlayerCreateInfoItemEntity> createPlayerCreateInfoItem(
    int race,
    int class_,
  ) async => PlayerCreateInfoItemEntity(race: race, class_: class_);

  Future<void> destroyPlayerCreateInfoItem(PlayerCreateInfoItemKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原角色物品记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefPlayerCreateInfoItemEntity>> getBriefPlayerCreateInfoItems(
    int race,
    int class_, {
    int page = 1,
  }) async {
    final results = await laconic
        .table(_table)
        .select(['race', 'class', 'itemid', 'amount', 'Note'])
        .whereRaw('(`race` = 0 OR `race` = ?)', [race])
        .whereRaw('(`class` = 0 OR `class` = ?)', [class_])
        .orderBy('race')
        .orderBy('`class`')
        .orderBy('itemid')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefPlayerCreateInfoItemEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<PlayerCreateInfoItemEntity?> getPlayerCreateInfoItem(
    PlayerCreateInfoItemKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoItemEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfoItem(
    PlayerCreateInfoItemEntity item,
  ) async {
    try {
      await laconic.table(_table).insert([item.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同种族、职业与物品 ID 的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoItem(
    PlayerCreateInfoItemKey originalKey,
    PlayerCreateInfoItemEntity item,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(item.toJson());
      if (matchedRows == 0) {
        throw StateError('原角色物品记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的种族、职业与物品 ID 组合已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoItemKey key) {
    return builder
        .where('race', key.race)
        .where('class', key.class_)
        .where('itemid', key.itemId);
  }
}
