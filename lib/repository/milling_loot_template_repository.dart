import 'package:foxy/entity/milling_loot_template_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'milling_loot_template_repository.g.dart';

@FoxyRepository(MillingLootTemplateEntity, linkKey: ['entry'])
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class MillingLootTemplateRepository
    with RepositoryMixin, _MillingLootTemplateRepositoryMixin {
  static const _table = 'milling_loot_template';
  static const primaryKeyColumns = {'Entry', 'Item'};

  @override
  Future<MillingLootTemplateKey> copyMillingLootTemplate(
    MillingLootTemplateKey key,
  ) async {
    final source = await getMillingLootTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(item: await getNextItemId(source.entry));
    await storeMillingLootTemplate(copied);
    return MillingLootTemplateKey.fromEntity(copied);
  }

  Future<int> countLootTemplateRows({MillingLootTemplateFilter? filter}) async {
    final needsNameJoin = filter != null && filter.name.isNotEmpty;
    if (!needsNameJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.entry.isNotEmpty) {
        builder = builder.where('Entry', int.tryParse(filter.entry) ?? 0);
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

  @override
  Future<int> countMillingLootTemplates(int entry) {
    return laconic.table(_table).where('Entry', entry).count();
  }

  @override
  Future<MillingLootTemplateEntity> createMillingLootTemplate(int entry) async {
    return MillingLootTemplateEntity(entry: entry);
  }

  Future<List<BriefMillingLootTemplateEntity>> getBriefLootTemplateRows({
    MillingLootTemplateFilter? filter,
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
        .map((e) => BriefMillingLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  @override
  Future<List<BriefMillingLootTemplateEntity>> getBriefMillingLootTemplates(
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
        .map((e) => BriefMillingLootTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> getNextItemId(int entry) =>
      nextMaxPlusOne(_table, 'Item', where: {'Entry': entry});

  QueryBuilder _applyRowFilter(
    QueryBuilder builder,
    MillingLootTemplateFilter? filter,
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
