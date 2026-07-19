import 'package:foxy/entity/brief_smart_script_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/entity/smart_script_filter_entity.dart';
import 'package:foxy/entity/smart_script_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class SmartScriptRepository with RepositoryMixin {
  static const _table = 'smart_scripts';
  static const primaryKeyColumns = {'entryorguid', 'source_type', 'id', 'link'};

  Future<SmartScriptKey> copySmartScript(SmartScriptKey key) async {
    final script = await getSmartScript(key);
    if (script == null) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
    final nextId = await nextMaxPlusOne(
      _table,
      'id',
      where: {
        'entryorguid': script.entryOrGuid,
        'source_type': script.sourceType,
      },
    );
    final candidate = script.copyWith(id: nextId);
    await storeSmartScript(candidate);
    return SmartScriptKey.fromEntity(candidate);
  }

  Future<int> countSmartScripts({SmartScriptFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder.select(['entryorguid']);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<SmartScriptEntity> createSmartScript({
    int entryOrGuid = 0,
    int sourceType = 0,
  }) async {
    var nextId = await nextMaxPlusOne(
      _table,
      'id',
      where: {'entryorguid': entryOrGuid, 'source_type': sourceType},
    );
    return SmartScriptEntity(
      entryOrGuid: entryOrGuid,
      sourceType: sourceType,
      id: nextId,
    );
  }

  Future<void> destroySmartScript(SmartScriptKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefSmartScriptEntity>> getBriefSmartScripts({
    int page = 1,
    SmartScriptFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'entryorguid',
      'source_type',
      'id',
      'link',
      'comment',
      'event_type',
      'action_type',
      'target_type',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder
        .orderBy('entryorguid')
        .orderBy('source_type')
        .orderBy('id')
        .orderBy('link');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefSmartScriptEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<SmartScriptEntity?> getSmartScript(SmartScriptKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return SmartScriptEntity.fromJson(results.first.toMap());
  }

  Future<List<SmartScriptEntity>> getSmartScripts() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => SmartScriptEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeSmartScript(SmartScriptEntity script) async {
    try {
      await laconic.table(_table).insert([script.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('SmartAI 脚本主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateSmartScript(
    SmartScriptKey originalKey,
    SmartScriptEntity script,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(script.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的 SmartAI 脚本主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    SmartScriptFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.entryOrGuid.isNotEmpty) {
      builder = builder.where('entryorguid', filter.entryOrGuid);
    }
    if (filter.comment.isNotEmpty) {
      builder = builder.where(
        'comment',
        '%${filter.comment}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, SmartScriptKey key) {
    return builder
        .where('entryorguid', key.entryOrGuid)
        .where('source_type', key.sourceType)
        .where('id', key.id)
        .where('link', key.link);
  }
}
