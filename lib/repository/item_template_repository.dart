import 'package:foxy/model/item_template.dart';
import 'package:foxy/model/item_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemTemplateRepository with RepositoryMixin {
  static const _table = 'item_template';
  static const _localeTable = 'item_template_locale';

  Future<int> countItemTemplates({ItemTemplateFilterEntity? filter}) async {
    var builder = laconic.table('$_table AS it');
    builder.select(['it.entry']);
    builder = builder.leftJoin(
      '$_localeTable AS itl',
      (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
    );
    builder = _applyFilter(builder, filter);
    return await builder.count();
  }

  Future<void> copyItemTemplate(int entry) async {
    var template = await getItemTemplate(entry);
    var json = template.toJson();
    var newEntry = await _getNextEntry();
    json['entry'] = newEntry;
    await laconic.table(_table).insert([json]);
  }

  Future<int> _getNextEntry() async {
    var result = await laconic.table(_table).select([
      'MAX(entry) as max_entry',
    ]).first();
    var maxEntry = result.toMap()['max_entry'] as int?;
    return (maxEntry ?? 0) + 1;
  }

  Future<void> destroyItemTemplate(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }

  Future<List<BriefItemTemplate>> getBriefItemTemplates({
    int page = 1,
    ItemTemplateFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS it');
    const fields = [
      'it.entry',
      'it.name',
      'it.Quality',
      'it.class',
      'it.subclass',
      'it.InventoryType',
      'it.ItemLevel',
      'it.RequiredLevel',
      'itl.Name AS localeName',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      '$_localeTable AS itl',
      (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = _applyFilter(builder, filter);
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefItemTemplate.fromJson(e.toMap())).toList();
  }

  Future<ItemTemplate> getItemTemplate(int entry) async {
    var builder = laconic.table('$_table AS it');
    const fields = [
      'it.*',
      'itl.Name AS localeName',
      'itl.Description AS localeDescription',
      'didi.InventoryIcon0',
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      '$_localeTable AS itl',
      (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
    );
    builder = builder.leftJoin(
      'foxy.dbc_item_display_info AS didi',
      (join) => join.on('it.displayid', 'didi.ID'),
    );
    builder = builder.where('it.entry', entry);
    var result = await builder.first();
    return ItemTemplate.fromJson(result.toMap());
  }

  Future<int> getNextEntry() async {
    var result = await laconic.table(_table).select([
      'MAX(entry) as max_entry',
    ]).first();
    var maxEntry = result.toMap()['max_entry'] as int?;
    return (maxEntry ?? 0) + 1;
  }

  Future<void> storeItemTemplate(ItemTemplate template) async {
    await laconic.table(_table).insert([template.toJson()]);
  }

  Future<void> updateItemTemplate(ItemTemplate template) async {
    var json = template.toJson();
    json.remove('entry');
    await laconic.table(_table).where('entry', template.entry).update(json);
  }

  dynamic _applyFilter(dynamic builder, ItemTemplateFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.entry.isNotEmpty) {
      builder = builder.where('it.entry', filter.entry);
    }
    if (filter.name.isNotEmpty) {
      builder = builder.whereAny(
        ['it.name', 'itl.Name'],
        '%${filter.name}%',
        operator: 'like',
      );
    }
    if (filter.description.isNotEmpty) {
      builder = builder.whereAny(
        ['it.description', 'itl.Description'],
        '%${filter.description}%',
        operator: 'like',
      );
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
