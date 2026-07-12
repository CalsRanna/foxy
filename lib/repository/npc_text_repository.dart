import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class NpcTextRepository with RepositoryMixin {
  static const _table = 'npc_text';

  Future<List<BriefNpcTextEntity>> getBriefNpcTexts({
    int page = 1,
    NpcTextFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = ['ID', 'text0_0', 'text0_1'];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefNpcTextEntity.fromJson(e.toMap())).toList();
  }

  Future<List<NpcTextEntity>> getNpcTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => NpcTextEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countNpcTexts({NpcTextFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<NpcTextEntity?> getNpcText(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTextEntity.fromJson(results.first.toMap());
  }

  Future<NpcTextEntity> createNpcText() async {
    return const NpcTextEntity();
  }

  Future<int> storeNpcText(NpcTextEntity npcText) async {
    var json = npcText.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateNpcText(NpcTextEntity npcText) async {
    var json = npcText.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', npcText.id).update(json);
  }

  Future<void> destroyNpcText(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyNpcText(int id) async {
    var source = await getNpcText(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveNpcText(NpcTextEntity npcText) async {
    if (npcText.id == 0) {
      await storeNpcText(npcText);
      return;
    }
    var existing = await getNpcText(npcText.id);
    if (existing != null) {
      await updateNpcText(npcText);
    } else {
      await laconic.table(_table).insert([npcText.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(QueryBuilder builder, NpcTextFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['text0_0', 'text0_1'],
        '%${filter.text}%',
        comparator: 'like',
      );
    }
    return builder;
  }
}
