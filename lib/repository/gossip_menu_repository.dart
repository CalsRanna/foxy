import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GossipMenuRepository with RepositoryMixin {
  static const _table = 'gossip_menu';

  Future<void> copyGossipMenu(int menuId, int textId) async {
    final original = await getGossipMenu(menuId, textId);
    final json = original.toJson();
    json['MenuID'] = await getNextMenuId();
    final copy = GossipMenuEntity.fromJson(json);
    await storeGossipMenu(copy);
  }

  Future<int> getNextMenuId() async {
    final result = await laconic.table(_table).select([
      'MAX(MenuID) as max_id',
    ]).first();
    final maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  Future<int> countGossipMenus({GossipMenuFilterEntity? filter}) async {
    var builder = laconic.table('$_table AS gm');
    builder.select(['gm.MenuID']);
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
  }

  Future<void> destroyGossipMenu(int menuId, int textId) async {
    await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('TextID', textId)
        .delete();
  }

  Future<List<BriefGossipMenuEntity>> getBriefGossipMenus({
    int page = 1,
    GossipMenuFilterEntity? filter,
  }) async {
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
    return results
        .map((e) => BriefGossipMenuEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GossipMenuEntity> getGossipMenu(int menuId, int textId) async {
    final result = await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('TextID', textId)
        .first();
    return GossipMenuEntity.fromJson(result.toMap());
  }

  Future<void> storeGossipMenu(GossipMenuEntity model) async {
    var json = model.toJson();
    var newMenuId = await getNextMenuId();
    json['MenuID'] = newMenuId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateGossipMenu(
    int menuId,
    int textId,
    GossipMenuEntity model,
  ) async {
    final json = model.toJson();
    json.remove('MenuID');
    json.remove('TextID');
    await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('TextID', textId)
        .update(json);
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
