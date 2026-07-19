import 'package:foxy/entity/brief_game_object_template_addon_entity.dart';
import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GameObjectTemplateAddonRepository with RepositoryMixin {
  static const _table = 'gameobject_template_addon';

  Future<void> copyGameObjectTemplateAddon(int key) {
    throw UnsupportedError('附加数据与游戏对象模板是一对一关系，不能独立复制');
  }

  Future<int> countGameObjectTemplateAddons() {
    return laconic.table(_table).count();
  }

  Future<GameObjectTemplateAddonEntity> createGameObjectTemplateAddon([
    int? entry,
  ]) async {
    return GameObjectTemplateAddonEntity(
      entry: entry ?? await nextMaxPlusOne(_table, 'entry'),
    );
  }

  Future<void> destroyGameObjectTemplateAddon(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原游戏对象模板附加数据不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGameObjectTemplateAddonEntity>>
  getBriefGameObjectTemplateAddons({int page = 1}) async {
    final results = await laconic
        .table(_table)
        .select(['entry', 'faction', 'flags', 'mingold', 'maxgold'])
        .orderBy('entry')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefGameObjectTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<GameObjectTemplateAddonEntity?> getGameObjectTemplateAddon(
    int key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GameObjectTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<List<GameObjectTemplateAddonEntity>>
  getGameObjectTemplateAddons() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => GameObjectTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeGameObjectTemplateAddon(
    GameObjectTemplateAddonEntity addon,
  ) async {
    if (addon.entry <= 0) {
      throw StateError('游戏对象模板附加数据 entry 必须显式指定');
    }
    try {
      await laconic.table(_table).insert([addon.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('游戏对象模板附加数据 ${addon.entry} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectTemplateAddon(
    int originalKey,
    GameObjectTemplateAddonEntity addon,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(addon.toJson());
      if (matchedRows == 0) {
        throw StateError('原游戏对象模板附加数据不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的游戏对象模板附加数据 entry 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('entry', key);
  }
}
