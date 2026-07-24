// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_repository.dart';

mixin _ConditionRepositoryMixin on RepositoryMixin {
  Future<void> destroyCondition(ConditionKey key) async {
    final deletedRows = await _whereKey(
      laconic.table('conditions'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ConditionEntity?> getCondition(ConditionKey key) async {
    final results = await _whereKey(
      laconic.table('conditions'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ConditionEntity.fromJson(results.first.toMap());
  }

  Future<void> storeCondition(ConditionEntity condition) async {
    await _beforeStore(condition);
    final json = _prepareWriteJson(condition.toJson());
    try {
      await laconic.table('conditions').insert([json]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('相同主键的记录已存在');
      }
      rethrow;
    }
  }

  Future<void> updateCondition(
    ConditionKey originalKey,
    ConditionEntity condition,
  ) async {
    await _beforeUpdate(originalKey, condition);
    final json = _prepareWriteJson(condition.toJson());
    try {
      final matchedRows = await _whereKey(
        laconic.table('conditions'),
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

  Future<void> _beforeStore(ConditionEntity condition) async {}

  Future<void> _beforeUpdate(
    ConditionKey originalKey,
    ConditionEntity condition,
  ) async {}

  Map<String, dynamic> _prepareWriteJson(Map<String, dynamic> json) {
    for (final key in json.keys.toList()) {
      if (const {'index', 'rank'}.contains(key.toLowerCase())) {
        json['`$key`'] = json.remove(key);
      }
    }
    return json;
  }

  QueryBuilder _whereKey(QueryBuilder builder, ConditionKey key) {
    var query = builder;
    query = query.where('SourceTypeOrReferenceId', key.sourceTypeOrReferenceId);
    query = query.where('SourceGroup', key.sourceGroup);
    query = query.where('SourceEntry', key.sourceEntry);
    query = query.where('SourceId', key.sourceId);
    query = query.where('ElseGroup', key.elseGroup);
    query = query.where(
      'ConditionTypeOrReference',
      key.conditionTypeOrReference,
    );
    query = query.where('ConditionTarget', key.conditionTarget);
    query = query.where('ConditionValue1', key.conditionValue1);
    query = query.where('ConditionValue2', key.conditionValue2);
    query = query.where('ConditionValue3', key.conditionValue3);
    return query;
  }
}

final class ConditionFilter {
  final String sourceTypeOrReferenceId;
  final String sourceEntry;

  const ConditionFilter({
    this.sourceTypeOrReferenceId = '',
    this.sourceEntry = '',
  });

  factory ConditionFilter.fromJson(Map<String, dynamic> json) {
    return ConditionFilter(
      sourceTypeOrReferenceId:
          json['sourceTypeOrReferenceId']?.toString() ?? '',
      sourceEntry: json['sourceEntry']?.toString() ?? '',
    );
  }

  ConditionFilter copyWith({
    String? sourceTypeOrReferenceId,
    String? sourceEntry,
  }) {
    return ConditionFilter(
      sourceTypeOrReferenceId:
          sourceTypeOrReferenceId ?? this.sourceTypeOrReferenceId,
      sourceEntry: sourceEntry ?? this.sourceEntry,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sourceTypeOrReferenceId': sourceTypeOrReferenceId,
      'sourceEntry': sourceEntry,
    };
  }
}
