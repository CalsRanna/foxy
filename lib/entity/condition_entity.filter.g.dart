// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class ConditionFilterEntity {
  final String sourceTypeOrReferenceId;
  final String sourceEntry;

  const ConditionFilterEntity({
    this.sourceTypeOrReferenceId = '',
    this.sourceEntry = '',
  });

  factory ConditionFilterEntity.fromJson(Map<String, dynamic> json) {
    return ConditionFilterEntity(
      sourceTypeOrReferenceId:
          json['sourceTypeOrReferenceId']?.toString() ?? '',
      sourceEntry: json['sourceEntry']?.toString() ?? '',
    );
  }

  ConditionFilterEntity copyWith({
    String? sourceTypeOrReferenceId,
    String? sourceEntry,
  }) {
    return ConditionFilterEntity(
      sourceTypeOrReferenceId:
          sourceTypeOrReferenceId ?? this.sourceTypeOrReferenceId,
      sourceEntry: sourceEntry ?? this.sourceEntry,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sourceTypeOrReferenceId': sourceTypeOrReferenceId,
      'sourceEntry': sourceEntry,
    };
  }
}
