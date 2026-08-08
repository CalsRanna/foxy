import 'package:foxy/entity/disenchant_loot_template_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'disenchant_loot_template_repository.g.dart';

@FoxyRepository(linkKey: ['entry'], autoIncrementKey: 'item')
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class DisenchantLootTemplateRepository
    with RepositoryMixin, _DisenchantLootTemplateRepositoryMixin {
  static const _table = 'disenchant_loot_template';
  static const primaryKeyColumns = {'Entry', 'Item'};

  @override
  Future<DisenchantLootTemplateKey> copyDisenchantLootTemplate(
    DisenchantLootTemplateKey key,
  ) async {
    final source = await getDisenchantLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(item: await getNextItemId(source.entry));
    await storeDisenchantLootTemplate(copied);
    return DisenchantLootTemplateKey.fromEntity(copied);
  }

  Future<int> countLootTemplateRows({
    DisenchantLootTemplateFilter? filter,
  }) async {
    final needsNameJoin = filter != null && filter.name.isNotEmpty;
    if (!needsNameJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.entry.isNotEmpty) {
        builder = builder.where('Entry', int.tryParse(filter.entry) ?? 0);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table as lt');
    builder = builder.leftJoin(
      'item_template as it',
      (join) => join.on('lt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = _applyRowFilter(builder, filter);
    return builder.count();
  }

  @override
  Future<int> countDisenchantLootTemplates(int entry) {
    return laconic.table(_table).where('Entry', entry).count();
  }

  @override
  Future<DisenchantLootTemplateEntity> createDisenchantLootTemplate(
    int entry,
  ) async {
    return DisenchantLootTemplateEntity(entry: entry);
  }

  Future<List<BriefDisenchantLootTemplateEntity>> getBriefLootTemplateRows({
    DisenchantLootTemplateFilter? filter,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as lt');
    final fields = <String>[
      ..._briefFields('lt'),
      'it.name as itemName',
      if (localeEnabled) 'itl.Name as itemLocaleName',
      'it.Quality as itemQuality',
      'didi.InventoryIcon0 as itemIcon',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template as it',
      (join) => join.on('lt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = _applyRowFilter(builder, filter);
    builder = builder.orderBy('lt.Entry').orderBy('lt.Item');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefDisenchantLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  @override
  Future<List<BriefDisenchantLootTemplateEntity>>
  getBriefDisenchantLootTemplates(int entry, {int page = 1}) async {
    var builder = laconic.table('$_table as lt');
    final fields = <String>[
      ..._briefFields('lt'),
      'it.name as itemName',
      if (localeEnabled) 'itl.Name as itemLocaleName',
      'it.Quality as itemQuality',
      'didi.InventoryIcon0 as itemIcon',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'item_template as it',
      (join) => join.on('lt.Item', 'it.entry'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'item_template_locale as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('lt.Entry', entry);
    builder = builder.orderBy('lt.Item');
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    var results = await builder.get();
    return results
        .map((e) => BriefDisenchantLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> getNextItemId(int entry) =>
      nextMaxPlusOne(_table, 'Item', where: {'Entry': entry});

  QueryBuilder _applyRowFilter(
    QueryBuilder builder,
    DisenchantLootTemplateFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('lt.Entry', int.tryParse(filter.entry) ?? 0);
    }
    if (filter.name.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['it.name', 'itl.Name'],
          '%${escapeLike(filter.name)}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'it.name',
          '%${escapeLike(filter.name)}%',
          comparator: 'like',
        );
      }
    }
    return builder;
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
}
