import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'condition_repository.g.dart';

@FoxyRepository(ConditionEntity)
@FoxyFilter.text('sourceTypeOrReferenceId')
@FoxyFilter.text('sourceEntry')
class ConditionRepository with RepositoryMixin, _ConditionRepositoryMixin {
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

  Future<int> countConditions({ConditionFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ConditionEntity> createCondition() async {
    return const ConditionEntity();
  }

  Future<List<BriefConditionEntity>> getBriefConditions({
    int page = 1,
    ConditionFilter? filter,
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

  QueryBuilder _applyFilter(QueryBuilder builder, ConditionFilter? filter) {
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
