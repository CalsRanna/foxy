import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/entity/item_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemTemplateRepository with RepositoryMixin {
  static const _table = 'item_template';
  static const _localeTable = 'item_template_locale';

  Future<List<BriefItemTemplateEntity>> getBriefItemTemplates({
    int page = 1,
    ItemTemplateFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS it');
    final fields = <String>[
      'it.entry',
      'it.name',
      'it.Quality',
      'it.class',
      'it.subclass',
      'it.InventoryType',
      'it.ItemLevel',
      'it.RequiredLevel',
      if (localeEnabled) 'itl.Name AS localeName',
      'didi.InventoryIcon0',
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

  Future<List<ItemTemplateEntity>> getItemTemplates() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => ItemTemplateEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countItemTemplates({ItemTemplateFilterEntity? filter}) async {
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

  Future<ItemTemplateEntity?> getItemTemplate(int entry) async {
    var builder = laconic.table('$_table AS it');
    final fields = <String>[
      'it.*',
      if (localeEnabled) ...[
        'itl.Name AS localeName',
        'itl.Description AS localeDescription',
      ],
      'didi.InventoryIcon0',
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
    builder = builder.where('it.entry', entry).limit(1);
    var results = await builder.get();
    if (results.isEmpty) return null;
    return ItemTemplateEntity.fromJson(results.first.toMap());
  }

  Future<ItemTemplateEntity> createItemTemplate() async {
    return ItemTemplateEntity(entry: await _getNextEntry());
  }

  Future<int> storeItemTemplate(ItemTemplateEntity template) async {
    template.validate();
    var json = template.toJson();
    final newEntry = template.entry > 0
        ? template.entry
        : await _getNextEntry();
    json['entry'] = newEntry;
    await laconic.table(_table).insert([json]);
    return newEntry;
  }

  Future<void> updateItemTemplate(ItemTemplateEntity template) async {
    template.validate();
    var json = template.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', template.entry).update(json);
  }

  Future<void> destroyItemTemplate(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<void> copyItemTemplate(int entry) async {
    var template = await getItemTemplate(entry);
    if (template == null) return;
    var json = template.toJson();
    var newEntry = await _getNextEntry();
    json['entry'] = newEntry;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveItemTemplate(ItemTemplateEntity template) async {
    template.validate();
    if (template.entry == 0) {
      await storeItemTemplate(template);
      return;
    }
    var existing = await getItemTemplate(template.entry);
    if (existing != null) {
      await updateItemTemplate(template);
    } else {
      await laconic.table(_table).insert([template.toJson()]);
    }
  }

  Future<int> _getNextEntry() async {
    return nextMaxPlusOne(_table, 'entry');
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemTemplateFilterEntity? filter,
  ) {
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
}
