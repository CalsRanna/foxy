import 'package:foxy/entity/smart_script_key.dart';

class BriefSmartScriptEntity {
  final int entryOrGuid;
  final int sourceType;
  final int id;
  final int link;
  final String comment;
  final int eventType;
  final int actionType;
  final int targetType;

  const BriefSmartScriptEntity({
    this.entryOrGuid = 0,
    this.sourceType = 0,
    this.id = 0,
    this.link = 0,
    this.comment = '',
    this.eventType = 0,
    this.actionType = 0,
    this.targetType = 0,
  });

  factory BriefSmartScriptEntity.fromJson(Map<String, dynamic> json) {
    return BriefSmartScriptEntity(
      entryOrGuid: json['entryorguid'] ?? 0,
      sourceType: json['source_type'] ?? 0,
      id: json['id'] ?? 0,
      link: json['link'] ?? 0,
      comment: json['comment'] ?? '',
      eventType: json['event_type'] ?? 0,
      actionType: json['action_type'] ?? 0,
      targetType: json['target_type'] ?? 0,
    );
  }

  String get displayName => comment;

  SmartScriptKey get key => SmartScriptKey(
    entryOrGuid: entryOrGuid,
    sourceType: sourceType,
    id: id,
    link: link,
  );
}
