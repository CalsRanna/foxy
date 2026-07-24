import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/game_object_display_info_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_display_info_repository.g.dart';

@FoxyRepository(GameObjectDisplayInfoEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('modelName')
class GameObjectDisplayInfoRepository
    with RepositoryMixin, _GameObjectDisplayInfoRepositoryMixin {
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
}
