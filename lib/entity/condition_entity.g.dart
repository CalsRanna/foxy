// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_entity.dart';

mixin _ConditionEntityMixin {
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
    final self = this as ConditionEntity;
    return ConditionEntity(
      sourceTypeOrReferenceId:
          sourceTypeOrReferenceId ?? self.sourceTypeOrReferenceId,
      sourceGroup: sourceGroup ?? self.sourceGroup,
      sourceEntry: sourceEntry ?? self.sourceEntry,
      sourceId: sourceId ?? self.sourceId,
      elseGroup: elseGroup ?? self.elseGroup,
      conditionTypeOrReference:
          conditionTypeOrReference ?? self.conditionTypeOrReference,
      conditionTarget: conditionTarget ?? self.conditionTarget,
      conditionValue1: conditionValue1 ?? self.conditionValue1,
      conditionValue2: conditionValue2 ?? self.conditionValue2,
      conditionValue3: conditionValue3 ?? self.conditionValue3,
      negativeCondition: negativeCondition ?? self.negativeCondition,
      errorType: errorType ?? self.errorType,
      errorTextId: errorTextId ?? self.errorTextId,
      scriptName: scriptName ?? self.scriptName,
      comment: comment ?? self.comment,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ConditionEntity;
    return {
      'SourceTypeOrReferenceId': self.sourceTypeOrReferenceId,
      'SourceGroup': self.sourceGroup,
      'SourceEntry': self.sourceEntry,
      'SourceId': self.sourceId,
      'ElseGroup': self.elseGroup,
      'ConditionTypeOrReference': self.conditionTypeOrReference,
      'ConditionTarget': self.conditionTarget,
      'ConditionValue1': self.conditionValue1,
      'ConditionValue2': self.conditionValue2,
      'ConditionValue3': self.conditionValue3,
      'NegativeCondition': self.negativeCondition,
      'ErrorType': self.errorType,
      'ErrorTextId': self.errorTextId,
      'ScriptName': self.scriptName,
      'Comment': self.comment,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as ConditionEntity;
    return identical(self, other) ||
        other is ConditionEntity &&
            self.runtimeType == other.runtimeType &&
            self.sourceTypeOrReferenceId == other.sourceTypeOrReferenceId &&
            self.sourceGroup == other.sourceGroup &&
            self.sourceEntry == other.sourceEntry &&
            self.sourceId == other.sourceId &&
            self.elseGroup == other.elseGroup &&
            self.conditionTypeOrReference == other.conditionTypeOrReference &&
            self.conditionTarget == other.conditionTarget &&
            self.conditionValue1 == other.conditionValue1 &&
            self.conditionValue2 == other.conditionValue2 &&
            self.conditionValue3 == other.conditionValue3 &&
            self.negativeCondition == other.negativeCondition &&
            self.errorType == other.errorType &&
            self.errorTextId == other.errorTextId &&
            self.scriptName == other.scriptName &&
            self.comment == other.comment;
  }

  @override
  int get hashCode {
    final self = this as ConditionEntity;
    return Object.hashAll([
      self.runtimeType,
      self.sourceTypeOrReferenceId,
      self.sourceGroup,
      self.sourceEntry,
      self.sourceId,
      self.elseGroup,
      self.conditionTypeOrReference,
      self.conditionTarget,
      self.conditionValue1,
      self.conditionValue2,
      self.conditionValue3,
      self.negativeCondition,
      self.errorType,
      self.errorTextId,
      self.scriptName,
      self.comment,
    ]);
  }

  @override
  String toString() {
    final self = this as ConditionEntity;
    return 'ConditionEntity('
        'sourceTypeOrReferenceId: ${self.sourceTypeOrReferenceId}, '
        'sourceGroup: ${self.sourceGroup}, '
        'sourceEntry: ${self.sourceEntry}, '
        'sourceId: ${self.sourceId}, '
        'elseGroup: ${self.elseGroup}, '
        'conditionTypeOrReference: ${self.conditionTypeOrReference}, '
        'conditionTarget: ${self.conditionTarget}, '
        'conditionValue1: ${self.conditionValue1}, '
        'conditionValue2: ${self.conditionValue2}, '
        'conditionValue3: ${self.conditionValue3}, '
        'negativeCondition: ${self.negativeCondition}, '
        'errorType: ${self.errorType}, '
        'errorTextId: ${self.errorTextId}, '
        'scriptName: ${self.scriptName}, '
        'comment: ${self.comment}'
        ')';
  }
}
