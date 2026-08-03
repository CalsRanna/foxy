// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_script_repository.dart';

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

mixin _SmartScriptRepositoryMixin on RepositoryMixin {
  Future<SmartScriptKey> copySmartScript(SmartScriptKey key) async {
    final source = await getSmartScript(key);
    if (source == null) {
      throw RecordNotFoundException('smart_scripts record not found');
    }
    final blank = await createSmartScript();
    final copied = source.copyWith(
      entryOrGuid: blank.entryOrGuid,
      sourceType: blank.sourceType,
      id: blank.id,
      link: blank.link,
    );
    await storeSmartScript(copied);
    return SmartScriptKey.fromEntity(copied);
  }

  Future<int> countSmartScripts({SmartScriptFilter? filter}) async {
    return _applyFilter(laconic.table('smart_scripts'), filter).count();
  }

  Future<SmartScriptEntity> createSmartScript() async {
    return SmartScriptEntity(
      entryOrGuid: await nextMaxPlusOne('smart_scripts', '`entryorguid`'),
      sourceType: await nextMaxPlusOne('smart_scripts', '`source_type`'),
      id: await nextMaxPlusOne('smart_scripts', '`id`'),
      link: await nextMaxPlusOne('smart_scripts', '`link`'),
    );
  }

  Future<void> destroySmartScript(SmartScriptKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(
      laconic.table('smart_scripts'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('smart_scripts record not found');
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

  Future<List<BriefSmartScriptEntity>> getBriefSmartScripts({
    int page = 1,
    SmartScriptFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('smart_scripts').select([
      '`entryorguid`',
      '`source_type`',
      '`id`',
      '`link`',
      '`event_type`',
      '`action_type`',
      '`target_type`',
      '`comment`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder
        .orderBy('`entryorguid`')
        .orderBy('`source_type`')
        .orderBy('`id`')
        .orderBy('`link`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefSmartScriptEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<SmartScriptEntity>> getSmartScripts() async {
    var builder = laconic
        .table('smart_scripts')
        .orderBy('`entryorguid`')
        .orderBy('`source_type`')
        .orderBy('`id`')
        .orderBy('`link`');
    final results = await builder.get();
    return results.map((e) => SmartScriptEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeSmartScript(SmartScriptEntity smartScript) async {
    await _beforeStore(smartScript);
    final json = prepareWriteJson(smartScript.toJson());
    try {
      await laconic.table('smart_scripts').insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      final retried = smartScript.copyWith(
        entryOrGuid: await nextMaxPlusOne('smart_scripts', '`entryorguid`'),
        sourceType: await nextMaxPlusOne('smart_scripts', '`source_type`'),
        id: await nextMaxPlusOne('smart_scripts', '`id`'),
        link: await nextMaxPlusOne('smart_scripts', '`link`'),
      );
      try {
        await laconic.table('smart_scripts').insert([
          prepareWriteJson(retried.toJson()),
        ]);
        return;
      } catch (retryError) {
        if (MysqlErrorUtil.isDuplicateEntry(retryError)) {
          throw DuplicateKeyException('duplicate key in smart_scripts');
        }
        rethrow;
      }
    }
  }

  Future<void> updateSmartScript(
    SmartScriptKey originalKey,
    SmartScriptEntity smartScript,
  ) async {
    await _beforeUpdate(originalKey, smartScript);
    final json = prepareWriteJson(smartScript.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table('smart_scripts'),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in smart_scripts');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('smart_scripts record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, SmartScriptFilter? filter) {
    if (filter == null) return builder;
    if (filter.entryOrGuid.isNotEmpty) {
      builder = builder.where('`entryorguid`', filter.entryOrGuid);
    }
    if (filter.comment.isNotEmpty) {
      builder = builder.where('`comment`', filter.comment);
    }
    return builder;
  }

  Future<void> _beforeDestroy(SmartScriptKey key) async {}

  Future<void> _beforeStore(SmartScriptEntity smartScript) async {}

  Future<void> _beforeUpdate(
    SmartScriptKey originalKey,
    SmartScriptEntity smartScript,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, SmartScriptKey key) {
    var query = builder;
    query = query.where('`entryorguid`', key.entryOrGuid);
    query = query.where('`source_type`', key.sourceType);
    query = query.where('`id`', key.id);
    query = query.where('`link`', key.link);
    return query;
  }
}
