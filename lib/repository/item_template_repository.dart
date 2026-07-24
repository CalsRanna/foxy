import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_template_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'ItemTemplateFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'entry',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'name',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'description',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'classId',
      type: FoxyFilterFieldType.integer,
      defaultValue: -1,
    ),
    FoxyRepositoryFilterField(
      name: 'subclass',
      type: FoxyFilterFieldType.integer,
      defaultValue: -1,
    ),
  ],
)
class ItemTemplateRepository with RepositoryMixin {
  static const _table = 'item_template';
  static const _localeTable = 'item_template_locale';

  Future<int> copyItemTemplate(int key) async {
    final source = await getItemTemplate(key);
    if (source == null) {
      throw StateError('原物品模板不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(
      entry: await nextMaxPlusOne(_table, 'entry'),
    );
    await storeItemTemplate(copied);
    return copied.entry;
  }

  Future<int> countItemTemplates({ItemTemplateFilter? filter}) async {
    final needsLocaleJoin =
        localeEnabled &&
        filter != null &&
        (filter.name.isNotEmpty || filter.description.isNotEmpty);
    if (!needsLocaleJoin) {
      var builder = laconic.table(_table);
      if (filter != null) {
        if (filter.entry.isNotEmpty) {
          builder = builder.where('entry', filter.entry);
        }
        if (filter.classId >= 0) {
          builder = builder.where('class', filter.classId);
        }
        if (filter.subclass >= 0) {
          builder = builder.where('subclass', filter.subclass);
        }
        if (filter.name.isNotEmpty) {
          builder = builder.where(
            'name',
            '%${filter.name}%',
            comparator: 'like',
          );
        }
        if (filter.description.isNotEmpty) {
          builder = builder.where(
            'description',
            '%${filter.description}%',
            comparator: 'like',
          );
        }
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS it');
    builder = builder.leftJoin(
      '$_localeTable AS itl',
      (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
    );
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemTemplateEntity> createItemTemplate() async {
    return ItemTemplateEntity(entry: await nextMaxPlusOne(_table, 'entry'));
  }

  Future<void> destroyItemTemplate(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原物品模板不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefItemTemplateEntity>> getBriefItemTemplates({
    int page = 1,
    ItemTemplateFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS it');
    final fields = <String>[
      'it.entry',
      'it.name',
      'it.Quality',
      'it.subclass',
      'it.InventoryType',
      'it.ItemLevel',
      'it.RequiredLevel',
      if (localeEnabled) 'itl.Name AS localeName',
      'it.class AS classId',
      'didi.InventoryIcon0 AS inventoryIcon',
    ];
    builder = builder.select(fields);
    if (localeEnabled) {
      builder = builder.leftJoin(
        '$_localeTable AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
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

  Future<ItemTemplateEntity?> getItemTemplate(int key) async {
    var builder = laconic.table(_table);
    builder = builder.where('entry', key).limit(1);
    var results = await builder.get();
    if (results.isEmpty) return null;
    return ItemTemplateEntity.fromJson(results.first.toMap());
  }

  Future<List<ItemTemplateEntity>> getItemTemplates() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => ItemTemplateEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeItemTemplate(ItemTemplateEntity template) async {
    if (template.entry <= 0) {
      throw StateError('物品模板 entry 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([template.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('物品模板 ${template.entry} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemTemplate(
    int originalKey,
    ItemTemplateEntity template,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(template.toJson());
      if (matchedRows == 0) {
        throw StateError('原物品模板不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的物品模板 entry 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, ItemTemplateFilter? filter) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('it.entry', filter.entry);
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
    if (filter.description.isNotEmpty) {
      if (localeEnabled) {
        builder = builder.whereAny(
          ['it.description', 'itl.Description'],
          '%${filter.description}%',
          comparator: 'like',
        );
      } else {
        builder = builder.where(
          'it.description',
          '%${filter.description}%',
          comparator: 'like',
        );
      }
    }
    if (filter.classId >= 0) {
      builder = builder.where('it.class', filter.classId);
    }
    if (filter.subclass >= 0) {
      builder = builder.where('it.subclass', filter.subclass);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('entry', key);
  }
}
