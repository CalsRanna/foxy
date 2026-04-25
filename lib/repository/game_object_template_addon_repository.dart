import 'package:foxy/model/game_object_template_addon.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GameObjectTemplateAddonRepository with RepositoryMixin {
  static const _table = 'gameobject_template_addon';

  Future<GameObjectTemplateAddon?> find(int entry) async {
    try {
      var result = await laconic.table(_table).where('entry', entry).first();
      return GameObjectTemplateAddon.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(GameObjectTemplateAddon addon) async {
    await laconic.table(_table).insert([addon.toJson()]);
  }

  Future<void> update(GameObjectTemplateAddon addon) async {
    var json = addon.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', addon.entry).update(json);
  }

  Future<void> save(GameObjectTemplateAddon addon) async {
    var existing = await find(addon.entry);
    if (existing != null) {
      await update(addon);
    } else {
      await store(addon);
    }
  }
}
