import 'package:foxy/model/loot_template.dart';
import 'package:foxy/repository/repository_mixin.dart';

enum LootTableType {
  creature('creature_loot_template'),
  pickpocket('pickpocketing_loot_template'),
  skinning('skinning_loot_template'),
  item('item_loot_template'),
  disenchant('disenchant_loot_template'),
  prospecting('prospecting_loot_template'),
  milling('milling_loot_template'),
  reference('reference_loot_template'),
  gameobject('gameobject_loot_template');

  final String tableName;
  const LootTableType(this.tableName);
}

class LootTemplateRepository with RepositoryMixin {
  final LootTableType tableType;

  LootTemplateRepository(this.tableType);

  String get _table => tableType.tableName;

  Future<int> countLootTemplates({String? entry}) async {
    try {
      var builder = laconic.table(_table);
      builder = builder.select(['DISTINCT Entry']);
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('Entry', entry);
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 获取符合过滤条件的行数计数
  Future<int> countLootTemplateRows({String? entry, String? name}) async {
    try {
      var builder = laconic.table('$_table AS lt');
      builder = builder.leftJoin(
        'item_template AS it',
        (join) => join.on('lt.Item', 'it.entry'),
      );
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
      );
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('lt.Entry', entry);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.whereAny(
          ['it.name', 'itl.Name'],
          '%$name%',
          operator: 'like',
        );
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 获取不同的 Entry 列表（用于选择器）
  Future<List<LootTemplate>> getLootTemplateDistinctEntries({
    String? entry,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      builder = builder.select(['Entry', 'COUNT(*) as ItemCount']);
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('Entry', entry);
      }
      builder = builder.groupBy('Entry');
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => LootTemplate.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 搜索掉落（带物品名称过滤+分页）
  Future<List<LootTemplate>> getLootTemplatesByEntry({
    String? entry,
    String? name,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table('$_table AS lt');
      const fields = [
        'lt.*',
        'it.name',
        'itl.Name AS localeName',
        'it.Quality',
        'didi.InventoryIcon0',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'item_template AS it',
        (join) => join.on('lt.Item', 'it.entry'),
      );
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
      );
      builder = builder.leftJoin(
        'foxy.dbc_item_display_info AS didi',
        (join) => join.on('it.displayid', 'didi.ID'),
      );
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('lt.Entry', entry);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.whereAny(
          ['it.name', 'itl.Name'],
          '%$name%',
          operator: 'like',
        );
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => LootTemplate.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 获取指定 Entry 的所有掉落项（带物品信息）
  Future<List<LootTemplate>> getLootTemplates(int entry) async {
    var builder = laconic.table('$_table AS lt');
    const fields = [
      'lt.*',
      'it.name',
      'itl.Name AS localeName',
      'it.Quality',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('lt.Item', 'it.entry'),
    );
    builder = builder.leftJoin(
      'item_template_locale AS itl',
      (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('lt.Entry', entry);
    var results = await builder.get();
    return results.map((e) => LootTemplate.fromJson(e.toMap())).toList();
  }

  /// 查找单条记录
  Future<LootTemplate?> getLootTemplate(int entry, int item) async {
    var result = await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .first();
    return LootTemplate.fromJson(result.toMap());
  }

  /// 新增掉落
  Future<void> storeLootTemplate(LootTemplate loot) async {
    await laconic.table(_table).insert([loot.toJson()]);
  }

  /// 更新掉落
  Future<void> updateLootTemplate(LootTemplate loot, {int? oldItem}) async {
    var json = loot.toJson();
    json.remove('Entry');
    if (oldItem == null) json.remove('Item');
    await laconic
        .table(_table)
        .where('Entry', loot.entry)
        .where('Item', oldItem ?? loot.item)
        .update(json);
  }

  /// 删除掉落
  Future<void> destroyLootTemplate(int entry, int item) async {
    await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .delete();
  }

  /// 复制掉落（获取新的Item ID）
  Future<LootTemplate> copyLootTemplate(int entry, int item) async {
    // 获取最大Item
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(Item) AS maxItem'])
        .where('Entry', entry)
        .first();
    var maxItem = (maxResult.toMap()['maxItem'] ?? 0) as int;

    // 获取源记录
    var source = await getLootTemplate(entry, item);
    if (source == null) {
      throw Exception('源记录不存在');
    }

    // 创建新记录
    var newLoot = LootTemplate.fromJson(source.toJson());
    newLoot.item = maxItem + 1;
    if (newLoot.reference != 0) {
      newLoot.reference = maxItem + 1;
    }

    await storeLootTemplate(newLoot);
    return newLoot;
  }

  /// 获取下一个可用的Item ID
  Future<int> getNextItemId(int entry) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(Item) AS maxItem'])
        .where('Entry', entry)
        .first();
    var maxItem = (maxResult.toMap()['maxItem'] ?? 0) as int;
    return maxItem + 1;
  }
}
