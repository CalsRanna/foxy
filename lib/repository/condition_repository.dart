import 'package:foxy/entity/brief_condition_entity.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/entity/condition_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ConditionRepository with RepositoryMixin {
  static const _table = 'conditions';

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

  Future<ConditionEntity?> getCondition(
    int sourceTypeOrReferenceId,
    int sourceGroup,
    int sourceEntry,
    int sourceId,
    int elseGroup,
    int conditionTypeOrReference,
    int conditionTarget,
  ) async {
    var results = await laconic
        .table(_table)
        .where('SourceTypeOrReferenceId', sourceTypeOrReferenceId)
        .where('SourceGroup', sourceGroup)
        .where('SourceEntry', sourceEntry)
        .where('SourceId', sourceId)
        .where('ElseGroup', elseGroup)
        .where('ConditionTypeOrReference', conditionTypeOrReference)
        .where('ConditionTarget', conditionTarget)
        .limit(1)
        .get();
    if (results.isEmpty) return null;
    return ConditionEntity.fromJson(results.first.toMap());
  }

  Future<ConditionEntity> createCondition() async {
    return const ConditionEntity();
  }

  Future<void> storeCondition(ConditionEntity condition) async {
    await laconic.table(_table).insert([condition.toJson()]);
  }

  Future<void> updateCondition(
    int sourceTypeOrReferenceId,
    int sourceGroup,
    int sourceEntry,
    int sourceId,
    int elseGroup,
    int conditionTypeOrReference,
    int conditionTarget,
    ConditionEntity condition,
  ) async {
    var json = condition.toJson();
    json.remove('SourceTypeOrReferenceId');
    json.remove('SourceGroup');
    json.remove('SourceEntry');
    json.remove('SourceId');
    json.remove('ElseGroup');
    json.remove('ConditionTypeOrReference');
    json.remove('ConditionTarget');
    await laconic
        .table(_table)
        .where('SourceTypeOrReferenceId', sourceTypeOrReferenceId)
        .where('SourceGroup', sourceGroup)
        .where('SourceEntry', sourceEntry)
        .where('SourceId', sourceId)
        .where('ElseGroup', elseGroup)
        .where('ConditionTypeOrReference', conditionTypeOrReference)
        .where('ConditionTarget', conditionTarget)
        .update(json);
  }

  Future<void> destroyCondition(
    int sourceTypeOrReferenceId,
    int sourceGroup,
    int sourceEntry,
    int sourceId,
    int elseGroup,
    int conditionTypeOrReference,
    int conditionTarget,
  ) async {
    await laconic
        .table(_table)
        .where('SourceTypeOrReferenceId', sourceTypeOrReferenceId)
        .where('SourceGroup', sourceGroup)
        .where('SourceEntry', sourceEntry)
        .where('SourceId', sourceId)
        .where('ElseGroup', elseGroup)
        .where('ConditionTypeOrReference', conditionTypeOrReference)
        .where('ConditionTarget', conditionTarget)
        .delete();
  }

  Future<void> copyCondition(
    int sourceTypeOrReferenceId,
    int sourceGroup,
    int sourceEntry,
    int sourceId,
    int elseGroup,
    int conditionTypeOrReference,
    int conditionTarget,
  ) async {
    var source = await getCondition(
      sourceTypeOrReferenceId,
      sourceGroup,
      sourceEntry,
      sourceId,
      elseGroup,
      conditionTypeOrReference,
      conditionTarget,
    );
    if (source == null) return;
    var json = source.toJson();
    // Shift ElseGroup (part of PK) so the copy is unique
    json['ElseGroup'] = elseGroup + 1;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveCondition(ConditionEntity condition) async {
    var existing = await getCondition(
      condition.sourceTypeOrReferenceId,
      condition.sourceGroup,
      condition.sourceEntry,
      condition.sourceId,
      condition.elseGroup,
      condition.conditionTypeOrReference,
      condition.conditionTarget,
    );
    if (existing != null) {
      await updateCondition(
        condition.sourceTypeOrReferenceId,
        condition.sourceGroup,
        condition.sourceEntry,
        condition.sourceId,
        condition.elseGroup,
        condition.conditionTypeOrReference,
        condition.conditionTarget,
        condition,
      );
    } else {
      await storeCondition(condition);
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
}
