class ConditionEntity {
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
  final int negativeCondition;
  final int errorType;
  final int errorTextId;
  final String scriptName;
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

  factory ConditionEntity.fromJson(Map<String, dynamic> json) {
    return ConditionEntity(
      sourceTypeOrReferenceId: json['SourceTypeOrReferenceId'] ?? 0,
      sourceGroup: json['SourceGroup'] ?? 0,
      sourceEntry: json['SourceEntry'] ?? 0,
      sourceId: json['SourceId'] ?? 0,
      elseGroup: json['ElseGroup'] ?? 0,
      conditionTypeOrReference: json['ConditionTypeOrReference'] ?? 0,
      conditionTarget: json['ConditionTarget'] ?? 0,
      conditionValue1: json['ConditionValue1'] ?? 0,
      conditionValue2: json['ConditionValue2'] ?? 0,
      conditionValue3: json['ConditionValue3'] ?? 0,
      negativeCondition: json['NegativeCondition'] ?? 0,
      errorType: json['ErrorType'] ?? 0,
      errorTextId: json['ErrorTextId'] ?? 0,
      scriptName: json['ScriptName'] ?? '',
      comment: json['Comment'] ?? '',
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
}
