import 'package:foxy/model/npc_text_locale.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// npc_text_locale 表的数据访问层
/// 复合主键: (ID, Locale)
class NpcTextLocaleRepository with RepositoryMixin {
  static const _table = 'npc_text_locale';

  /// 按 ID 查询该 NpcText 的所有 locale
  Future<List<NpcTextLocale>> search({required int id}) async {
    try {
      final results = await laconic.table(_table).where('ID', id).get();
      return results.map((e) => NpcTextLocale.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 按 ID + Locale 查找
  Future<NpcTextLocale?> find(Map<String, dynamic> id) async {
    try {
      var builder = laconic.table(_table);
      id.forEach((k, v) {
        builder = builder.where(k, v);
      });
      final result = await builder.first();
      return NpcTextLocale.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> update(Map<String, dynamic> id, NpcTextLocale model) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    final json = model.toJson();
    json.remove('ID');
    json.remove('Locale');
    await builder.update(json);
  }

  Future<void> store(NpcTextLocale model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  /// upsert：不存在则 insert，存在则 update
  Future<void> storeOrUpdate(NpcTextLocale model) async {
    final existing = await find({'ID': model.id, 'Locale': model.locale});
    if (existing == null) {
      await store(model);
    } else {
      await update({'ID': model.id, 'Locale': model.locale}, model);
    }
  }

  Future<void> destroy(Map<String, dynamic> id) async {
    var builder = laconic.table(_table);
    id.forEach((k, v) {
      builder = builder.where(k, v);
    });
    await builder.delete();
  }
}
