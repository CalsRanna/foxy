import 'package:foxy/entity/brief_condition_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/entity/condition_filter_entity.dart';
import 'package:foxy/entity/condition_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ConditionRepository with RepositoryMixin {
  static const _table = 'conditions';

  /// acore_world.conditions 完整 10 列主键
  static const pkColumns = [
    'SourceTypeOrReferenceId',
    'SourceGroup',
    'SourceEntry',
    'SourceId',
    'ElseGroup',
    'ConditionTypeOrReference',
    'ConditionTarget',
    'ConditionValue1',
    'ConditionValue2',
    'ConditionValue3',
  ];

  Future<void> copyCondition(ConditionKey key) async {
    var source = await getCondition(key);
    if (source == null) return;
    var nextElseGroup = source.elseGroup + 1;
    while (await getCondition(
          ConditionKey.fromEntity(source.copyWith(elseGroup: nextElseGroup)),
        ) !=
        null) {
      nextElseGroup++;
    }
    await storeCondition(source.copyWith(elseGroup: nextElseGroup));
  }

  Future<int> countConditions({ConditionFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ConditionEntity> createCondition() async {
    return const ConditionEntity();
  }

  Future<void> destroyCondition(ConditionKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefConditionEntity>> getBriefConditions({
    int page = 1,
    ConditionFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    const fields = [
      'SourceTypeOrReferenceId',
      'SourceGroup',
      'SourceEntry',
      'SourceId',
      'ElseGroup',
      'ConditionTypeOrReference',
      'ConditionTarget',
      'ConditionValue1',
      'ConditionValue2',
      'ConditionValue3',
      'Comment',
    ];
    var builder = laconic.table(_table).select(fields);
    builder = _applyFilter(builder, filter);
    // 完整主键排序，保证 LIMIT/OFFSET 稳定
    for (final col in pkColumns) {
      builder = builder.orderBy(col);
    }
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefConditionEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<ConditionEntity?> getCondition(ConditionKey key) async {
    var results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ConditionEntity.fromJson(results.first.toMap());
  }

  Future<List<ConditionEntity>> getConditions() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => ConditionEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeCondition(ConditionEntity condition) async {
    try {
      await laconic.table(_table).insert([condition.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('条件主键已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCondition(
    ConditionKey originalKey,
    ConditionEntity condition,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(condition.toJson());
      if (matchedRows == 0) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的主键已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ConditionFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.sourceTypeOrReferenceId.isNotEmpty) {
      builder = builder.where(
        'SourceTypeOrReferenceId',
        filter.sourceTypeOrReferenceId,
      );
    }
    if (filter.sourceEntry.isNotEmpty) {
      builder = builder.where('SourceEntry', filter.sourceEntry);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, ConditionKey key) {
    return builder
        .where('SourceTypeOrReferenceId', key.sourceTypeOrReferenceId)
        .where('SourceGroup', key.sourceGroup)
        .where('SourceEntry', key.sourceEntry)
        .where('SourceId', key.sourceId)
        .where('ElseGroup', key.elseGroup)
        .where('ConditionTypeOrReference', key.conditionTypeOrReference)
        .where('ConditionTarget', key.conditionTarget)
        .where('ConditionValue1', key.conditionValue1)
        .where('ConditionValue2', key.conditionValue2)
        .where('ConditionValue3', key.conditionValue3);
  }
}
