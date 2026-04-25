import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/model/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// gossip_menu 表的数据访问层
///
/// 复合主键: (MenuID, TextID)
/// 列表查询通过 LEFT JOIN npc_text + npc_text_locale 得到展示文本。
class GossipMenuRepository with RepositoryMixin {
  static const _table = 'gossip_menu';

  /// 搜索列表（带筛选和分页）
  Future<List<GossipMenu>> search({
    GossipMenuFilterEntity? filter,
    int page = 1,
  }) async {
    return paginate(filter: filter, page: page);
  }

  /// 分页查询
  Future<List<GossipMenu>> paginate({
    GossipMenuFilterEntity? filter,
    required int page,
  }) async {
    try {
      final offset = (page - 1) * kPageSize;
      var builder = laconic.table('$_table AS gm');
      const fields = [
        'gm.MenuID',
        'gm.TextID',
        'nt.text0_0',
        'nt.text0_1',
        'ntl.Text0_0',
        'ntl.Text0_1',
      ];
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'npc_text AS nt',
        (join) => join.on('gm.TextID', 'nt.ID'),
      );
      builder = builder.leftJoin(
        'npc_text_locale AS ntl',
        (join) => join.on('gm.TextID', 'ntl.ID').on('ntl.Locale', '"zhCN"'),
      );
      builder = _applyFilter(builder, filter);
      builder = builder.limit(kPageSize).offset(offset);
      final results = await builder.get();
      return results.map((e) => GossipMenu.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({GossipMenuFilterEntity? filter}) async {
    try {
      var builder = laconic.table('$_table AS gm');
      builder = builder.leftJoin(
        'npc_text AS nt',
        (join) => join.on('gm.TextID', 'nt.ID'),
      );
      builder = builder.leftJoin(
        'npc_text_locale AS ntl',
        (join) => join.on('gm.TextID', 'ntl.ID').on('ntl.Locale', '"zhCN"'),
      );
      builder = _applyFilter(builder, filter);
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 根据复合键查找（id 应为 {'MenuID': x, 'TextID': y}）
  Future<GossipMenu?> find(Map<String, dynamic> id) async {
    try {
      var builder = laconic.table(_table);
      id.forEach((k, v) {
        builder = builder.where(k, v);
      });
      final result = await builder.first();
      return GossipMenu.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// 创建：返回下一个可用 MenuID 的空白对象（不落库）
  Future<GossipMenu> create() async {
    try {
      final result = await laconic.table(_table).select([
        'MAX(MenuID) as max_id',
      ]).first();
      final maxId = result.toMap()['max_id'] as int?;
      final model = GossipMenu();
      model.menuId = (maxId ?? 0) + 1;
      model.textId = 0;
      return model;
    } catch (e) {
      final model = GossipMenu();
      model.menuId = 1;
      return model;
    }
  }

  /// 更新（根据复合键）
  Future<void> update(Map<String, dynamic> id, GossipMenu model) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    final json = model.toJson();
    for (final k in id.keys) {
      json.remove(k);
    }
    await builder.update(json);
  }

  /// 存储（insert）
  Future<void> store(GossipMenu model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  /// 删除（根据复合键）
  Future<void> destroy(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }

  /// 复制（仅主表，不级联子表）：取新 MenuID = MAX+1
  Future<void> copy(Map<String, dynamic> id) async {
    final original = await find(id);
    if (original == null) return;
    final next = await create();
    original.menuId = next.menuId;
    await store(original);
  }

  /// 应用筛选条件到 query builder
  dynamic _applyFilter(dynamic builder, GossipMenuFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.menuId.isNotEmpty) {
      builder = builder.where('gm.MenuID', filter.menuId);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['nt.text0_0', 'nt.text0_1', 'ntl.Text0_0', 'ntl.Text0_1'],
        '%${filter.text}%',
        operator: 'like',
      );
    }
    return builder;
  }
}
