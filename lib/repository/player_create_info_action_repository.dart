import 'package:foxy/entity/brief_player_create_info_action_entity.dart';
import 'package:foxy/entity/player_create_info_action_key.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class PlayerCreateInfoActionRepository with RepositoryMixin {
  static const _table = 'playercreateinfo_action';

  Future<void> copyPlayerCreateInfoAction(PlayerCreateInfoActionKey key) async {
    throw UnsupportedError('动作按钮编号必须在 0..143 内明确选择，请新增记录。');
  }

  Future<int> countPlayerCreateInfoActions(int race, int class_) {
    return laconic
        .table(_table)
        .where('race', race)
        .where('class', class_)
        .count();
  }

  Future<PlayerCreateInfoActionEntity> createPlayerCreateInfoAction(
    int race,
    int class_,
  ) async => PlayerCreateInfoActionEntity(race: race, class_: class_);

  Future<void> destroyPlayerCreateInfoAction(
    PlayerCreateInfoActionKey key,
  ) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原角色动作记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefPlayerCreateInfoActionEntity>>
  getBriefPlayerCreateInfoActions(int race, int class_, {int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['race', 'class', 'button', 'action', 'type'])
        .where('race', race)
        .where('class', class_)
        .orderBy('button')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefPlayerCreateInfoActionEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<PlayerCreateInfoActionEntity?> getPlayerCreateInfoAction(
    PlayerCreateInfoActionKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return PlayerCreateInfoActionEntity.fromJson(results.first.toMap());
  }

  Future<void> storePlayerCreateInfoAction(
    PlayerCreateInfoActionEntity action,
  ) async {
    try {
      await laconic.table(_table).insert([action.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同种族、职业与按钮的动作记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updatePlayerCreateInfoAction(
    PlayerCreateInfoActionKey originalKey,
    PlayerCreateInfoActionEntity action,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(action.toJson());
      if (matchedRows == 0) {
        throw StateError('原角色动作记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的种族、职业与按钮组合已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, PlayerCreateInfoActionKey key) {
    return builder
        .where('race', key.race)
        .where('class', key.class_)
        .where('button', key.button);
  }
}
