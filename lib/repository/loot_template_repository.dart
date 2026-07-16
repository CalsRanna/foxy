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

  Future<void> copyLootTemplate(
    int entry,
    int item, {
    int reference = 0,
    int groupId = 0,
  }) async {
    var source = await getLootTemplate(
      entry,
      item,
      reference: reference,
      groupId: groupId,
    );
    if (source == null) return;
    var json = source.toJson();
    if (tableType == LootTableType.reference) {
      json['Entry'] = await nextMaxPlusOne(_table, 'Entry');
    } else {
      var nextItem = await getNextItemId(entry);
      json['Item'] = nextItem;
      if (source.reference != 0) {
        json['Reference'] = nextItem;
      }
    }
    await laconic.table(_table).insert([json]);
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

  Future<int> countLootTemplates({LootTemplateFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    if (filter != null && filter.entry.isNotEmpty) {
      builder = builder.where('Entry', filter.entry);
    }
    builder = builder.groupBy('Entry');
    return builder.count();
  }

  Future<LootTemplateEntity> createLootTemplate(int entry) async {
    return LootTemplateEntity(entry: entry);
  }

  Future<void> destroyLootTemplate(
    int entry,
    int item, {
    int reference = 0,
    int groupId = 0,
  }) async {
    var builder = laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item);
    builder = _applyAdditionalPrimaryKey(builder, reference, groupId);
    await builder.delete();
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

  Future<List<BriefLootTemplateEntity>> getBriefLootTemplates(int entry) async {
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

  Future<LootTemplateEntity?> getLootTemplate(
    int entry,
    int item, {
    int reference = 0,
    int groupId = 0,
  }) async {
    var builder = laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item);
    builder = _applyAdditionalPrimaryKey(builder, reference, groupId);
    var results = await builder.limit(1).get();
    if (results.isEmpty) return null;
    return LootTemplateEntity.fromJson(results.first.toMap());
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

  Future<void> saveLootTemplate(LootTemplateEntity loot) async {
    var existing = await getLootTemplate(
      loot.entry,
      loot.item,
      reference: loot.reference,
      groupId: loot.groupId,
    );
    if (existing != null) {
      await updateLootTemplate(
        loot.entry,
        loot.item,
        loot,
        reference: loot.reference,
        groupId: loot.groupId,
      );
    } else {
      await storeLootTemplate(loot);
    }
  }

  Future<void> storeLootTemplate(LootTemplateEntity loot) async {
    await _validateReferences(loot);
    await laconic.table(_table).insert([loot.toJson()]);
  }

  Future<void> updateLootTemplate(
    int entry,
    int item,
    LootTemplateEntity loot, {
    int reference = 0,
    int groupId = 0,
  }) async {
    await _validateReferences(loot);
    var json = loot.toJson();
    json.remove('Entry');
    var builder = laconic
        .table(_table)
        .where('Entry', entry)
        .where('Item', item);
    builder = _applyAdditionalPrimaryKey(builder, reference, groupId);
    await builder.update(json);
  }

  QueryBuilder _applyAdditionalPrimaryKey(
    QueryBuilder builder,
    int reference,
    int groupId,
  ) {
    if (tableType != LootTableType.creature) return builder;
    return builder.where('Reference', reference).where('GroupId', groupId);
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

  Future<void> _validateReferences(LootTemplateEntity loot) async {
    if (loot.reference == 0) {
      final item = await laconic
          .table('item_template')
          .select(['entry'])
          .where('entry', loot.item)
          .limit(1)
          .get();
      if (item.isEmpty) {
        throw StateError('物品 ID ${loot.item} 不存在于 item_template');
      }
      return;
    }

    final target = await laconic
        .table(LootTableType.reference.tableName)
        .select(['Entry'])
        .where('Entry', loot.reference.abs())
        .limit(1)
        .get();
    if (target.isEmpty) {
      throw StateError(
        '关联掉落模板 ${loot.reference.abs()} 不存在于 reference_loot_template',
      );
    }
  }

  static Set<String> primaryKeyColumnsFor(LootTableType tableType) =>
      tableType == LootTableType.creature
      ? const {'Entry', 'Item', 'Reference', 'GroupId'}
      : const {'Entry', 'Item'};
}
