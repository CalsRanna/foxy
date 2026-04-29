class ConditionFilterEntity {
  final String sourceTypeOrReferenceId;
  final String sourceEntry;

  const ConditionFilterEntity({this.sourceTypeOrReferenceId = '', this.sourceEntry = ''});

  factory ConditionFilterEntity.fromJson(Map<String, dynamic> json) {
    return ConditionFilterEntity(
      sourceTypeOrReferenceId: json['sourceTypeOrReferenceId'] ?? '',
      sourceEntry: json['sourceEntry'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'sourceTypeOrReferenceId': sourceTypeOrReferenceId, 'sourceEntry': sourceEntry};
  }
}
