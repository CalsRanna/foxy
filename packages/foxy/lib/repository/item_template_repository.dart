import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_template_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class ItemTemplateRepository
    with RepositoryMixin, _ItemTemplateRepositoryMixin {
  static const _localeTable = 'item_template_locale';

  @override
  Future<int> copyItemTemplate(int key) async {
    final source = await getItemTemplate(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(
      entry: await nextMaxPlusOne(_table, 'entry'),
    );
    await storeItemTemplate(copied);
    return copied.entry;
  }

  @override
  Future<int> countItemTemplates({ItemTemplateFilter? filter}) async {
    final needsLocaleJoin =
        localeEnabled && filter != null && filter.name.isNotEmpty;
    if (!needsLocaleJoin) {
      var builder = laconic.table(_table);
      if (filter != null) {
        if (filter.entry.isNotEmpty) {
          builder = builder.where('entry', int.tryParse(filter.entry) ?? 0);
        }
        if (filter.name.isNotEmpty) {
          builder = builder.where(
            'name',
            '%${escapeLike(filter.name)}%',
            comparator: 'like',
          );
        }
      }
      return builder.count();
    }
    var builder = laconic.table('$_table as it');
    builder = builder.leftJoin(
      '$_localeTable as itl',
      (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  @override
  Future<ItemTemplateEntity> createItemTemplate() async {
    return ItemTemplateEntity(entry: await nextMaxPlusOne(_table, 'entry'));
  }

  @override
  Future<List<BriefItemTemplateEntity>> getBriefItemTemplates({
    int page = 1,
    ItemTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table as it');
    final fields = <String>[
      'it.entry',
      'it.name',
      'it.Quality',
      'it.subclass',
      'it.InventoryType',
      'it.ItemLevel',
      'it.RequiredLevel',
      if (localeEnabled) 'itl.Name as localeName',
      'it.class as classId',
      'didi.InventoryIcon0 as inventoryIcon',
    ];
    builder = builder.select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        '$_localeTable as itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info as didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('it.entry');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemTemplateEntity.fromJson(e.toMap()))
        .toList();
  }

  @override
  Future<List<ItemTemplateEntity>> getItemTemplates() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => ItemTemplateEntity.fromJson(e.toMap())).toList();
  }

  @override
  QueryBuilder _applyFilter(QueryBuilder builder, ItemTemplateFilter? filter) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('it.entry', int.tryParse(filter.entry) ?? 0);
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
}
