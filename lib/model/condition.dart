class Condition {
  int sourceTypeOrReferenceId = 0;
  int sourceGroup = 0;
  int sourceEntry = 0;
  int sourceId = 0;
  int elseGroup = 0;
  int conditionTypeOrReference = 0;
  int conditionTarget = 0;
  int conditionValue1 = 0;
  int conditionValue2 = 0;
  int conditionValue3 = 0;
  int negativeCondition = 0;
  int errorType = 0;
  int errorTextId = 0;
  String scriptName = '';
  String comment = '';

  Condition();

  /// 构建用于查找/更新/删除的 credential map
  Map<String, dynamic> buildCredential() {
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
    };
  }

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition()
      ..sourceTypeOrReferenceId = json['SourceTypeOrReferenceId'] ?? 0
      ..sourceGroup = json['SourceGroup'] ?? 0
      ..sourceEntry = json['SourceEntry'] ?? 0
      ..sourceId = json['SourceId'] ?? 0
      ..elseGroup = json['ElseGroup'] ?? 0
      ..conditionTypeOrReference = json['ConditionTypeOrReference'] ?? 0
      ..conditionTarget = json['ConditionTarget'] ?? 0
      ..conditionValue1 = json['ConditionValue1'] ?? 0
      ..conditionValue2 = json['ConditionValue2'] ?? 0
      ..conditionValue3 = json['ConditionValue3'] ?? 0
      ..negativeCondition = json['NegativeCondition'] ?? 0
      ..errorType = json['ErrorType'] ?? 0
      ..errorTextId = json['ErrorTextId'] ?? 0
      ..scriptName = json['ScriptName'] ?? ''
      ..comment = json['Comment'] ?? '';
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
