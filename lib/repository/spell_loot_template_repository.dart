import 'package:foxy/model/spell_loot_template.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellLootTemplateRepository with RepositoryMixin {
  static const _table = 'spell_loot_template';

  Future<List<SpellLootTemplate>> getByEntry(int entry) async {
    try {
      var builder = laconic.table('$_table AS slt');
      const fields = [
        'slt.*',
        'it.name',
        'itl.Name as localeName',
        'it.Quality',
        'didi.InventoryIcon_1',
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
          .map((e) => SpellLootTemplate.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<SpellLootTemplate?> find(int entry, int item) async {
    try {
      var result = await laconic
          .table(_table)
          .where('Entry', entry)
          .where('Item', item)
          .first();
      return SpellLootTemplate.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> store(SpellLootTemplate data) async {
    await laconic.table(_table).insert([data.toJson()]);
  }

  Future<void> update(
      SpellLootTemplate oldData, SpellLootTemplate newData) async {
    var json = newData.toJson();
    json.remove('Entry');
    json.remove('Item');
    await laconic
        .table(_table)
        .where('Entry', oldData.entry)
        .where('Item', oldData.item)
        .update(json);
  }

  Future<void> delete(int entry, int item) async {
    await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .delete();
  }

  Future<SpellLootTemplate> copy(SpellLootTemplate data) async {
    var json = data.toJson();
    var maxItemResult = await laconic
        .table(_table)
        .select(['MAX(Item) AS maxItem'])
        .where('Entry', data.entry)
        .first();
    var maxItem = (maxItemResult.toMap()['maxItem'] ?? 0) as int;
    json['Item'] = maxItem + 1;
    if (data.reference != 0) {
      json['Reference'] = maxItem + 1;
    }
    await laconic.table(_table).insert([json]);
    return SpellLootTemplate.fromJson(json);
  }
}
