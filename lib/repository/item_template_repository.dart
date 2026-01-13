import 'package:foxy/model/brief_item_template.dart';
import 'package:foxy/model/item_template.dart';
import 'package:foxy/model/item_template_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemTemplateRepository with RepositoryMixin {
  static const _table = 'item_template';
  static const _localeTable = 'item_template_locale';

  /// 搜索物品（带本地化名称和图标）
  Future<List<ItemTemplate>> search({
    String? entry,
    String? name,
    String? description,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table('$_table AS it');
      const fields = [
        'it.entry',
        'it.name',
        'it.description',
        'it.Quality',
        'it.class',
        'it.subclass',
        'it.InventoryType',
        'it.ItemLevel',
        'it.RequiredLevel',
        'it.displayid',
        'itl.Name AS localeName',
        'itl.Description AS localeDescription',
        'didi.InventoryIcon_1',
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
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('it.entry', entry);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.whereAny(
          ['it.name', 'itl.Name'],
          '%$name%',
          operator: 'like',
        );
      }
      if (description != null && description.isNotEmpty) {
        builder = builder.whereAny(
          ['it.description', 'itl.Description'],
          '%$description%',
          operator: 'like',
        );
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => ItemTemplate.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({String? entry, String? name, String? description}) async {
    try {
      var builder = laconic.table('$_table AS it');
      builder = builder.leftJoin(
        '$_localeTable AS itl',
        (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
      );
      if (entry != null && entry.isNotEmpty) {
        builder = builder.where('it.entry', entry);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.whereAny(
          ['it.name', 'itl.Name'],
          '%$name%',
          operator: 'like',
        );
      }
      if (description != null && description.isNotEmpty) {
        builder = builder.whereAny(
          ['it.description', 'itl.Description'],
          '%$description%',
          operator: 'like',
        );
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 获取物品简要列表（用于列表展示）
  Future<List<BriefItemTemplate>> getBriefItemTemplates({
    int page = 1,
    ItemTemplateFilterEntity? filter,
  }) async {
    try {
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
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        '$_localeTable AS itl',
        (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
      );
      if (filter != null) {
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
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => BriefItemTemplate.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数（支持筛选实体）
  Future<int> countWithFilter({ItemTemplateFilterEntity? filter}) async {
    try {
      var builder = laconic.table('$_table AS it');
      builder = builder.leftJoin(
        '$_localeTable AS itl',
        (join) => join.on('it.entry', 'itl.ID').on('itl.locale', '"zhCN"'),
      );
      if (filter != null) {
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
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 根据entry获取单个物品
  Future<ItemTemplate?> find(int entry) async {
    try {
      var builder = laconic.table('$_table AS it');
      const fields = [
        'it.entry',
        'it.name',
        'it.description',
        'it.Quality',
        'it.class',
        'it.subclass',
        'it.InventoryType',
        'it.ItemLevel',
        'it.RequiredLevel',
        'it.displayid',
        'itl.Name AS localeName',
        'itl.Description AS localeDescription',
        'didi.InventoryIcon_1',
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
    } catch (e) {
      return null;
    }
  }

  /// 获取单个物品
  Future<ItemTemplate> getItemTemplate(int entry) async {
    var result = await laconic.table(_table).where('entry', entry).first();
    return ItemTemplate.fromJson(result.toMap());
  }

  /// 获取下一个可用的 entry
  Future<int> _getNextEntry() async {
    var result = await laconic.table(_table).select([
      'MAX(entry) as max_entry',
    ]).first();
    var maxEntry = result.toMap()['max_entry'] as int?;
    return (maxEntry ?? 0) + 1;
  }

  /// 复制物品模板
  Future<void> copyItemTemplate(int entry) async {
    var template = await getItemTemplate(entry);
    var json = template.toJson();
    var newEntry = await _getNextEntry();
    json['entry'] = newEntry;
    await laconic.table(_table).insert([json]);
  }

  /// 删除物品模板
  Future<void> destroyItemTemplate(int entry) async {
    await laconic.table(_table).where('entry', entry).delete();
  }
}
