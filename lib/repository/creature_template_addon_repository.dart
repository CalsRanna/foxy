import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureTemplateAddonRepository with RepositoryMixin {
  static const _table = 'creature_template_addon';

  Future<void> copyCreatureTemplateAddon(int entry) async {
    var source = await getCreatureTemplateAddon(entry);
    if (source == null) return;
    var json = source.toJson();
    var nextEntry = await _getNextEntry();
    json['entry'] = nextEntry;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countCreatureTemplateAddons() async {
    return laconic.table(_table).count();
  }

  Future<CreatureTemplateAddonEntity> createCreatureTemplateAddon([
    int entry = 0,
  ]) async {
    return CreatureTemplateAddonEntity(entry: entry);
  }

  Future<void> destroyCreatureTemplateAddon(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<List<BriefCreatureTemplateAddonEntity>>
  getBriefCreatureTemplateAddons({int page = 1}) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['entry', 'path_id', 'mount', 'emote', 'auras']);
    builder = builder.orderBy('entry');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureTemplateAddonEntity.fromJson(e.toMap()))
        .toList();
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

  Future<List<CreatureTemplateAddonEntity>> getCreatureTemplateAddons() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureTemplateAddonEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> saveCreatureTemplateAddon(
    CreatureTemplateAddonEntity addon,
  ) async {
    final validated = _validated(addon);
    var existing = await getCreatureTemplateAddon(validated.entry);
    if (existing != null) {
      await updateCreatureTemplateAddon(validated);
    } else {
      await storeCreatureTemplateAddon(validated);
    }
  }

  Future<void> storeCreatureTemplateAddon(
    CreatureTemplateAddonEntity addon,
  ) async {
    await laconic.table(_table).insert([_validated(addon).toJson()]);
  }

  Future<void> updateCreatureTemplateAddon(
    CreatureTemplateAddonEntity addon,
  ) async {
    var json = _validated(addon).toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', addon.entry).update(json);
  }

  Future<int> _getNextEntry() async {
    return nextMaxPlusOne(_table, 'entry');
  }

  CreatureTemplateAddonEntity _validated(CreatureTemplateAddonEntity addon) {
    if (addon.visibilityDistanceType < 0 || addon.visibilityDistanceType > 5) {
      throw RangeError.range(
        addon.visibilityDistanceType,
        0,
        5,
        'visibilityDistanceType',
      );
    }
    return addon.copyWith(
      auras: CreatureTemplateAddonEntity.normalizeAuras(addon.auras),
    );
  }
}
