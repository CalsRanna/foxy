class ConditionFilterEntity {
  String sourceTypeOrReferenceId = '';
  String sourceEntry = '';

  ConditionFilterEntity();

  factory ConditionFilterEntity.fromJson(Map<String, dynamic> json) {
    return ConditionFilterEntity()
      ..sourceTypeOrReferenceId = json['sourceTypeOrReferenceId'] ?? ''
      ..sourceEntry = json['sourceEntry'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'sourceTypeOrReferenceId': sourceTypeOrReferenceId, 'sourceEntry': sourceEntry};
  }
}
