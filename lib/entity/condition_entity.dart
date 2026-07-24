import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'condition_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'conditions')
class ConditionEntity with _ConditionEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('SourceTypeOrReferenceId', key: true)
  final int sourceTypeOrReferenceId;

  @FoxyBriefField()
  @FoxyFullField('SourceGroup', key: true)
  final int sourceGroup;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
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

extension BriefConditionEntityDisplay on BriefConditionEntity {
  /// 条件类型标签：非负值映射枚举，负值表示引用。
  String get conditionTypeLabel {
    final id = conditionTypeOrReference;
    if (id < 0) return '引用 $id';
    return kConditionTypeLabels[id] ?? id.toString();
  }

  /// 来源类型标签：非负值映射枚举，负值表示引用。
  String get sourceTypeLabel {
    final id = sourceTypeOrReferenceId;
    if (id < 0) return '引用 $id';
    return kConditionSourceTypeLabels[id] ?? id.toString();
  }
}
