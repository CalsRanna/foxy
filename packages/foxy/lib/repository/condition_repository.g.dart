// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_repository.dart';

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

mixin _ConditionRepositoryMixin on RepositoryMixin {
  String get _table => 'conditions';

  Future<ConditionKey> copyCondition(ConditionKey key) async {
    final source = await getCondition(key);
    if (source == null) {
      throw RecordNotFoundException('conditions record not found');
    }
    final blank = await createCondition();
    final copied = source.copyWith(
      sourceTypeOrReferenceId: blank.sourceTypeOrReferenceId,
      sourceGroup: blank.sourceGroup,
      sourceEntry: blank.sourceEntry,
      sourceId: blank.sourceId,
      elseGroup: blank.elseGroup,
      conditionTypeOrReference: blank.conditionTypeOrReference,
      conditionTarget: blank.conditionTarget,
      conditionValue1: blank.conditionValue1,
      conditionValue2: blank.conditionValue2,
      conditionValue3: blank.conditionValue3,
    );
    await storeCondition(copied);
    return ConditionKey.fromEntity(copied);
  }

  Future<int> countConditions({ConditionFilter? filter}) async {
    return _applyFilter(laconic.table(_table), filter).count();
  }

  Future<ConditionEntity> createCondition() async {
    return ConditionEntity(
      sourceTypeOrReferenceId: await nextMaxPlusOne(
        _table,
        '`SourceTypeOrReferenceId`',
      ),
      sourceGroup: await nextMaxPlusOne(_table, '`SourceGroup`'),
      sourceEntry: await nextMaxPlusOne(_table, '`SourceEntry`'),
      sourceId: await nextMaxPlusOne(_table, '`SourceId`'),
      elseGroup: await nextMaxPlusOne(_table, '`ElseGroup`'),
      conditionTypeOrReference: await nextMaxPlusOne(
        _table,
        '`ConditionTypeOrReference`',
      ),
      conditionTarget: await nextMaxPlusOne(_table, '`ConditionTarget`'),
      conditionValue1: await nextMaxPlusOne(_table, '`ConditionValue1`'),
      conditionValue2: await nextMaxPlusOne(_table, '`ConditionValue2`'),
      conditionValue3: await nextMaxPlusOne(_table, '`ConditionValue3`'),
    );
  }

  Future<void> destroyCondition(ConditionKey key) async {
    await _beforeDestroy(key);
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw RecordNotFoundException('conditions record not found');
    }
  }

  Future<ConditionEntity?> getCondition(ConditionKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ConditionEntity.fromJson(results.first.toMap());
  }

  Future<List<BriefConditionEntity>> getBriefConditions({
    int page = 1,
    ConditionFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      '`SourceTypeOrReferenceId`',
      '`SourceGroup`',
      '`SourceEntry`',
      '`SourceId`',
      '`ElseGroup`',
      '`ConditionTypeOrReference`',
      '`ConditionTarget`',
      '`ConditionValue1`',
      '`ConditionValue2`',
      '`ConditionValue3`',
      '`Comment`',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder
        .orderBy('`SourceTypeOrReferenceId`')
        .orderBy('`SourceGroup`')
        .orderBy('`SourceEntry`')
        .orderBy('`SourceId`')
        .orderBy('`ElseGroup`')
        .orderBy('`ConditionTypeOrReference`')
        .orderBy('`ConditionTarget`')
        .orderBy('`ConditionValue1`')
        .orderBy('`ConditionValue2`')
        .orderBy('`ConditionValue3`');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((e) => BriefConditionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<List<ConditionEntity>> getConditions() async {
    var builder = laconic
        .table(_table)
        .orderBy('`SourceTypeOrReferenceId`')
        .orderBy('`SourceGroup`')
        .orderBy('`SourceEntry`')
        .orderBy('`SourceId`')
        .orderBy('`ElseGroup`')
        .orderBy('`ConditionTypeOrReference`')
        .orderBy('`ConditionTarget`')
        .orderBy('`ConditionValue1`')
        .orderBy('`ConditionValue2`')
        .orderBy('`ConditionValue3`');
    final results = await builder.get();
    return results.map((e) => ConditionEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeCondition(ConditionEntity condition) async {
    await _beforeStore(condition);
    final json = prepareWriteJson(condition.toJson());
    try {
      await laconic.table(_table).insert([json]);
    } catch (error) {
      if (!MysqlErrorUtil.isDuplicateEntry(error)) rethrow;
      throw DuplicateKeyException('duplicate key in conditions');
    }
  }

  Future<void> updateCondition(
    ConditionKey originalKey,
    ConditionEntity condition,
  ) async {
    await _beforeUpdate(originalKey, condition);
    final json = prepareWriteJson(condition.toJson());
    final int matchedRows;
    try {
      matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(json);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw DuplicateKeyException('duplicate key in conditions');
      }
      rethrow;
    }
    if (matchedRows == 0) {
      throw RecordNotFoundException('conditions record not found');
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, ConditionFilter? filter) {
    if (filter == null) return builder;
    if (filter.sourceTypeOrReferenceId.isNotEmpty) {
      builder = builder.where(
        '`SourceTypeOrReferenceId`',
        filter.sourceTypeOrReferenceId,
      );
    }
    if (filter.sourceEntry.isNotEmpty) {
      builder = builder.where('`SourceEntry`', filter.sourceEntry);
    }
    return builder;
  }

  Future<void> _beforeDestroy(ConditionKey key) async {}

  Future<void> _beforeStore(ConditionEntity condition) async {}

  Future<void> _beforeUpdate(
    ConditionKey originalKey,
    ConditionEntity condition,
  ) async {}

  QueryBuilder _whereKey(QueryBuilder builder, ConditionKey key) {
    var query = builder;
    query = query.where(
      '`SourceTypeOrReferenceId`',
      key.sourceTypeOrReferenceId,
    );
    query = query.where('`SourceGroup`', key.sourceGroup);
    query = query.where('`SourceEntry`', key.sourceEntry);
    query = query.where('`SourceId`', key.sourceId);
    query = query.where('`ElseGroup`', key.elseGroup);
    query = query.where(
      '`ConditionTypeOrReference`',
      key.conditionTypeOrReference,
    );
    query = query.where('`ConditionTarget`', key.conditionTarget);
    query = query.where('`ConditionValue1`', key.conditionValue1);
    query = query.where('`ConditionValue2`', key.conditionValue2);
    query = query.where('`ConditionValue3`', key.conditionValue3);
    return query;
  }
}
