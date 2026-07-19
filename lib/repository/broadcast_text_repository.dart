import 'package:foxy/entity/brief_broadcast_text_entity.dart';
import 'package:foxy/entity/broadcast_text_entity.dart';
import 'package:foxy/entity/broadcast_text_filter_entity.dart';
import 'package:foxy/entity/broadcast_text_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class BroadcastTextRepository with RepositoryMixin {
  static const _table = 'broadcast_text';

  Future<BroadcastTextKey> copyBroadcastText(BroadcastTextKey key) async {
    final source = await getBroadcastText(key);
    if (source == null) {
      throw StateError('原广播文本不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeBroadcastText(copied);
    return BroadcastTextKey.fromEntity(copied);
  }

  Future<int> countBroadcastTexts({BroadcastTextFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<BroadcastTextEntity> createBroadcastText() async {
    return BroadcastTextEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyBroadcastText(BroadcastTextKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原广播文本不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefBroadcastTextEntity>> getBriefBroadcastTexts({
    int page = 1,
    BroadcastTextFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'ID',
      'LanguageID',
      "COALESCE(NULLIF(MaleText, ''), FemaleText) as display_text",
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) {
      final map = e.toMap();
      final displayText = map['display_text'] as String? ?? '';
      map['MaleText'] = displayText;
      return BriefBroadcastTextEntity.fromJson(map);
    }).toList();
  }

  Future<BroadcastTextEntity?> getBroadcastText(BroadcastTextKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return BroadcastTextEntity.fromJson(results.first.toMap());
  }

  Future<List<BroadcastTextEntity>> getBroadcastTexts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => BroadcastTextEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeBroadcastText(BroadcastTextEntity text) async {
    if (text.id <= 0) {
      throw StateError('广播文本 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([text.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('广播文本 ${text.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateBroadcastText(
    BroadcastTextKey originalKey,
    BroadcastTextEntity text,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(text.toJson());
      if (matchedRows == 0) {
        throw StateError('原广播文本不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的广播文本 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    BroadcastTextFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.text.isNotEmpty) {
      builder = builder.whereAny(
        ['MaleText', 'FemaleText'],
        '%${filter.text}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, BroadcastTextKey key) {
    return builder.where('ID', key.id);
  }
}
