import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_template_addon_repository.g.dart';

@FoxyRepository(GameObjectTemplateAddonEntity)
class GameObjectTemplateAddonRepository
    with RepositoryMixin, _GameObjectTemplateAddonRepositoryMixin {
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

  Future<List<GameObjectTemplateAddonEntity>>
  getGameObjectTemplateAddons() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => GameObjectTemplateAddonEntity.fromJson(row.toMap()))
        .toList();
  }
}
