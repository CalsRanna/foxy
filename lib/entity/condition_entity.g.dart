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

final class BriefConditionEntity {
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
  final String comment;

  const BriefConditionEntity({
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
    this.comment = '',
  });

  factory BriefConditionEntity.fromJson(Map<String, dynamic> json) {
    return BriefConditionEntity(
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
      comment: json['Comment']?.toString() ?? '',
    );
  }

  ConditionKey get key {
    return ConditionKey(
      sourceTypeOrReferenceId: sourceTypeOrReferenceId,
      sourceGroup: sourceGroup,
      sourceEntry: sourceEntry,
      sourceId: sourceId,
      elseGroup: elseGroup,
      conditionTypeOrReference: conditionTypeOrReference,
      conditionTarget: conditionTarget,
      conditionValue1: conditionValue1,
      conditionValue2: conditionValue2,
      conditionValue3: conditionValue3,
    );
  }
}
