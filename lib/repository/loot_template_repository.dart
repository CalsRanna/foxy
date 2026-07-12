import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/loot_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

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

  Future<List<BriefLootTemplateEntity>> getBriefLootTemplates(
    int entry,
  ) async {
    var builder = laconic.table('$_table AS lt');
    final fields = <String>[
      'lt.*',
      'it.name',
      if (localeEnabled) 'itl.Name AS localeName',
      'it.Quality',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('lt.Item', 'it.entry'),
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
    builder = builder.where('lt.Entry', entry);
    var results = await builder.get();
    return results
        .map((e) => BriefLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  /// Paginated search for list pages / pickers (row-level with item name).
  Future<List<BriefLootTemplateEntity>> getBriefLootTemplateRows({
    LootTemplateFilterEntity? filter,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS lt');
    final fields = <String>[
      'lt.*',
      'it.name',
      if (localeEnabled) 'itl.Name AS localeName',
      'it.Quality',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('lt.Item', 'it.entry'),
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
    builder = _applyRowFilter(builder, filter);
    builder = builder.orderBy('lt.Entry').orderBy('lt.Item');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  /// Distinct entry groups for pickers.
  Future<List<BriefLootTemplateEntity>> getBriefLootTemplateEntries({
    LootTemplateFilterEntity? filter,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['Entry', 'COUNT(*) as ItemCount']);
    if (filter != null && filter.entry.isNotEmpty) {
      builder = builder.where('Entry', filter.entry);
    }
    builder = builder.groupBy('Entry');
    builder = builder.orderBy('Entry');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countLootTemplates({LootTemplateFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = builder.select(['DISTINCT Entry']);
    if (filter != null && filter.entry.isNotEmpty) {
      builder = builder.where('Entry', filter.entry);
    }
    return builder.count();
  }

  Future<int> countLootTemplateRows({LootTemplateFilterEntity? filter}) async {
    final needsNameJoin = filter != null && filter.name.isNotEmpty;
    if (!needsNameJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.entry.isNotEmpty) {
        builder = builder.where('Entry', filter.entry);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS lt');
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('lt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = _applyRowFilter(builder, filter);
    return builder.count();
  }

  Future<LootTemplateEntity?> getLootTemplate(int entry, int item) async {
    var results = await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return LootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<LootTemplateEntity> createLootTemplate(int entry) async {
    var nextItem = await getNextItemId(entry);
    return LootTemplateEntity(entry: entry, item: nextItem);
  }

  Future<void> storeLootTemplate(LootTemplateEntity loot) async {
    await laconic.table(_table).insert([loot.toJson()]);
  }

  Future<void> updateLootTemplate(
    int entry,
    int item,
    LootTemplateEntity loot,
  ) async {
    var json = loot.toJson();
    json.remove('Entry');
    // allow Item change in payload
    await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .update(json);
  }

  Future<void> destroyLootTemplate(int entry, int item) async {
    await laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item)
        .delete();
  }

  Future<void> copyLootTemplate(int entry, int item) async {
    var source = await getLootTemplate(entry, item);
    if (source == null) return;
    var nextItem = await getNextItemId(entry);
    var json = source.toJson();
    json['Item'] = nextItem;
    if (source.reference != 0) {
      json['Reference'] = nextItem;
    }
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveLootTemplate(LootTemplateEntity loot) async {
    var existing = await getLootTemplate(loot.entry, loot.item);
    if (existing != null) {
      await updateLootTemplate(loot.entry, loot.item, loot);
    } else {
      await storeLootTemplate(loot);
    }
  }

  Future<int> getNextItemId(int entry) async {
    var maxResult = await laconic
        .table(_table)
        .select(['MAX(Item) AS maxItem'])
        .where('Entry', entry)
        .first();
    var maxItem = (maxResult.toMap()['maxItem'] ?? 0) as int;
    return maxItem + 1;
  }

  QueryBuilder _applyRowFilter(
    QueryBuilder builder,
    LootTemplateFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('lt.Entry', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['it.name', 'itl.Name'],
          '%${filter.name}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'it.name',
          '%${filter.name}%',
          comparator: 'like',
        );
      }
    }
    return builder;
  }
}