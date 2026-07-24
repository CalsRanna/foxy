import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/game_object_display_info_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_display_info_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'GameObjectDisplayInfoFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'modelName',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class GameObjectDisplayInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_game_object_display_info';

  Future<int> copyGameObjectDisplayInfo(int key) async {
    final source = await getGameObjectDisplayInfo(key);
    if (source == null) {
      throw StateError('原游戏物体显示信息不存在，可能已被其他操作修改或删除');
    }
    final copied = GameObjectDisplayInfoEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeGameObjectDisplayInfo(copied);
    return copied.id;
  }

  Future<int> countGameObjectDisplayInfos({
    GameObjectDisplayInfoFilter? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<GameObjectDisplayInfoEntity> createGameObjectDisplayInfo() async =>
      GameObjectDisplayInfoEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyGameObjectDisplayInfo(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原游戏物体显示信息不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGameObjectDisplayInfoEntity>>
  getBriefGameObjectDisplayInfos({
    int page = 1,
    GameObjectDisplayInfoFilter? filter,
  }) async {
    var builder = _applyFilter(
      laconic.table(_table).select(['ID', 'ModelName']),
      filter,
    );
    final rows = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefGameObjectDisplayInfoEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<GameObjectDisplayInfoEntity?> getGameObjectDisplayInfo(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : GameObjectDisplayInfoEntity.fromJson(rows.first.toMap());
  }

  Future<List<GameObjectDisplayInfoEntity>> getGameObjectDisplayInfos() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => GameObjectDisplayInfoEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeGameObjectDisplayInfo(
    GameObjectDisplayInfoEntity entity,
  ) async {
    if (entity.id <= 0) {
      throw StateError('游戏物体显示信息 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('游戏物体显示信息 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGameObjectDisplayInfo(
    int originalKey,
    GameObjectDisplayInfoEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原游戏物体显示信息不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的游戏物体显示信息 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GameObjectDisplayInfoFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.modelName.isNotEmpty) {
      builder = builder.where(
        'ModelName',
        '%${filter.modelName}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
