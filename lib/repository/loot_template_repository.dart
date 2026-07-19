import 'package:foxy/entity/brief_loot_template_entity.dart';
import 'package:foxy/entity/brief_loot_template_entry_entity.dart';
import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_entity.dart';
import 'package:foxy/entity/loot_template_filter_entity.dart';
import 'package:foxy/entity/loot_template_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class LootTemplateRepository with RepositoryMixin {
  final LootTableType tableType;

  LootTemplateRepository(this.tableType);

  String get _table => tableType.tableName;

  Future<void> copyLootTemplate(LootTemplateKey key) async {
    final source = await getLootTemplate(key);
    if (source == null) return;
    final copied = tableType == LootTableType.reference
        ? source.copyWith(entry: await nextMaxPlusOne(_table, 'Entry'))
        : source.copyWith(item: await getNextItemId(source.entry));
    await storeLootTemplate(copied);
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

  Future<int> countLootTemplatesForEntry(int entry) {
    return laconic.table(_table).where('Entry', entry).count();
  }

  Future<LootTemplateEntity> createLootTemplate(int entry) async {
    return LootTemplateEntity(entry: entry);
  }

  Future<void> destroyLootTemplate(LootTemplateKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  /// Distinct entry groups for pickers.
  Future<List<BriefLootTemplateEntryEntity>> getBriefLootTemplateEntries({
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
        .map((e) => BriefLootTemplateEntryEntity.fromJson(e.toMap()))
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
      ..._briefFields('lt'),
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
        .map(
          (e) =>
              BriefLootTemplateEntity.fromJson(e.toMap(), tableType: tableType),
        )
        .toList();
  }

  Future<List<BriefLootTemplateEntity>> getBriefLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS lt');
    final fields = <String>[
      ..._briefFields('lt'),
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
    builder = builder.orderBy('lt.Item');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    var results = await builder.get();
    return results
        .map(
          (e) =>
              BriefLootTemplateEntity.fromJson(e.toMap(), tableType: tableType),
        )
        .toList();
  }

  Future<LootTemplateEntity?> getLootTemplate(LootTemplateKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return LootTemplateEntity.fromJson(results.first.toMap());
  }

  Future<int> getNextItemId(int entry) =>
      nextMaxPlusOne(_table, 'Item', where: {'Entry': entry});

  Future<void> storeLootTemplate(LootTemplateEntity loot) async {
    try {
      await laconic.table(_table).insert([loot.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('掉落模板主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateLootTemplate(
    LootTemplateKey originalKey,
    LootTemplateEntity loot,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(loot.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在，无法保存');
      }
      rethrow;
    }
  }

  List<String> _briefFields(String alias) => [
    '$alias.Entry',
    '$alias.Item',
    '$alias.Reference',
    '$alias.Chance',
    '$alias.QuestRequired',
    '$alias.GroupId',
    '$alias.MinCount',
    '$alias.MaxCount',
  ];

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

  QueryBuilder _whereKey(QueryBuilder builder, LootTemplateKey key) {
    builder = builder.where('Entry', key.entry).where('Item', key.item);
    if (tableType == LootTableType.creature) {
      if (key is! CreatureLootTemplateKey) {
        throw ArgumentError.value(key, 'key', '生物掉落需要四列行定位器');
      }
      return builder
          .where('Reference', key.reference)
          .where('GroupId', key.groupId);
    }
    if (key is! StandardLootTemplateKey) {
      throw ArgumentError.value(key, 'key', '当前掉落表需要两列行定位器');
    }
    return builder;
  }

  static Set<String> primaryKeyColumnsFor(LootTableType tableType) =>
      tableType == LootTableType.creature
      ? const {'Entry', 'Item', 'Reference', 'GroupId'}
      : const {'Entry', 'Item'};
}
