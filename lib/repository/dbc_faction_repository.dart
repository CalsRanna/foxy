import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class DbcFactionRepository with RepositoryMixin {
  // DBC 表在 foxy 数据库中
  static const _table = 'foxy.dbc_faction';

  Future<int> countDbcFactions({String? id, String? name}) async {
    try {
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.where(
          'Name_lang_zhCN',
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

  Future<List<DbcFactionEntity>> getDbcFactions({
    String? id,
    String? name,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table).select([
        'ID',
        'Name_lang_zhCN',
        'Description_lang_zhCN',
      ]);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.where(
          'Name_lang_zhCN',
          '%$name%',
          comparator: 'like',
        );
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => DbcFactionEntity.fromJson(e.toMap())).toList();
    } catch (e) {
      // 表可能不存在
      return [];
    }
  }

  Future<DbcFactionEntity?> getById(int id) async {
    try {
      var result = await laconic
          .table(_table)
          .select(['ID', 'Name_lang_zhCN', 'Description_lang_zhCN'])
          .where('ID', id)
          .first();
      return DbcFactionEntity.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }
}
