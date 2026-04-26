import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/model/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GossipMenuRepository with RepositoryMixin {
  static const _table = 'gossip_menu';

  Future<void> copyGossipMenu(Map<String, dynamic> id) async {
    final original = await getGossipMenu(id);
    if (original == null) return;
    final next = await getNextMenuId();
    original.menuId = next.menuId;
    await storeGossipMenu(original);
  }

  Future<GossipMenu> getNextMenuId() async {
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

  Future<void> destroyGossipMenu(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }

  Future<List<BriefGossipMenu>> getBriefGossipMenus({
    int page = 1,
    GossipMenuFilterEntity? filter,
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
      return results.map((e) => BriefGossipMenu.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<GossipMenu?> getGossipMenu(Map<String, dynamic> id) async {
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

  Future<void> storeGossipMenu(GossipMenu model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> updateGossipMenu(
    Map<String, dynamic> id,
    GossipMenu model,
  ) async {
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
