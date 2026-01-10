import 'package:foxy/model/item_template.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemTemplateRepository with RepositoryMixin {
  static const _table = 'item_template';
  static const _localeTable = 'item_template_locale';

  /// 搜索物品（带本地化名称和图标）
  Future<List<ItemTemplate>> search({
    String? entry,
    String? name,
    int page = 1,
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
        'it.displayid',
        'itl.Name AS localeName',
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
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => ItemTemplate.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({
    String? entry,
    String? name,
  }) async {
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
        'it.Quality',
        'it.class',
        'it.subclass',
        'it.InventoryType',
        'it.ItemLevel',
        'it.RequiredLevel',
        'it.displayid',
        'itl.Name AS localeName',
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
      return result != null ? ItemTemplate.fromJson(result.toMap()) : null;
    } catch (e) {
      return null;
    }
  }
}
