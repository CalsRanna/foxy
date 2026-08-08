import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/constant/condition_value_config.dart';
import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy_annotation/entity_annotations.dart';

part 'condition_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'conditions')
class ConditionEntity with _ConditionEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('SourceTypeOrReferenceId', key: true)
  final int sourceTypeOrReferenceId;

  @FoxyBriefField()
  @FoxyFullField('SourceGroup', key: true)
  final int sourceGroup;

  @FoxyBriefField()
  @FoxyFullField('SourceEntry', key: true)
  final int sourceEntry;

  @FoxyBriefField()
  @FoxyFullField('SourceId', key: true)
  final int sourceId;

  @FoxyBriefField()
  @FoxyFullField('ElseGroup', key: true)
  final int elseGroup;

  @FoxyBriefField()
  @FoxyFullField('ConditionTypeOrReference', key: true)
  final int conditionTypeOrReference;

  @FoxyBriefField()
  @FoxyFullField('ConditionTarget', key: true)
  final int conditionTarget;

  @FoxyBriefField()
  @FoxyFullField('ConditionValue1', key: true)
  final int conditionValue1;

  @FoxyBriefField()
  @FoxyFullField('ConditionValue2', key: true)
  final int conditionValue2;

  @FoxyBriefField()
  @FoxyFullField('ConditionValue3', key: true)
  final int conditionValue3;

  @FoxyFullField('NegativeCondition')
  final int negativeCondition;

  @FoxyFullField('ErrorType')
  final int errorType;

  @FoxyFullField('ErrorTextId')
  final int errorTextId;

  @FoxyFullField('ScriptName')
  final String scriptName;

  @FoxyBriefField()
  @FoxyFullField('Comment')
  final String comment;

  const ConditionEntity({
    this.sourceTypeOrReferenceId = 0,
    this.sourceGroup = 0,
    this.sourceEntry = 0,
    this.sourceId = 0,
    this.elseGroup = 0,
    this.conditionTypeOrReference = 0,
    this.conditionTarget = 0,
    this.conditionValue1 = 0,
    this.conditionValue2 = 0,
    this.conditionValue3 = 0,
    this.negativeCondition = 0,
    this.errorType = 0,
    this.errorTextId = 0,
    this.scriptName = '',
    this.comment = '',
  });

  factory ConditionEntity.fromJson(Map<String, dynamic> json) =>
      _ConditionEntityMixin.fromJson(json);
}

extension BriefConditionEntityLabel on BriefConditionEntity {
  /// Condition-type labels: non-negative values map to enums, negative
  /// values mean a reference.
  String get conditionTypeLabel {
    final id = conditionTypeOrReference;
    if (id < 0) return '引用 $id';
    return kConditionTypeLabels[id] ?? id.toString();
  }

  /// Source-type labels: non-negative values map to enums, negative values
  /// mean a reference.
  String get sourceTypeLabel {
    final id = sourceTypeOrReferenceId;
    if (id < 0) return '引用 $id';
    return kConditionSourceTypeLabels[id] ?? id.toString();
  }

  /// 参数1 标签：按条件类型解析字段规格后映射为可读文本。
  ///
  /// - 条件类型为负数（引用）时无规格可用，回退为原始数字；
  /// - select 规格映射为选项标签，flags 规格展开为标签列表，
  ///   其余规格回退为原始数字。
  String get conditionValue1Label {
    final type = conditionTypeOrReference;
    if (type < 0) return conditionValue1.toString();
    final spec = conditionValueConfig(type, value1: conditionValue1).value1;
    return switch (spec) {
      IntegerSelectFieldSpec(:final options) =>
        options[conditionValue1] ?? conditionValue1.toString(),
      IntegerFlagsFieldSpec(:final flags) => flagMaskLabel(conditionValue1, flags),
      IntegerNumberFieldSpec() => conditionValue1.toString(),
      IntegerReferenceFieldSpec() => conditionValue1.toString(),
    };
  }
}
