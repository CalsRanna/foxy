import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'gossip_menu_repository.g.dart';

@FoxyRepository(GossipMenuEntity)
@FoxyFilter.text('menuId')
@FoxyFilter.text('text')
class GossipMenuRepository with RepositoryMixin, _GossipMenuRepositoryMixin {
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

  Future<int> countGossipMenus({GossipMenuFilter? filter}) async {
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

  Future<List<BriefGossipMenuEntity>> getBriefGossipMenus({
    int page = 1,
    GossipMenuFilter? filter,
  }) async {
    var builder = laconic.table('$_table AS gm');
    final fields = <String>[
      'gm.MenuID',
      'gm.TextID',
      'nt.text0_0 AS text00',
      'nt.text0_1 AS text01',
      if (localeEnabled) ...[
        'ntl.Text0_0 AS textLocale00',
        'ntl.Text0_1 AS textLocale01',
      ],
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

  Future<List<GossipMenuEntity>> getGossipMenus() async {
    final results = await laconic
        .table(_table)
        .orderBy('MenuID')
        .orderBy('TextID')
        .get();
    return results.map((e) => GossipMenuEntity.fromJson(e.toMap())).toList();
  }

  Future<int> getNextMenuId() => nextMaxPlusOne(_table, 'MenuID');

  QueryBuilder _applyFilter(QueryBuilder builder, GossipMenuFilter? filter) {
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
