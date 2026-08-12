import 'package:foxy/entity/dbc_item_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:foxy/repository/dbc_item_repository.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:get_it/get_it.dart';
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

  /// Mirrors the Item.dbc columns into foxy.dbc_item so the exported
  /// Item.dbc contains every server item (the client shows "?" icons for
  /// entries missing from Item.dbc).
  ///
  /// item_template is the source of truth. All three writes are best-effort:
  /// the foxy schema may not exist before the first DBC import, and a sync
  /// failure must never fail the primary item_template save.
  @override
  Future<int> storeItemTemplate(ItemTemplateEntity itemTemplate) async {
    final storedKey = await super.storeItemTemplate(itemTemplate);
    // Use the returned key: the generated duplicate retry may re-key.
    await _syncDbcItem(itemTemplate, id: storedKey);
    return storedKey;
  }

  @override
  Future<void> updateItemTemplate(
    int originalKey,
    ItemTemplateEntity itemTemplate,
  ) async {
    await super.updateItemTemplate(originalKey, itemTemplate);
    if (originalKey != itemTemplate.entry) {
      // The entry was renumbered: the DBC row under the old key is now
      // orphaned and must follow the item to its new ID.
      await _destroyDbcItemBestEffort(originalKey);
    }
    await _syncDbcItem(itemTemplate);
  }

  @override
  Future<void> destroyItemTemplate(int key) async {
    await super.destroyItemTemplate(key);
    await _destroyDbcItemBestEffort(key);
  }

  /// Upserts the Item.dbc columns for [item] into foxy.dbc_item.
  ///
  /// Existence is checked first: storeDbcItem's generated duplicate retry
  /// would silently re-key to the next free ID instead of updating.
  Future<void> _syncDbcItem(ItemTemplateEntity item, {int? id}) async {
    try {
      final dbcItem = _toDbcItem(item, id: id ?? item.entry);
      final repository = GetIt.instance.get<DbcItemRepository>();
      if (await repository.getDbcItem(dbcItem.id) == null) {
        await repository.storeDbcItem(dbcItem);
      } else {
        await repository.updateDbcItem(dbcItem.id, dbcItem);
      }
    } catch (error, stackTrace) {
      LoggerUtil.instance.e(
        '同步 Item.dbc 失败 (entry=${item.entry})',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Removes the DBC row for [key]; a missing row is fine. Never throws.
  Future<void> _destroyDbcItemBestEffort(int key) async {
    try {
      await GetIt.instance.get<DbcItemRepository>().destroyDbcItem(key);
    } on RecordNotFoundException {
      // The DBC row never existed (e.g. legacy item); nothing to remove.
    } catch (error, stackTrace) {
      LoggerUtil.instance.e(
        '删除 Item.dbc 条目失败 (entry=$key)',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Maps the Item.dbc columns from the authoritative item_template row.
  DbcItemEntity _toDbcItem(ItemTemplateEntity item, {required int id}) {
    return DbcItemEntity(
      id: id,
      classId: item.className,
      subclassId: item.subclass,
      soundOverrideSubclassId: item.soundOverrideSubclass,
      material: item.material,
      displayInfoId: item.displayId,
      inventoryType: item.inventoryType,
      sheatheType: item.sheath,
    );
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
            '%${ParseUtil.escapeLike(filter.name)}%',
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
          '%${ParseUtil.escapeLike(filter.name)}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'it.name',
          '%${ParseUtil.escapeLike(filter.name)}%',
          comparator: 'like',
        );
      }
    }
    return builder;
  }
}
