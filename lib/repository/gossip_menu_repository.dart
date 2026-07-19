import 'package:foxy/entity/brief_gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/entity/gossip_menu_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class GossipMenuRepository with RepositoryMixin {
  static const _table = 'gossip_menu';

  Future<GossipMenuKey> copyGossipMenu(GossipMenuKey key) async {
    final source = await getGossipMenu(key);
    if (source == null) {
      throw StateError('原对话菜单不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(menuId: await getNextMenuId());
    await storeGossipMenu(copied);
    return GossipMenuKey.fromEntity(copied);
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
    return GossipMenuEntity(menuId: await getNextMenuId());
  }

  Future<void> destroyGossipMenu(GossipMenuKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原对话菜单不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefGossipMenuEntity>> getBriefGossipMenus({
    int page = 1,
    GossipMenuFilterEntity? filter,
  }) async {
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
    builder = builder.limit(kPageSize).offset((page - 1) * kPageSize);
    final results = await builder.get();
    return results
        .map((e) => BriefGossipMenuEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<GossipMenuEntity?> getGossipMenu(GossipMenuKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return GossipMenuEntity.fromJson(results.first.toMap());
  }

  Future<List<GossipMenuEntity>> getGossipMenus() async {
    final results = await laconic
        .table(_table)
        .orderBy('MenuID')
        .orderBy('TextID')
        .get();
    return results.map((e) => GossipMenuEntity.fromJson(e.toMap())).toList();
  }

  Future<int> getNextMenuId() => nextMaxPlusOne(_table, 'MenuID');

  Future<void> storeGossipMenu(GossipMenuEntity menu) async {
    if (menu.menuId <= 0) {
      throw StateError('对话菜单 MenuID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([menu.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('对话菜单 ${menu.menuId}/${menu.textId} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateGossipMenu(
    GossipMenuKey originalKey,
    GossipMenuEntity menu,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(menu.toJson());
      if (matchedRows == 0) {
        throw StateError('原对话菜单不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的对话菜单主键已存在，无法保存');
      }
      rethrow;
    }
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

  QueryBuilder _whereKey(QueryBuilder builder, GossipMenuKey key) {
    return builder.where('MenuID', key.menuId).where('TextID', key.textId);
  }
}
