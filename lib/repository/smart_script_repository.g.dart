// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_script_repository.dart';

mixin _SmartScriptRepositoryMixin on RepositoryMixin {
  Future<void> destroySmartScript(SmartScriptKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('smart_scripts'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<SmartScriptEntity?> getSmartScript(SmartScriptKey key) async {
    final results = await _whereKey(
      laconic.table('smart_scripts'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return SmartScriptEntity.fromJson(results.first.toMap());
  }

  Future<void> storeSmartScript(SmartScriptEntity smartScript) async {
    await _beforeStore(smartScript);
    final json = _prepareWriteJson(smartScript.toJson());
    try {
      await laconic.table('smart_scripts').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateSmartScript(
    SmartScriptKey originalKey,
    SmartScriptEntity smartScript,
  ) async {
    await _beforeUpdate(originalKey, smartScript);
    final json = _prepareWriteJson(smartScript.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('smart_scripts'),
        originalKey,
      ).update(json);
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在');
      }
      rethrow;
    }
  }

  Future<void> _beforeStore(SmartScriptEntity smartScript) async {}

  Future<void> _beforeUpdate(
    SmartScriptKey originalKey,
    SmartScriptEntity smartScript,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    return {
      for (final entry in json.entries)
        if (const {'index', 'rank'}.contains(entry.key.toLowerCase()))
          '`${entry.key}`': entry.value
        else
          entry.key: entry.value,
    };
  }

  QueryBuilder _whereKey(QueryBuilder builder, SmartScriptKey key) {
    var query = builder;
    query = query.where('entryorguid', key.entryOrGuid);
    query = query.where('source_type', key.sourceType);
    query = query.where('id', key.id);
    query = query.where('link', key.link);
    return query;
  }
}

final class SmartScriptFilter {
  final String entryOrGuid;
  final String comment;

  const SmartScriptFilter({this.entryOrGuid = '', this.comment = ''});

  factory SmartScriptFilter.fromJson(Map<String, dynamic> json) {
    return SmartScriptFilter(
      entryOrGuid: json['entryOrGuid']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
    );
  }

  SmartScriptFilter copyWith({String? entryOrGuid, String? comment}) {
    return SmartScriptFilter(
      entryOrGuid: entryOrGuid ?? this.entryOrGuid,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entryOrGuid': entryOrGuid, 'comment': comment};
  }
}
