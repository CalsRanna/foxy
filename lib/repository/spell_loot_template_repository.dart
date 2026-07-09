import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellLootTemplateRepository with RepositoryMixin {
  static const _table = 'spell_loot_template';

  Future<List<SpellLootTemplateEntity>> getBriefSpellLootTemplates(
    int entry,
  ) async {
    var builder = laconic.table('$_table AS slt');
    const fields = [
      'slt.*',
      'it.name',
      'itl.Name as localeName',
      'it.Quality',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('slt.Item', 'it.entry'),
    );
    builder = builder.leftJoin(
      'item_template_locale AS itl',
      (join) => join.on('it.entry', 'itl.ID'),
    );
    builder = builder.where('slt.Entry', entry);
    var results = await builder.get();
    return results
        .map((e) => SpellLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SpellLootTemplateEntity?> getSpellLootTemplate(
    int entry,
    int item,
  ) async {
    var results = await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return SpellLootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<SpellLootTemplateEntity> createSpellLootTemplate(int entry) async {
    return SpellLootTemplateEntity(entry: entry);
  }

  Future<void> storeSpellLootTemplate(SpellLootTemplateEntity data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> updateSpellLootTemplate(
    int entry,
    int item,
    SpellLootTemplateEntity data,
  ) async {
    var json = data.toJson();
    json.remove('Entry');
    json.remove('Item');
    await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .update(json);
  }

  Future<void> destroySpellLootTemplate(int entry, int item) async {
    await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .delete();
  }

  Future<void> copySpellLootTemplate(int entry, int item) async {
    var source = await getSpellLootTemplate(entry, item);
    if (source == null) return;
    var json = source.toJson();
    var maxItemResult = await laconic
        .table(_table)
        .select(['MAX(Item) AS maxItem'])
        .where('Entry', entry)
        .first();
    var maxItem = (maxItemResult.toMap()['maxItem'] ?? 0) as int;
    json['Item'] = maxItem + 1;
    if (source.reference != 0) {
      json['Reference'] = maxItem + 1;
    }
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveSpellLootTemplate(SpellLootTemplateEntity data) async {
    var existing = await getSpellLootTemplate(data.entry, data.item);
    if (existing != null) {
      await updateSpellLootTemplate(data.entry, data.item, data);
    } else {
      await storeSpellLootTemplate(data);
    }
  }
}
