import 'package:foxy/model/spell.dart';
import 'package:foxy/repository/repository_mixin.dart';

class SpellRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_spell';

  /// 搜索技能
  Future<List<Spell>> search({
    String? id,
    String? name,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      const fields = ['ID', 'Name_Lang_zhCN', 'NameSubtext_Lang_zhCN'];
      builder = builder.select(fields);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.where('Name_Lang_zhCN', '%$name%');
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => Spell.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({
    String? id,
    String? name,
  }) async {
    try {
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      if (name != null && name.isNotEmpty) {
        builder = builder.where('Name_Lang_zhCN', '%$name%');
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 根据ID获取单个技能
  Future<Spell?> find(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return result != null ? Spell.fromJson(result.toMap()) : null;
    } catch (e) {
      return null;
    }
  }
}
