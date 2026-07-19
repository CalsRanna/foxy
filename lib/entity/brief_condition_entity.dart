import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/entity/condition_key.dart';

/// 条件列表页用的精简实体
/// 携带全部 10 列主键（用于导航/复制/删除）+ Comment（人类可读说明）
/// 展示只取 5 列：SourceType 标签、SourceEntry、ConditionType 标签、ConditionValue1、Comment
class BriefConditionEntity {
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
      comment: json['Comment'] ?? '',
    );
  }

  /// 条件类型标签：非负值映射枚举，负值表示引用
  String get conditionTypeLabel {
    final id = conditionTypeOrReference;
    if (id < 0) return '引用 $id';
    return kConditionTypeLabels[id] ?? id.toString();
  }

  /// 来源类型标签：非负值映射枚举，负值表示引用
  String get sourceTypeLabel {
    final id = sourceTypeOrReferenceId;
    if (id < 0) return '引用 $id';
    return kConditionSourceTypeLabels[id] ?? id.toString();
  }

  ConditionKey get key => ConditionKey(
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
