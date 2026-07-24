// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'condition_entity.dart';

final class ConditionKey {
  final int sourceTypeOrReferenceId;
  final int sourceGroup;
  final int sourceEntry;
  final int sourceId;
  final int elseGroup;
  final int conditionTypeOrReference;
  final int conditionTarget;
  final int conditionValue1;
  final int conditionValue2;
  final int conditionValue3;

  const ConditionKey({
    required this.sourceTypeOrReferenceId,
    required this.sourceGroup,
    required this.sourceEntry,
    required this.sourceId,
    required this.elseGroup,
    required this.conditionTypeOrReference,
    required this.conditionTarget,
    required this.conditionValue1,
    required this.conditionValue2,
    required this.conditionValue3,
  });

  factory ConditionKey.fromEntity(ConditionEntity entity) {
    return ConditionKey(
      sourceTypeOrReferenceId: entity.sourceTypeOrReferenceId,
      sourceGroup: entity.sourceGroup,
      sourceEntry: entity.sourceEntry,
      sourceId: entity.sourceId,
      elseGroup: entity.elseGroup,
      conditionTypeOrReference: entity.conditionTypeOrReference,
      conditionTarget: entity.conditionTarget,
      conditionValue1: entity.conditionValue1,
      conditionValue2: entity.conditionValue2,
      conditionValue3: entity.conditionValue3,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ConditionKey &&
            sourceTypeOrReferenceId == other.sourceTypeOrReferenceId &&
            sourceGroup == other.sourceGroup &&
            sourceEntry == other.sourceEntry &&
            sourceId == other.sourceId &&
            elseGroup == other.elseGroup &&
            conditionTypeOrReference == other.conditionTypeOrReference &&
            conditionTarget == other.conditionTarget &&
            conditionValue1 == other.conditionValue1 &&
            conditionValue2 == other.conditionValue2 &&
            conditionValue3 == other.conditionValue3;
  }

  @override
  int get hashCode => Object.hashAll([
    sourceTypeOrReferenceId,
    sourceGroup,
    sourceEntry,
    sourceId,
    elseGroup,
    conditionTypeOrReference,
    conditionTarget,
    conditionValue1,
    conditionValue2,
    conditionValue3,
  ]);

  @override
  String toString() {
    return 'ConditionKey('
        'sourceTypeOrReferenceId: $sourceTypeOrReferenceId, '
        'sourceGroup: $sourceGroup, '
        'sourceEntry: $sourceEntry, '
        'sourceId: $sourceId, '
        'elseGroup: $elseGroup, '
        'conditionTypeOrReference: $conditionTypeOrReference, '
        'conditionTarget: $conditionTarget, '
        'conditionValue1: $conditionValue1, '
        'conditionValue2: $conditionValue2, '
        'conditionValue3: $conditionValue3'
        ')';
  }
}
