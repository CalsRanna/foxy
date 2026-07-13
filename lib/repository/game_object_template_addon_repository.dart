import 'package:foxy/entity/game_object_template_addon_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectTemplateAddonRepository with RepositoryMixin {
  static const _table = 'gameobject_template_addon';

  Future<List<BriefGameObjectTemplateAddonEntity>>
  getBriefGameObjectTemplateAddons({int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'entry',
      'faction',
      'flags',
      'mingold',
      'maxgold',
    ]);
    builder = builder.orderBy('entry');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefGameObjectTemplateAddonEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<GameObjectTemplateAddonEntity>>
  getGameObjectTemplateAddons() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => GameObjectTemplateAddonEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countGameObjectTemplateAddons() async {
    return laconic.table(_table).count();
  }

  Future<GameObjectTemplateAddonEntity?> getGameObjectTemplateAddon(
    int entry,
  ) async {
    var results = await laconic
        .table(_table)
        .where('entry', entry)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return GameObjectTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<GameObjectTemplateAddonEntity> createGameObjectTemplateAddon([
    int entry = 0,
  ]) async {
    return GameObjectTemplateAddonEntity(entry: entry);
  }

  Future<void> storeGameObjectTemplateAddon(
    GameObjectTemplateAddonEntity addon,
  ) async {
    addon.validate();
    await laconic.table(_table).insert([addon.toJson()]);
  }

  Future<void> updateGameObjectTemplateAddon(
    GameObjectTemplateAddonEntity addon,
  ) async {
    addon.validate();
    var json = addon.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', addon.entry).update(json);
  }

  Future<void> destroyGameObjectTemplateAddon(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<void> copyGameObjectTemplateAddon(int entry) async {
    throw UnsupportedError('附加数据与游戏对象模板是一对一关系，不能独立复制');
  }

  Future<void> saveGameObjectTemplateAddon(
    GameObjectTemplateAddonEntity addon,
  ) async {
    var existing = await getGameObjectTemplateAddon(addon.entry);
    if (existing != null) {
      await updateGameObjectTemplateAddon(addon);
    } else {
      await storeGameObjectTemplateAddon(addon);
    }
  }
}
