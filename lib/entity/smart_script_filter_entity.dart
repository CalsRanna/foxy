class SmartScriptFilterEntity {
  final String entryOrGuid;
  final String comment;

  const SmartScriptFilterEntity({this.entryOrGuid = '', this.comment = ''});

  Map<String, dynamic> toJson() {
    return {'entryOrGuid': entryOrGuid, 'comment': comment};
  }

  SmartScriptFilterEntity copyWith({
    String? entryOrGuid,
    String? comment,
  }) {
    return SmartScriptFilterEntity(
      entryOrGuid: entryOrGuid ?? this.entryOrGuid,
      comment: comment ?? this.comment,
    );
  }

  factory SmartScriptFilterEntity.fromJson(Map<String, dynamic> json) {
    return SmartScriptFilterEntity(
      entryOrGuid: json['entryOrGuid'] ?? '',
      comment: json['comment'] ?? '',
    );
  }
}
