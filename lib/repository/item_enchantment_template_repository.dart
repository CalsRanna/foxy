import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemEnchantmentTemplateRepository with RepositoryMixin {
  static const _table = 'item_enchantment_template';

  Future<List<BriefItemEnchantmentTemplateEntity>>
  getBriefItemEnchantmentTemplates({
    ItemEnchantmentTemplateFilterEntity? filter,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = _briefBuilder();
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('entry').orderBy('ench');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemEnchantmentTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<BriefItemEnchantmentTemplateEntity>>
  getBriefItemEnchantmentTemplatesByEntry(int entry) async {
    var builder = _briefBuilder();
    builder = builder.where('iet.entry', entry);
    var results = await builder.get();
    return results
        .map((e) => BriefItemEnchantmentTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countItemEnchantmentTemplates({
    ItemEnchantmentTemplateFilterEntity? filter,
  }) async {
    // Keep join + whereNotNull so count matches brief rows (valid ench only).
    var builder = laconic.table('$_table AS iet');
    builder = builder.leftJoin(
      'foxy.dbc_item_random_properties AS dirp',
      (join) => join.on('iet.ench', 'dirp.ID'),
    );
    builder = builder.whereNotNull('dirp.ID');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemEnchantmentTemplateEntity?> getItemEnchantmentTemplate(
    int entry,
    int ench,
  ) async {
    var results = await laconic
        .table(_table)
        .where('entry', entry)
        .where('ench', ench)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return ItemEnchantmentTemplateEntity.fromJson(results.first.toMap());
  }

  Future<ItemEnchantmentTemplateEntity> createItemEnchantmentTemplate(
    int entry,
  ) async {
    return ItemEnchantmentTemplateEntity(entry: entry);
  }

  Future<void> storeItemEnchantmentTemplate(
    ItemEnchantmentTemplateEntity model,
  ) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateItemEnchantmentTemplate(
    int entry,
    int ench,
    ItemEnchantmentTemplateEntity model,
  ) async {
    var json = model.toJson();
    json.remove('entry');
    // allow ench change in payload
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('ench', ench)
        .update(json);
  }

  Future<void> destroyItemEnchantmentTemplate(int entry, int ench) async {
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('ench', ench)
        .delete();
  }

  Future<void> copyItemEnchantmentTemplate(int entry, int ench) async {
    var source = await getItemEnchantmentTemplate(entry, ench);
    if (source == null) return;
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(ench) AS maxEnch'])
        .where('entry', entry)
        .first();
    var maxEnch = (maxResult.toMap()['maxEnch'] ?? 0) as int;
    var json = source.toJson();
    json['ench'] = maxEnch + 1;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveItemEnchantmentTemplate(
    ItemEnchantmentTemplateEntity model,
  ) async {
    var existing = await getItemEnchantmentTemplate(model.entry, model.ench);
    if (existing != null) {
      await updateItemEnchantmentTemplate(model.entry, model.ench, model);
    } else {
      await storeItemEnchantmentTemplate(model);
    }
  }

  QueryBuilder _briefBuilder() {
    var builder = laconic.table('$_table AS iet');
    builder = builder.select([
      'iet.entry',
      'iet.ench',
      'iet.chance',
      'dirp.Name_lang_zhCN',
      'dirp.Name',
      'dsie_1.Name_lang_zhCN AS Enchantment_1',
      'dsie_2.Name_lang_zhCN AS Enchantment_2',
      'dsie_3.Name_lang_zhCN AS Enchantment_3',
      'dsie_4.Name_lang_zhCN AS Enchantment_4',
      'dsie_5.Name_lang_zhCN AS Enchantment_5',
    ]);
    builder = builder.leftJoin(
      'foxy.dbc_item_random_properties AS dirp',
      (join) => join.on('iet.ench', 'dirp.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_1',
      (join) => join.on('dirp.Enchantment_1', 'dsie_1.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_2',
      (join) => join.on('dirp.Enchantment_2', 'dsie_2.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_3',
      (join) => join.on('dirp.Enchantment_3', 'dsie_3.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_4',
      (join) => join.on('dirp.Enchantment_4', 'dsie_4.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_5',
      (join) => join.on('dirp.Enchantment_5', 'dsie_5.ID'),
    );
    builder = builder.whereNotNull('dirp.ID');
    return builder;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemEnchantmentTemplateFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('iet.entry', filter.entry);
    }
    return builder;
  }
}
