import 'package:foxy/model/creature_spell_data.dart';
import 'package:foxy/repository/repository_mixin.dart';

class CreatureSpellDataRepository with RepositoryMixin {
  // DBC 表在 foxy 数据库中
  final String _table = 'foxy.dbc_creature_spell_data';

  Future<int> count({String? id}) async {
    try {
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      return await builder.count();
    } catch (e) {
      // 表可能不存在
      return 0;
    }
  }

  Future<List<CreatureSpellData>> search({String? id, int page = 1}) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => CreatureSpellData.fromJson(e.toMap())).toList();
    } catch (e) {
      // 表可能不存在
      return [];
    }
  }

  Future<CreatureSpellData?> getById(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return CreatureSpellData.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }
}
