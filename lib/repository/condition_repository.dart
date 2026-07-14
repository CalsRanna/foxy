import 'package:foxy/entity/brief_condition_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/entity/condition_filter_entity.dart';
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

  Future<List<ConditionEntity>> getConditions() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => ConditionEntity.fromJson(e.toMap())).toList();
  }

  Future<int> countConditions({ConditionFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ConditionEntity?> getCondition({
    required int sourceTypeOrReferenceId,
    required int sourceGroup,
    required int sourceEntry,
    required int sourceId,
    required int elseGroup,
    required int conditionTypeOrReference,
    required int conditionTarget,
    required int conditionValue1,
    required int conditionValue2,
    required int conditionValue3,
  }) async {
    var results = await _wherePk(
      laconic.table(_table),
      sourceTypeOrReferenceId: sourceTypeOrReferenceId,
      sourceGroup: sourceGroup,
      sourceEntry: sourceEntry,
      sourceId: sourceId,
      elseGroup: elseGroup,
      conditionTypeOrReference: conditionTypeOrReference,
      conditionTarget: conditionTarget,
      conditionValue1: conditionValue1,
      conditionValue2: conditionValue2,
      conditionValue3: conditionValue3,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ConditionEntity.fromJson(results.first.toMap());
  }

  Future<ConditionEntity?> getConditionFromCredential(
    Map<String, dynamic> credential,
  ) {
    return getCondition(
      sourceTypeOrReferenceId: credential['SourceTypeOrReferenceId'] as int,
      sourceGroup: credential['SourceGroup'] as int,
      sourceEntry: credential['SourceEntry'] as int,
      sourceId: credential['SourceId'] as int,
      elseGroup: credential['ElseGroup'] as int,
      conditionTypeOrReference: credential['ConditionTypeOrReference'] as int,
      conditionTarget: credential['ConditionTarget'] as int,
      conditionValue1: credential['ConditionValue1'] as int? ?? 0,
      conditionValue2: credential['ConditionValue2'] as int? ?? 0,
      conditionValue3: credential['ConditionValue3'] as int? ?? 0,
    );
  }

  Future<ConditionEntity> createCondition() async {
    return const ConditionEntity();
  }

  Future<void> storeCondition(ConditionEntity condition) async {
    condition.validate();
    await laconic.table(_table).insert([condition.toJson()]);
  }

  Future<void> updateCondition(
    Map<String, dynamic> credential,
    ConditionEntity condition,
  ) async {
    condition.validate();
    var json = condition.toJson();
    for (final col in pkColumns) {
      json.remove(col);
    }
    await _wherePkFromCredential(
      laconic.table(_table),
      credential,
    ).update(json);
  }

  Future<void> destroyCondition(Map<String, dynamic> credential) async {
    await _wherePkFromCredential(laconic.table(_table), credential).delete();
  }

  Future<void> copyCondition(Map<String, dynamic> credential) async {
    var source = await getConditionFromCredential(credential);
    if (source == null) return;
    var nextElseGroup = source.elseGroup + 1;
    while (await getCondition(
          sourceTypeOrReferenceId: source.sourceTypeOrReferenceId,
          sourceGroup: source.sourceGroup,
          sourceEntry: source.sourceEntry,
          sourceId: source.sourceId,
          elseGroup: nextElseGroup,
          conditionTypeOrReference: source.conditionTypeOrReference,
          conditionTarget: source.conditionTarget,
          conditionValue1: source.conditionValue1,
          conditionValue2: source.conditionValue2,
          conditionValue3: source.conditionValue3,
        ) !=
        null) {
      nextElseGroup++;
    }
    await storeCondition(source.copyWith(elseGroup: nextElseGroup));
  }

  Future<void> saveCondition(ConditionEntity condition) async {
    condition.validate();
    final credential = condition.buildCredential();
    var existing = await getConditionFromCredential(credential);
    if (existing != null) {
      await updateCondition(credential, condition);
    } else {
      await storeCondition(condition);
    }
  }

  QueryBuilder _wherePk(
    QueryBuilder builder, {
    required int sourceTypeOrReferenceId,
    required int sourceGroup,
    required int sourceEntry,
    required int sourceId,
    required int elseGroup,
    required int conditionTypeOrReference,
    required int conditionTarget,
    required int conditionValue1,
    required int conditionValue2,
    required int conditionValue3,
  }) {
    return builder
        .where('SourceTypeOrReferenceId', sourceTypeOrReferenceId)
        .where('SourceGroup', sourceGroup)
        .where('SourceEntry', sourceEntry)
        .where('SourceId', sourceId)
        .where('ElseGroup', elseGroup)
        .where('ConditionTypeOrReference', conditionTypeOrReference)
        .where('ConditionTarget', conditionTarget)
        .where('ConditionValue1', conditionValue1)
        .where('ConditionValue2', conditionValue2)
        .where('ConditionValue3', conditionValue3);
  }

  QueryBuilder _wherePkFromCredential(
    QueryBuilder builder,
    Map<String, dynamic> credential,
  ) {
    return _wherePk(
      builder,
      sourceTypeOrReferenceId: credential['SourceTypeOrReferenceId'] as int,
      sourceGroup: credential['SourceGroup'] as int,
      sourceEntry: credential['SourceEntry'] as int,
      sourceId: credential['SourceId'] as int,
      elseGroup: credential['ElseGroup'] as int,
      conditionTypeOrReference: credential['ConditionTypeOrReference'] as int,
      conditionTarget: credential['ConditionTarget'] as int,
      conditionValue1: credential['ConditionValue1'] as int? ?? 0,
      conditionValue2: credential['ConditionValue2'] as int? ?? 0,
      conditionValue3: credential['ConditionValue3'] as int? ?? 0,
    );
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
}
