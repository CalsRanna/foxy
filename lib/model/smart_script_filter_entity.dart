class SmartScriptFilterEntity {
  String entryOrGuid = '';
  String comment = '';

  SmartScriptFilterEntity();

  Map<String, dynamic> toJson() {
    return {'entryOrGuid': entryOrGuid, 'comment': comment};
  }

  factory SmartScriptFilterEntity.fromJson(Map<String, dynamic> json) {
    return SmartScriptFilterEntity()
      ..entryOrGuid = json['entryOrGuid'] ?? ''
      ..comment = json['comment'] ?? '';
  }
}
