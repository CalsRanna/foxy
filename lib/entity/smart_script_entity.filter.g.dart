// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class SmartScriptFilterEntity {
  final String entryOrGuid;
  final String comment;

  const SmartScriptFilterEntity({this.entryOrGuid = '', this.comment = ''});

  factory SmartScriptFilterEntity.fromJson(Map<String, dynamic> json) {
    return SmartScriptFilterEntity(
      entryOrGuid: json['entryOrGuid']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
    );
  }

  SmartScriptFilterEntity copyWith({String? entryOrGuid, String? comment}) {
    return SmartScriptFilterEntity(
      entryOrGuid: entryOrGuid ?? this.entryOrGuid,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entryOrGuid': entryOrGuid, 'comment': comment};
  }
}
