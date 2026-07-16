import 'package:foxy/entity/game_object_art_kit_entity.dart';
import 'package:foxy/entity/game_object_art_kit_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GameObjectArtKitRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_game_object_art_kit';

  Future<void> copyGameObjectArtKit(int id) async {
    final source = await getGameObjectArtKit(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await _getNextId();
    await laconic.table(_table).insert([json]);
  }

  Future<int> countGameObjectArtKits({GameObjectArtKitFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<GameObjectArtKitEntity> createGameObjectArtKit() async =>
      GameObjectArtKitEntity(id: await _getNextId());

  Future<void> destroyGameObjectArtKit(int id) async {
    await laconic.table(_table).where('ID', id).delete();
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

  Future<GameObjectArtKitEntity?> getGameObjectArtKit(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
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

  Future<void> saveGameObjectArtKit(GameObjectArtKitEntity entity) async {
    if (await getGameObjectArtKit(entity.id) == null) {
      await storeGameObjectArtKit(entity);
    } else {
      await updateGameObjectArtKit(entity);
    }
  }

  Future<int> storeGameObjectArtKit(GameObjectArtKitEntity entity) async {
    final json = entity.toJson();
    final id = entity.id > 0 ? entity.id : await _getNextId();
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateGameObjectArtKit(GameObjectArtKitEntity entity) async {
    final json = entity.toJson()..remove('ID');
    await laconic.table(_table).where('ID', entity.id).update(json);
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

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');
}
