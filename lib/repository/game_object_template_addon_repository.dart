import 'package:foxy/model/game_object_template_addon.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectTemplateAddonRepository with RepositoryMixin {
  static const _table = 'gameobject_template_addon';

  Future<GameObjectTemplateAddon?> getGameObjectTemplateAddon(int entry) async {
    try {
      var result = await laconic.table(_table).where('entry', entry).first();
      return GameObjectTemplateAddon.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeGameObjectTemplateAddon(GameObjectTemplateAddon addon) async {
    await laconic.table(_table).insert([addon.toJson()]);
  }

  Future<void> updateGameObjectTemplateAddon(GameObjectTemplateAddon addon) async {
    var json = addon.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', addon.entry).update(json);
  }

  Future<void> saveGameObjectTemplateAddon(GameObjectTemplateAddon addon) async {
    var existing = await getGameObjectTemplateAddon(addon.entry);
    if (existing != null) {
      await updateGameObjectTemplateAddon(addon);
    } else {
      await storeGameObjectTemplateAddon(addon);
    }
  }
}
