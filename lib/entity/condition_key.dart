import 'package:flutter/foundation.dart';
import 'package:foxy/entity/condition_entity.dart';

@immutable
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

  factory ConditionKey.fromEntity(ConditionEntity value) {
    return ConditionKey(
      sourceTypeOrReferenceId: value.sourceTypeOrReferenceId,
      sourceGroup: value.sourceGroup,
      sourceEntry: value.sourceEntry,
      sourceId: value.sourceId,
      elseGroup: value.elseGroup,
      conditionTypeOrReference: value.conditionTypeOrReference,
      conditionTarget: value.conditionTarget,
      conditionValue1: value.conditionValue1,
      conditionValue2: value.conditionValue2,
      conditionValue3: value.conditionValue3,
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
  int get hashCode => Object.hash(
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
  );
}
