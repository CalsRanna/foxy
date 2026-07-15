import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellLootTemplateRepository with RepositoryMixin {
  static const _table = 'spell_loot_template';

  Future<List<BriefSpellLootTemplateEntity>> getBriefSpellLootTemplates(
    int entry,
  ) async {
    var builder = laconic.table('$_table AS slt');
    final fields = <String>[
      'slt.*',
      'it.name',
      if (localeEnabled) 'itl.Name as localeName',
      'it.Quality',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('slt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('slt.Entry', entry);
    var results = await builder.get();
    return results
        .map((e) => BriefSpellLootTemplateEntity.fromJson(e.toMap()))
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
    await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .update(data.toJson());
  }

  Future<void> destroySpellLootTemplate(int entry, int item) async {
    await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .delete();
  }

  Future<void> copySpellLootTemplate(int entry, int item) async {
    throw UnsupportedError('法术掉落记录不能自动复制，请新增记录并选择有效物品或引用模板。');
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
