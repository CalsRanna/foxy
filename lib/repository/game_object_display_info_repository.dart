import 'package:foxy/entity/game_object_display_info_entity.dart';
import 'package:foxy/entity/game_object_display_info_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GameObjectDisplayInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_game_object_display_info';

  Future<void> copyGameObjectDisplayInfo(int id) async {
    final source = await getGameObjectDisplayInfo(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<int> countGameObjectDisplayInfos({
    GameObjectDisplayInfoFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<GameObjectDisplayInfoEntity> createGameObjectDisplayInfo() async =>
      GameObjectDisplayInfoEntity(id: await _getNextId());

  Future<void> destroyGameObjectDisplayInfo(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<List<BriefGameObjectDisplayInfoEntity>>
  getBriefGameObjectDisplayInfos({
    int page = 1,
    GameObjectDisplayInfoFilterEntity? filter,
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

  Future<GameObjectDisplayInfoEntity?> getGameObjectDisplayInfo(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
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

  Future<void> saveGameObjectDisplayInfo(
    GameObjectDisplayInfoEntity entity,
  ) async {
    if (await getGameObjectDisplayInfo(entity.id) == null) {
      await storeGameObjectDisplayInfo(entity);
    } else {
      await updateGameObjectDisplayInfo(entity);
    }
  }

  Future<int> storeGameObjectDisplayInfo(
    GameObjectDisplayInfoEntity entity,
  ) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateGameObjectDisplayInfo(
    GameObjectDisplayInfoEntity entity,
  ) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GameObjectDisplayInfoFilterEntity? filter,
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

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');
}
