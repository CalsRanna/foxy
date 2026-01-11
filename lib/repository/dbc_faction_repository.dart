import 'package:foxy/model/dbc_faction.dart';
import 'package:foxy/repository/repository_mixin.dart';

class DbcFactionRepository with RepositoryMixin {
  // DBC 表在 foxy 数据库中
  final String _table = 'foxy.dbc_faction';

  Future<int> count({String? id, String? name}) async {
    try {
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.where(
          'Name_Lang_zhCN',
          '%$name%',
          comparator: 'like',
        );
      }
      return await builder.count();
    } catch (e) {
      // 表可能不存在
      return 0;
    }
  }

  Future<List<DbcFaction>> search({
    String? id,
    String? name,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table).select([
        'ID',
        'Name_Lang_zhCN',
        'Description_Lang_zhCN',
      ]);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.where(
          'Name_Lang_zhCN',
          '%$name%',
          comparator: 'like',
        );
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => DbcFaction.fromJson(e.toMap())).toList();
    } catch (e) {
      // 表可能不存在
      return [];
    }
  }

  Future<DbcFaction?> getById(int id) async {
    try {
      var result = await laconic
          .table(_table)
          .select(['ID', 'Name_Lang_zhCN', 'Description_Lang_zhCN'])
          .where('ID', id)
          .first();
      return DbcFaction.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }
}
