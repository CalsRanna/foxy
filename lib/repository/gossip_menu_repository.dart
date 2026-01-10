import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/repository/repository_mixin.dart';

class GossipMenuRepository with RepositoryMixin {
  final String _table = 'gossip_menu';

  Future<int> count({String? menuId}) async {
    try {
      var builder = laconic.table(_table);
      if (menuId != null && menuId.isNotEmpty) {
        builder = builder.where('MenuID', menuId);
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  Future<List<GossipMenu>> search({
    String? menuId,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      if (menuId != null && menuId.isNotEmpty) {
        builder = builder.where('MenuID', menuId);
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
