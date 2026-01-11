import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GossipMenuRepository with RepositoryMixin {
  final String _table = 'gossip_menu';

  Future<int> count({String? menuId, String? text}) async {
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
      if (menuId != null && menuId.isNotEmpty) {
        builder = builder.where('gm.MenuID', menuId);
      }
      if (text != null && text.isNotEmpty) {
        builder = builder.whereAny(
          ['nt.text0_0', 'nt.text0_1', 'ntl.Text0_0', 'ntl.Text0_1'],
          '%$text%',
          operator: 'like',
        );
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  Future<List<GossipMenu>> search({
    String? menuId,
    String? text,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      const fields = [
        'gm.MenuID',
        'gm.TextID',
        'nt.text0_0',
        'nt.text0_1',
        'ntl.Text0_0',
        'ntl.Text0_1',
      ];
      var builder = laconic.table('$_table AS gm');
      builder = builder.select(fields);
      builder = builder.leftJoin(
        'npc_text AS nt',
        (join) => join.on('gm.TextID', 'nt.ID'),
      );
      builder = builder.leftJoin(
        'npc_text_locale AS ntl',
        (join) => join.on('gm.TextID', 'ntl.ID').on('ntl.Locale', '"zhCN"'),
      );
      if (menuId != null && menuId.isNotEmpty) {
        builder = builder.where('gm.MenuID', menuId);
      }
      if (text != null && text.isNotEmpty) {
        builder = builder.whereAny(
          ['nt.text0_0', 'nt.text0_1', 'ntl.Text0_0', 'ntl.Text0_1'],
          '%$text%',
          operator: 'like',
        );
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => GossipMenu.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<GossipMenu?> getById(int menuId) async {
    try {
      var result = await laconic.table(_table).where('MenuID', menuId).first();
      return GossipMenu.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }
}
