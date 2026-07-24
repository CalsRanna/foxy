import 'package:foxy/entity/game_object_art_kit_entity.dart';
import 'package:foxy/entity/game_object_art_kit_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GameObjectArtKitRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_game_object_art_kit';

  Future<int> copyGameObjectArtKit(int key) async {
    final source = await getGameObjectArtKit(key);
    if (source == null) {
      throw StateError('原游戏物体美术套件不存在，可能已被其他操作修改或删除');
    }
    final copied = GameObjectArtKitEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeGameObjectArtKit(copied);
    return copied.id;
  }

  Future<int> countGameObjectArtKits({GameObjectArtKitFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<GameObjectArtKitEntity> createGameObjectArtKit() async =>
      GameObjectArtKitEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyGameObjectArtKit(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原游戏物体美术套件不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGameObjectArtKitEntity>> getBriefGameObjectArtKits({
    int page = 1,
    GameObjectArtKitFilterEntity? filter,
  }) async {
    var builder = _applyFilter(
      laconic.table(_table).select(['ID', 'TextureVariation0', 'AttachModel0']),
      filter,
    );
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefGameObjectArtKitEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<GameObjectArtKitEntity?> getGameObjectArtKit(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : GameObjectArtKitEntity.fromJson(rows.first.toMap());
  }

  Future<List<GameObjectArtKitEntity>> getGameObjectArtKits() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => GameObjectArtKitEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeGameObjectArtKit(GameObjectArtKitEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('游戏物体美术套件 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('游戏物体美术套件 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectArtKit(
    int originalKey,
    GameObjectArtKitEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原游戏物体美术套件不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的游戏物体美术套件 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GameObjectArtKitFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.path.isNotEmpty) {
      builder = builder.whereAny(
        ['TextureVariation0', 'AttachModel0'],
        '%${filter.path}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
