// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'condition_entity.g.dart';

@FoxyFilterEntity()
@FoxyFullEntity(table: 'conditions')
class ConditionEntity with _ConditionEntityMixin {
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('SourceTypeOrReferenceId', key: true)
  final int sourceTypeOrReferenceId;

  @FoxyFullField('SourceGroup', key: true)
  final int sourceGroup;

  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('SourceEntry', key: true)
  final int sourceEntry;

  @FoxyFullField('SourceId', key: true)
  final int sourceId;

  @FoxyFullField('ElseGroup', key: true)
  final int elseGroup;

  @FoxyFullField('ConditionTypeOrReference', key: true)
  final int conditionTypeOrReference;

  @FoxyFullField('ConditionTarget', key: true)
  final int conditionTarget;

  @FoxyFullField('ConditionValue1', key: true)
  final int conditionValue1;

  @FoxyFullField('ConditionValue2', key: true)
  final int conditionValue2;

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
