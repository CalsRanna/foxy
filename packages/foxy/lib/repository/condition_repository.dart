import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'condition_repository.g.dart';

@FoxyRepository(ConditionEntity)
@FoxyFilter.text('sourceTypeOrReferenceId')
@FoxyFilter.text('sourceEntry')
class ConditionRepository with RepositoryMixin, _ConditionRepositoryMixin {
  // The generated query layer inlines the table-name literal (mixins cannot
  // access class statics); this only serves as a contract check.
  // ignore: unused_field
  static const _table = 'conditions';

  /// Full 10-column primary key of acore_world.conditions
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

  @override
  Future<ConditionKey> copyCondition(ConditionKey key) async {
    var source = await getCondition(key);
    if (source == null) return key;
    var nextElseGroup = source.elseGroup + 1;
    while (await getCondition(
          ConditionKey.fromEntity(source.copyWith(elseGroup: nextElseGroup)),
        ) !=
        null) {
      nextElseGroup++;
    }
    final copied = source.copyWith(elseGroup: nextElseGroup);
    await storeCondition(copied);
    return ConditionKey.fromEntity(copied);
  }

  @override
  Future<ConditionEntity> createCondition() async {
    return const ConditionEntity();
  }
}
