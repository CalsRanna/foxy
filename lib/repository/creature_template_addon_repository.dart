import 'package:foxy/model/creature_template_addon.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateAddonRepository with RepositoryMixin {
  static const _table = 'creature_template_addon';

  /// 根据entry查找附加数据
  Future<CreatureTemplateAddon?> find(int entry) async {
    try {
      var result = await laconic.table(_table).where('entry', entry).first();
      return result != null
          ? CreatureTemplateAddon.fromJson(result.toMap())
          : null;
    } catch (e) {
      return null;
    }
  }

  /// 新增附加数据
  Future<void> store(CreatureTemplateAddon addon) async {
    await laconic.table(_table).insert([addon.toJson()]);
  }

  /// 更新附加数据
  Future<void> update(CreatureTemplateAddon addon) async {
    var json = addon.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', addon.entry).update(json);
  }

  /// 保存（存在则更新，不存在则新增）
  Future<void> save(CreatureTemplateAddon addon) async {
    var existing = await find(addon.entry);
    if (existing != null) {
      await update(addon);
    } else {
      await store(addon);
    }
  }
}
