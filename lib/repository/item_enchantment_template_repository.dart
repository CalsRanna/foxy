import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_enchantment_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemEnchantmentTemplateRepository with RepositoryMixin {
  static const _table = 'item_enchantment_template';
  static const primaryKeyColumns = {'entry', 'ench'};

  Future<int> countItemEnchantmentGroups({
    required ItemEnchantmentKind kind,
    ItemEnchantmentTemplateFilterEntity? filter,
  }) async {
    final dbcTable = dbcTableFor(kind);
    var builder = laconic.table('$_table AS iet');
    builder = builder.select(['iet.entry']);
    builder = builder.leftJoin(
      '$dbcTable AS random_ench',
      (join) => join.on('iet.ench', 'random_ench.ID'),
    );
    builder = builder.whereNotNull('random_ench.ID');
    builder = _applyFilter(builder, filter).groupBy('iet.entry');
    return (await builder.get()).length;
  }

  Future<int> countItemEnchantmentTemplates({
    ItemEnchantmentTemplateFilterEntity? filter,
    ItemEnchantmentKind kind = ItemEnchantmentKind.randomProperty,
  }) async {
    var builder = laconic.table('$_table AS iet');
    final dbcTable = dbcTableFor(kind);
    builder = builder.leftJoin(
      '$dbcTable AS random_ench',
      (join) => join.on('iet.ench', 'random_ench.ID'),
    );
    builder = builder.whereNotNull('random_ench.ID');
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemEnchantmentTemplateEntity> createItemEnchantmentTemplate(
    int entry,
  ) async {
    return ItemEnchantmentTemplateEntity(entry: entry);
  }

  Future<void> destroyItemEnchantmentTemplate(int entry, int ench) async {
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('ench', ench)
        .delete();
  }

  Future<List<BriefItemEnchantmentTemplateEntity>>
  getBriefItemEnchantmentGroups({
    required ItemEnchantmentKind kind,
    ItemEnchantmentTemplateFilterEntity? filter,
    int page = 1,
  }) async {
    final dbcTable = dbcTableFor(kind);
    var builder = laconic.table('$_table AS iet');
    builder = builder.select([
      'iet.entry',
      'COUNT(*) AS ItemCount',
      "'${kind.name}' AS kind",
    ]);
    builder = builder.leftJoin(
      '$dbcTable AS random_ench',
      (join) => join.on('iet.ench', 'random_ench.ID'),
    );
    builder = builder.whereNotNull('random_ench.ID');
    builder = _applyFilter(builder, filter);
    builder = builder
        .groupBy('iet.entry')
        .orderBy('iet.entry')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize);
    final rows = await builder.get();
    return rows
        .map((row) => BriefItemEnchantmentTemplateEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<BriefItemEnchantmentTemplateEntity>>
  getBriefItemEnchantmentTemplates({
    ItemEnchantmentTemplateFilterEntity? filter,
    int page = 1,
    ItemEnchantmentKind kind = ItemEnchantmentKind.randomProperty,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = _briefBuilder(kind);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('entry').orderBy('ench');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemEnchantmentTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<BriefItemEnchantmentTemplateEntity>>
  getBriefItemEnchantmentTemplatesByEntry(
    int entry, {
    required ItemEnchantmentKind kind,
  }) async {
    var builder = _briefBuilder(kind);
    builder = builder.where('iet.entry', entry);
    var results = await builder.get();
    return results
        .map((e) => BriefItemEnchantmentTemplateEntity.fromJson(e.toMap()))
        .toList();
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
    json.remove('ench');
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('ench', ench)
        .update(json);
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

  QueryBuilder _briefBuilder(ItemEnchantmentKind kind) {
    var builder = laconic.table('$_table AS iet');
    final dbcTable = dbcTableFor(kind);
    builder = builder.select([
      'iet.entry',
      'iet.ench',
      'iet.chance',
      'random_ench.Name_lang_zhCN',
      'dsie_1.Name_lang_zhCN AS Enchantment_1',
      'dsie_2.Name_lang_zhCN AS Enchantment_2',
      'dsie_3.Name_lang_zhCN AS Enchantment_3',
      'dsie_4.Name_lang_zhCN AS Enchantment_4',
      'dsie_5.Name_lang_zhCN AS Enchantment_5',
    ]);
    builder = builder.leftJoin(
      '$dbcTable AS random_ench',
      (join) => join.on('iet.ench', 'random_ench.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_1',
      (join) => join.on('random_ench.Enchantment_1', 'dsie_1.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_2',
      (join) => join.on('random_ench.Enchantment_2', 'dsie_2.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_3',
      (join) => join.on('random_ench.Enchantment_3', 'dsie_3.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_4',
      (join) => join.on('random_ench.Enchantment_4', 'dsie_4.ID'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_spell_item_enchantment AS dsie_5',
      (join) => join.on('random_ench.Enchantment_5', 'dsie_5.ID'),
    );
    builder = builder.whereNotNull('random_ench.ID');
    return builder;
  }

  static String dbcTableFor(ItemEnchantmentKind kind) =>
      kind == ItemEnchantmentKind.randomProperty
      ? 'foxy.dbc_item_random_properties'
      : 'foxy.dbc_item_random_suffix';
}
