import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/prospecting_loot_template_entity.dart';
import 'package:foxy/entity/brief_prospecting_loot_template_entry_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'prospecting_loot_template_repository.g.dart';

@FoxyRepository(ProspectingLootTemplateEntity)
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class ProspectingLootTemplateRepository
    with RepositoryMixin, _ProspectingLootTemplateRepositoryMixin {
  static const _table = 'prospecting_loot_template';
  static const primaryKeyColumns = {'Entry', 'Item'};

  Future<void> copyLootTemplate(ProspectingLootTemplateKey key) async {
    final source = await getProspectingLootTemplate(key);
    if (source == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(item: await getNextItemId(source.entry));
    await storeProspectingLootTemplate(copied);
  }

  Future<int> countLootTemplateRows({
    ProspectingLootTemplateFilter? filter,
  }) async {
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

  Future<int> countLootTemplates({
    ProspectingLootTemplateFilter? filter,
  }) async {
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

  Future<ProspectingLootTemplateEntity> createLootTemplate(int entry) async {
    return ProspectingLootTemplateEntity(entry: entry);
  }

  Future<List<BriefProspectingLootTemplateEntryEntity>>
  getBriefLootTemplateEntries({
    ProspectingLootTemplateFilter? filter,
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
        .map((e) => BriefProspectingLootTemplateEntryEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<BriefProspectingLootTemplateEntity>> getBriefLootTemplateRows({
    ProspectingLootTemplateFilter? filter,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS lt');
    final fields = <String>[
      ..._briefFields('lt'),
      'it.name AS itemName',
      if (localeEnabled) 'itl.Name AS itemLocaleName',
      'it.Quality AS itemQuality',
      'didi.InventoryIcon0 AS itemIcon',
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
        .map((e) => BriefProspectingLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<BriefProspectingLootTemplateEntity>> getBriefLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    var builder = laconic.table('$_table AS lt');
    final fields = <String>[
      ..._briefFields('lt'),
      'it.name AS itemName',
      if (localeEnabled) 'itl.Name AS itemLocaleName',
      'it.Quality AS itemQuality',
      'didi.InventoryIcon0 AS itemIcon',
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
        .map((e) => BriefProspectingLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> getNextItemId(int entry) =>
      nextMaxPlusOne(_table, 'Item', where: {'Entry': entry});

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
    ProspectingLootTemplateFilter? filter,
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
