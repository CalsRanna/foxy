// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_script_repository.dart';

final class SmartScriptFilter {
  final String entryOrGuid;
  final String comment;

  const SmartScriptFilter({this.entryOrGuid = '', this.comment = ''});

  factory SmartScriptFilter.fromJson(Map<String, dynamic> json) {
    return SmartScriptFilter(
      entryOrGuid: json['entryOrGuid']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
    );
  }

  SmartScriptFilter copyWith({String? entryOrGuid, String? comment}) {
    return SmartScriptFilter(
      entryOrGuid: entryOrGuid ?? this.entryOrGuid,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entryOrGuid': entryOrGuid, 'comment': comment};
  }
}
