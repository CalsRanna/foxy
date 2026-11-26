import 'package:foxy/constant/condition_agent_field_semantics.dart';
import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

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
  @FoxyFieldMeaning.conditional(
    '条件参数 1',
    dependsOn: ['conditionTypeOrReference'],
    branches: ConditionAgentFieldSemantics.value1,
  )
  final int conditionValue1;

  @FoxyBriefField()
  @FoxyFullField('ConditionValue2', key: true)
  @FoxyFieldMeaning.conditional(
    '条件参数 2',
    dependsOn: ['conditionTypeOrReference', 'conditionValue1'],
    branches: ConditionAgentFieldSemantics.value2,
  )
  final int conditionValue2;

  @FoxyBriefField()
  @FoxyFullField('ConditionValue3', key: true)
  @FoxyFieldMeaning.conditional(
    '条件参数 3',
    dependsOn: ['conditionTypeOrReference'],
    branches: ConditionAgentFieldSemantics.value3,
  )
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
    return ConditionType.conditionTypeLabels[id] ?? id.toString();
  }

  /// Display label for parameter 1, using the field spec for the condition type.
  ///
  /// Negative condition types are references and use the raw number.
  /// Select specs show the option label, and flag specs list the matching labels.
  /// Other specs use the raw number.
  String get conditionValue1Label {
    final type = conditionTypeOrReference;
    if (type < 0) return conditionValue1.toString();
    final spec = ConditionValueConfig.forType(
      type,
      value1: conditionValue1,
    ).value1;
    return switch (spec) {
      IntegerEnumFieldSpec(:final options) =>
        options[conditionValue1] ?? conditionValue1.toString(),
      IntegerFlagsFieldSpec(:final flags) => FlagItem.maskLabel(
        conditionValue1,
        flags,
      ),
      IntegerNumberFieldSpec() => conditionValue1.toString(),
      IntegerReferenceFieldSpec() => conditionValue1.toString(),
    };
  }

  /// Source-type labels: non-negative values map to enums, negative values
  /// mean a reference.
  String get sourceTypeLabel {
    final id = sourceTypeOrReferenceId;
    if (id < 0) return '引用 $id';
    return ConditionSourceTypes.conditionSourceTypeLabels[id] ?? id.toString();
  }
}
