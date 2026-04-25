import 'package:foxy/model/npc_text.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// npc_text 表的数据访问层
/// 单主键: ID
class NpcTextRepository with RepositoryMixin {
  static const _table = 'npc_text';

  /// 搜索（用于 NpcTextSelector）
  Future<List<NpcText>> search({String? id, String? text, int page = 1}) async {
    return paginate(id: id, text: text, page: page);
  }

  Future<List<NpcText>> paginate({
    String? id,
    String? text,
    required int page,
  }) async {
    try {
      final offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      if (text != null && text.isNotEmpty) {
        builder = builder.whereAny(
          ['text0_0', 'text0_1'],
          '%$text%',
          operator: 'like',
        );
      }
      builder = builder.limit(kPageSize).offset(offset);
      final results = await builder.get();
      return results.map((e) => NpcText.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<int> count({String? id, String? text}) async {
    try {
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      if (text != null && text.isNotEmpty) {
        builder = builder.whereAny(
          ['text0_0', 'text0_1'],
          '%$text%',
          operator: 'like',
        );
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 按 ID 查找
  Future<NpcText?> find(int id) async {
    try {
      final result = await laconic.table(_table).where('ID', id).first();
      return NpcText.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  /// create：返回下一个可用 ID 的空白对象（不落库）
  Future<NpcText> create() async {
    try {
      final result = await laconic.table(_table).select([
        'MAX(ID) as max_id',
      ]).first();
      final maxId = result.toMap()['max_id'] as int?;
      final model = NpcText();
      model.id = (maxId ?? 0) + 1;
      return model;
    } catch (e) {
      final model = NpcText();
      model.id = 1;
      return model;
    }
  }

  Future<void> update(int id, NpcText model) async {
    final json = model.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', id).update(json);
  }

  Future<void> store(NpcText model) async {
    await laconic.table(_table).insert([model.toJson()]);
  }

  Future<void> destroy(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copy(int id) async {
    final original = await find(id);
    if (original == null) return;
    final next = await create();
    original.id = next.id;
    await store(original);
  }
}
