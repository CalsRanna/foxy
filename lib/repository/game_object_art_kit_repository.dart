import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/game_object_art_kit_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_art_kit_repository.g.dart';

@FoxyRepository(GameObjectArtKitEntity)
@FoxyFilter.text('id')
@FoxyFilter.text('path')
class GameObjectArtKitRepository
    with RepositoryMixin, _GameObjectArtKitRepositoryMixin {
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

  Future<int> countGameObjectArtKits({GameObjectArtKitFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<GameObjectArtKitEntity> createGameObjectArtKit() async =>
      GameObjectArtKitEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefGameObjectArtKitEntity>> getBriefGameObjectArtKits({
    int page = 1,
    GameObjectArtKitFilter? filter,
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

  Future<List<GameObjectArtKitEntity>> getGameObjectArtKits() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => GameObjectArtKitEntity.fromJson(row.toMap()))
        .toList();
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GameObjectArtKitFilter? filter,
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
}
