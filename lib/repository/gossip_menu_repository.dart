import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GossipMenuRepository with RepositoryMixin {
  static const _table = 'gossip_menu';

  Future<void> copyGossipMenu(int menuId, int textId) async {
    final original = await getGossipMenu(menuId, textId);
    if (original == null) return;
    final newMenuId = await getNextMenuId();
    await laconic.table(_table).insert([
      {'MenuID': newMenuId, 'TextID': original.textId},
    ]);
  }

  Future<int> countGossipMenus({GossipMenuFilterEntity? filter}) async {
    final needsTextJoin = filter != null && filter.text.isNotEmpty;
    if (!needsTextJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.menuId.isNotEmpty) {
        builder = builder.where('MenuID', filter.menuId);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS gm');
    builder = builder.leftJoin(
      'npc_text AS nt',
      (join) => join.on('gm.TextID', 'nt.ID'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'npc_text_locale AS ntl',
        (join) => join.on('gm.TextID', 'ntl.ID').where('ntl.Locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<GossipMenuEntity> createGossipMenu() async {
    final nextMenuId = await getNextMenuId();
    return GossipMenuEntity(menuId: nextMenuId);
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
    final fields = <String>[
      'gm.MenuID',
      'gm.TextID',
      'nt.text0_0',
      'nt.text0_1',
      if (localeEnabled) ...['ntl.Text0_0', 'ntl.Text0_1'],
    ];
    builder = builder.select(fields);
    builder = builder.leftJoin(
      'npc_text AS nt',
      (join) => join.on('gm.TextID', 'nt.ID'),
    );
    if (localeEnabled) {
      builder = builder.leftJoin(
        'npc_text_locale AS ntl',
        (join) => join.on('gm.TextID', 'ntl.ID').where('ntl.Locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('gm.MenuID').orderBy('gm.TextID');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefGossipMenuEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GossipMenuEntity?> getGossipMenu(int menuId, int textId) async {
    var results = await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('TextID', textId)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return GossipMenuEntity.fromJson(results.first.toMap());
  }

  Future<List<GossipMenuEntity>> getGossipMenus() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => GossipMenuEntity.fromJson(e.toMap())).toList();
  }

  Future<int> getNextMenuId() => nextMaxPlusOne(_table, 'MenuID');

  Future<void> saveGossipMenu(GossipMenuEntity menu) async {
    if (menu.menuId == 0) {
      await storeGossipMenu(menu);
      return;
    }
    var existing = await getGossipMenu(menu.menuId, menu.textId);
    if (existing != null) {
      await updateGossipMenu(menu.menuId, menu.textId, menu);
    } else {
      await laconic.table(_table).insert([
        {'MenuID': menu.menuId, 'TextID': menu.textId},
      ]);
    }
  }

  Future<int> storeGossipMenu(GossipMenuEntity menu) async {
    final newMenuId = menu.menuId > 0 ? menu.menuId : await getNextMenuId();
    await laconic.table(_table).insert([
      {'MenuID': newMenuId, 'TextID': menu.textId},
    ]);
    return newMenuId;
  }

  Future<void> updateGossipMenu(
    int menuId,
    int textId,
    GossipMenuEntity menu,
  ) async {
    // Composite PK only; allow re-keying MenuID/TextID from entity values.
    await laconic
        .table(_table)
        .where('MenuID', menuId)
        .where('TextID', textId)
        .update({'MenuID': menu.menuId, 'TextID': menu.textId});
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    GossipMenuFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.menuId.isNotEmpty) {
      builder = builder.where('gm.MenuID', filter.menuId);
    }
    if (filter.text.isNotEmpty) {
      final textColumns = localeEnabled
          ? ['nt.text0_0', 'nt.text0_1', 'ntl.Text0_0', 'ntl.Text0_1']
          : ['nt.text0_0', 'nt.text0_1'];
      builder = builder.whereAny(
        textColumns,
        '%${filter.text}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
