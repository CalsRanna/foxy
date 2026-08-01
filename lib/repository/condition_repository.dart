import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'condition_repository.g.dart';

@FoxyRepository(ConditionEntity)
@FoxyFilter.text('sourceTypeOrReferenceId')
@FoxyFilter.text('sourceEntry')
class ConditionRepository with RepositoryMixin, _ConditionRepositoryMixin {
  // 生成版查询层内联表名字面量（mixin 无法访问类静态成员），此处仅作契约校验。
  // ignore: unused_field
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
