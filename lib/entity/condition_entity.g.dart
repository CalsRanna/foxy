// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_entity.dart';

mixin _ConditionEntityMixin {
  int get sourceTypeOrReferenceId;
  int get sourceGroup;
  int get sourceEntry;
  int get sourceId;
  int get elseGroup;
  int get conditionTypeOrReference;
  int get conditionTarget;
  int get conditionValue1;
  int get conditionValue2;
  int get conditionValue3;
  int get negativeCondition;
  int get errorType;
  int get errorTextId;
  String get scriptName;
  String get comment;

  static ConditionEntity fromJson(Map<String, dynamic> json) {
    return ConditionEntity(
      sourceTypeOrReferenceId:
          (json['SourceTypeOrReferenceId'] as num?)?.toInt() ?? 0,
      sourceGroup: (json['SourceGroup'] as num?)?.toInt() ?? 0,
      sourceEntry: (json['SourceEntry'] as num?)?.toInt() ?? 0,
      sourceId: (json['SourceId'] as num?)?.toInt() ?? 0,
      elseGroup: (json['ElseGroup'] as num?)?.toInt() ?? 0,
      conditionTypeOrReference:
          (json['ConditionTypeOrReference'] as num?)?.toInt() ?? 0,
      conditionTarget: (json['ConditionTarget'] as num?)?.toInt() ?? 0,
      conditionValue1: (json['ConditionValue1'] as num?)?.toInt() ?? 0,
      conditionValue2: (json['ConditionValue2'] as num?)?.toInt() ?? 0,
      conditionValue3: (json['ConditionValue3'] as num?)?.toInt() ?? 0,
      negativeCondition: (json['NegativeCondition'] as num?)?.toInt() ?? 0,
      errorType: (json['ErrorType'] as num?)?.toInt() ?? 0,
      errorTextId: (json['ErrorTextId'] as num?)?.toInt() ?? 0,
      scriptName: json['ScriptName']?.toString() ?? '',
      comment: json['Comment']?.toString() ?? '',
    );
  }

  ConditionEntity copyWith({
    int? sourceTypeOrReferenceId,
    int? sourceGroup,
    int? sourceEntry,
    int? sourceId,
    int? elseGroup,
    int? conditionTypeOrReference,
    int? conditionTarget,
    int? conditionValue1,
    int? conditionValue2,
    int? conditionValue3,
    int? negativeCondition,
    int? errorType,
    int? errorTextId,
    String? scriptName,
    String? comment,
  }) {
    return ConditionEntity(
      sourceTypeOrReferenceId:
          sourceTypeOrReferenceId ?? this.sourceTypeOrReferenceId,
      sourceGroup: sourceGroup ?? this.sourceGroup,
      sourceEntry: sourceEntry ?? this.sourceEntry,
      sourceId: sourceId ?? this.sourceId,
      elseGroup: elseGroup ?? this.elseGroup,
      conditionTypeOrReference:
          conditionTypeOrReference ?? this.conditionTypeOrReference,
      conditionTarget: conditionTarget ?? this.conditionTarget,
      conditionValue1: conditionValue1 ?? this.conditionValue1,
      conditionValue2: conditionValue2 ?? this.conditionValue2,
      conditionValue3: conditionValue3 ?? this.conditionValue3,
      negativeCondition: negativeCondition ?? this.negativeCondition,
      errorType: errorType ?? this.errorType,
      errorTextId: errorTextId ?? this.errorTextId,
      scriptName: scriptName ?? this.scriptName,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SourceTypeOrReferenceId': sourceTypeOrReferenceId,
      'SourceGroup': sourceGroup,
      'SourceEntry': sourceEntry,
      'SourceId': sourceId,
      'ElseGroup': elseGroup,
      'ConditionTypeOrReference': conditionTypeOrReference,
      'ConditionTarget': conditionTarget,
      'ConditionValue1': conditionValue1,
      'ConditionValue2': conditionValue2,
      'ConditionValue3': conditionValue3,
      'NegativeCondition': negativeCondition,
      'ErrorType': errorType,
      'ErrorTextId': errorTextId,
      'ScriptName': scriptName,
      'Comment': comment,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ConditionEntity &&
            runtimeType == other.runtimeType &&
            sourceTypeOrReferenceId == other.sourceTypeOrReferenceId &&
            sourceGroup == other.sourceGroup &&
            sourceEntry == other.sourceEntry &&
            sourceId == other.sourceId &&
            elseGroup == other.elseGroup &&
            conditionTypeOrReference == other.conditionTypeOrReference &&
            conditionTarget == other.conditionTarget &&
            conditionValue1 == other.conditionValue1 &&
            conditionValue2 == other.conditionValue2 &&
            conditionValue3 == other.conditionValue3 &&
            negativeCondition == other.negativeCondition &&
            errorType == other.errorType &&
            errorTextId == other.errorTextId &&
            scriptName == other.scriptName &&
            comment == other.comment;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
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
      negativeCondition,
      errorType,
      errorTextId,
      scriptName,
      comment,
    ]);
  }

  @override
  String toString() {
    return 'ConditionEntity('
        'sourceTypeOrReferenceId: $sourceTypeOrReferenceId, '
        'sourceGroup: $sourceGroup, '
        'sourceEntry: $sourceEntry, '
        'sourceId: $sourceId, '
        'elseGroup: $elseGroup, '
        'conditionTypeOrReference: $conditionTypeOrReference, '
        'conditionTarget: $conditionTarget, '
        'conditionValue1: $conditionValue1, '
        'conditionValue2: $conditionValue2, '
        'conditionValue3: $conditionValue3, '
        'negativeCondition: $negativeCondition, '
        'errorType: $errorType, '
        'errorTextId: $errorTextId, '
        'scriptName: $scriptName, '
        'comment: $comment'
        ')';
  }
}
