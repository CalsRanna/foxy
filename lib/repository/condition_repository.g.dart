// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condition_repository.dart';

final class ConditionFilter {
  final String sourceTypeOrReferenceId;
  final String sourceEntry;

  const ConditionFilter({
    this.sourceTypeOrReferenceId = '',
    this.sourceEntry = '',
  });

  factory ConditionFilter.fromJson(Map<String, dynamic> json) {
    return ConditionFilter(
      sourceTypeOrReferenceId:
          json['sourceTypeOrReferenceId']?.toString() ?? '',
      sourceEntry: json['sourceEntry']?.toString() ?? '',
    );
  }

  ConditionFilter copyWith({
    String? sourceTypeOrReferenceId,
    String? sourceEntry,
  }) {
    return ConditionFilter(
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
