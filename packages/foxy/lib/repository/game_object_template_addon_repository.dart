import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'game_object_template_addon_repository.g.dart';

@FoxyRepository()
class GameObjectTemplateAddonRepository
    with RepositoryMixin, _GameObjectTemplateAddonRepositoryMixin {

  Future<void> copyGameObjectTemplateAddon(int key) {
    throw CopyNotSupportedException(
      'addon data has a one-to-one relationship with game object templates and cannot be copied independently',
    );
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
