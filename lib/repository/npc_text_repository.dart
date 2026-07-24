import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class NpcTextRepository with RepositoryMixin {
  static const _table = 'npc_text';

  Future<int> copyNpcText(int key) async {
    final source = await getNpcText(key);
    if (source == null) {
      throw StateError('原 NPC 文本不存在，可能已被其他操作修改或删除');
    }
    final json = source.toJson();
    json['ID'] = await nextMaxPlusOne(_table, 'ID');
    final copied = NpcTextEntity.fromJson(json);
    await storeNpcText(copied);
    return copied.id;
  }

  Future<int> countNpcTexts({NpcTextFilterEntity? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<NpcTextEntity> createNpcText([int? id]) async {
    return NpcTextEntity(id: id ?? await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyNpcText(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原 NPC 文本不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefNpcTextEntity>> getBriefNpcTexts({
    int page = 1,
    NpcTextFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'text0_0 AS text0',
      'text0_1 AS text1',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return results
        .map((row) => BriefNpcTextEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<NpcTextEntity?> getNpcText(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return NpcTextEntity.fromJson(results.first.toMap());
  }

  Future<List<NpcTextEntity>> getNpcTexts() async {
    final results = await laconic.table(_table).get();
    return results.map((row) => NpcTextEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeNpcText(NpcTextEntity npcText) async {
    if (npcText.id <= 0) throw StateError('NPC 文本 ID 必须大于 0');
    try {
      await laconic.table(_table).insert([npcText.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同 NPC 文本 ID 的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateNpcText(int originalKey, NpcTextEntity npcText) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(npcText.toJson());
      if (matchedRows == 0) {
        throw StateError('原 NPC 文本不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的 NPC 文本 ID 已存在');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, NpcTextFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['text0_0', 'text0_1'],
        '%${filter.text}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
