import 'package:foxy/model/item_enchantment_template.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemEnchantmentTemplateRepository with RepositoryMixin {
  static const _table = 'item_enchantment_template';

  /// 搜索附魔模板（按 entry 搜索，带分页）
  Future<List<ItemEnchantmentTemplate>> search({
    String? entry,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table('$_table AS iet');
      builder = builder.select([
        'iet.entry',
        'iet.ench',
        'iet.chance',
        'iet.condition_1',
        'iet.condition_2',
        'iet.condition_3',
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
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('iet.entry', entry);
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results
          .map((e) => ItemEnchantmentTemplate.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({String? entry}) async {
    try {
      var builder = laconic.table('$_table AS iet');
      builder = builder.leftJoin(
        'foxy.dbc_item_random_properties AS dirp',
        (join) => join.on('iet.ench', 'dirp.ID'),
      );
      builder = builder.whereNotNull('dirp.ID');
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('iet.entry', entry);
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 获取指定 entry 的所有附魔项（带 DBC 名称）
  Future<List<ItemEnchantmentTemplate>> getByEntry(int entry) async {
    try {
      var builder = laconic.table('$_table AS iet');
      builder = builder.select([
        'iet.entry',
        'iet.ench',
        'iet.chance',
        'iet.condition_1',
        'iet.condition_2',
        'iet.condition_3',
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
      builder = builder.where('iet.entry', entry);
      var results = await builder.get();
      return results
          .map((e) => ItemEnchantmentTemplate.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 查找单条记录
  Future<ItemEnchantmentTemplate?> find(int entry, int ench) async {
    try {
      var result = await laconic
          .table(_table)
          .where('entry', entry)
          .where('ench', ench)
          .first();
      return ItemEnchantmentTemplate.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 新增
  Future<void> store(ItemEnchantmentTemplate model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  /// 更新
  Future<void> update(ItemEnchantmentTemplate model, {int? oldEnch}) async {
    var json = model.toJson();
    json.remove('entry');
    if (oldEnch == null) json.remove('ench');
    await laconic
        .table(_table)
        .where('entry', model.entry)
        .where('ench', oldEnch ?? model.ench)
        .update(json);
  }

  /// 删除
  Future<void> delete(int entry, int ench) async {
    await laconic
        .table(_table)
        .where('entry', entry)
        .where('ench', ench)
        .delete();
  }

  /// 复制：取新 ench = MAX+1
  Future<ItemEnchantmentTemplate> copy(int entry, int ench) async {
    // 获取最大 ench
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(ench) AS maxEnch'])
        .where('entry', entry)
        .first();
    var maxEnch = (maxResult.toMap()['maxEnch'] ?? 0) as int;

    // 获取源记录
    var source = await find(entry, ench);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newModel = ItemEnchantmentTemplate.fromJson(source.toJson());
    newModel.ench = maxEnch + 1;

    await store(newModel);
    return newModel;
  }
}
