import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateAddonRepository with RepositoryMixin {
  static const _table = 'creature_template_addon';

  Future<List<BriefCreatureTemplateAddonEntity>>
  getBriefCreatureTemplateAddons({int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'entry',
      'path_id',
      'mount',
      'emote',
      'auras',
    ]);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureTemplateAddonEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<CreatureTemplateAddonEntity>> getCreatureTemplateAddons() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureTemplateAddonEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countCreatureTemplateAddons() async {
    return laconic.table(_table).count();
  }

  Future<CreatureTemplateAddonEntity?> getCreatureTemplateAddon(
    int entry,
  ) async {
    var results = await laconic
        .table(_table)
        .where('entry', entry)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return CreatureTemplateAddonEntity.fromJson(results.first.toMap());
  }

  Future<CreatureTemplateAddonEntity> createCreatureTemplateAddon([
    int entry = 0,
  ]) async {
    return CreatureTemplateAddonEntity(entry: entry);
  }

  Future<void> storeCreatureTemplateAddon(
    CreatureTemplateAddonEntity addon,
  ) async {
    await laconic.table(_table).insert([addon.toJson()]);
  }

  Future<void> updateCreatureTemplateAddon(
    CreatureTemplateAddonEntity addon,
  ) async {
    var json = addon.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', addon.entry).update(json);
  }

  Future<void> destroyCreatureTemplateAddon(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<void> copyCreatureTemplateAddon(int entry) async {
    var source = await getCreatureTemplateAddon(entry);
    if (source == null) return;
    var json = source.toJson();
    var nextEntry = await _getNextEntry();
    json['entry'] = nextEntry;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCreatureTemplateAddon(
    CreatureTemplateAddonEntity addon,
  ) async {
    var existing = await getCreatureTemplateAddon(addon.entry);
    if (existing != null) {
      await updateCreatureTemplateAddon(addon);
    } else {
      await storeCreatureTemplateAddon(addon);
    }
  }

  Future<int> _getNextEntry() async {
    var result = await laconic.table(_table).select([
      'MAX(entry) as max_entry',
    ]).first();
    var maxEntry = result.toMap()['max_entry'] as int?;
    return (maxEntry ?? 0) + 1;
  }
}
