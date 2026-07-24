// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_script_entity.dart';

mixin _SmartScriptEntityMixin {
  int get entryOrGuid;
  int get sourceType;
  int get id;
  int get link;
  int get eventType;
  int get eventPhaseMask;
  int get eventChance;
  int get eventFlags;
  int get eventParam1;
  int get eventParam2;
  int get eventParam3;
  int get eventParam4;
  int get eventParam5;
  int get eventParam6;
  int get actionType;
  int get actionParam1;
  int get actionParam2;
  int get actionParam3;
  int get actionParam4;
  int get actionParam5;
  int get actionParam6;
  int get targetType;
  int get targetParam1;
  int get targetParam2;
  int get targetParam3;
  int get targetParam4;
  double get targetX;
  double get targetY;
  double get targetZ;
  double get targetO;
  String get comment;

  static SmartScriptEntity fromJson(Map<String, dynamic> json) {
    return SmartScriptEntity(
      entryOrGuid: (json['entryorguid'] as num?)?.toInt() ?? 0,
      sourceType: (json['source_type'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt() ?? 0,
      link: (json['link'] as num?)?.toInt() ?? 0,
      eventType: (json['event_type'] as num?)?.toInt() ?? 0,
      eventPhaseMask: (json['event_phase_mask'] as num?)?.toInt() ?? 0,
      eventChance: (json['event_chance'] as num?)?.toInt() ?? 100,
      eventFlags: (json['event_flags'] as num?)?.toInt() ?? 0,
      eventParam1: (json['event_param1'] as num?)?.toInt() ?? 0,
      eventParam2: (json['event_param2'] as num?)?.toInt() ?? 0,
      eventParam3: (json['event_param3'] as num?)?.toInt() ?? 0,
      eventParam4: (json['event_param4'] as num?)?.toInt() ?? 0,
      eventParam5: (json['event_param5'] as num?)?.toInt() ?? 0,
      eventParam6: (json['event_param6'] as num?)?.toInt() ?? 0,
      actionType: (json['action_type'] as num?)?.toInt() ?? 0,
      actionParam1: (json['action_param1'] as num?)?.toInt() ?? 0,
      actionParam2: (json['action_param2'] as num?)?.toInt() ?? 0,
      actionParam3: (json['action_param3'] as num?)?.toInt() ?? 0,
      actionParam4: (json['action_param4'] as num?)?.toInt() ?? 0,
      actionParam5: (json['action_param5'] as num?)?.toInt() ?? 0,
      actionParam6: (json['action_param6'] as num?)?.toInt() ?? 0,
      targetType: (json['target_type'] as num?)?.toInt() ?? 0,
      targetParam1: (json['target_param1'] as num?)?.toInt() ?? 0,
      targetParam2: (json['target_param2'] as num?)?.toInt() ?? 0,
      targetParam3: (json['target_param3'] as num?)?.toInt() ?? 0,
      targetParam4: (json['target_param4'] as num?)?.toInt() ?? 0,
      targetX: (json['target_x'] as num?)?.toDouble() ?? 0.0,
      targetY: (json['target_y'] as num?)?.toDouble() ?? 0.0,
      targetZ: (json['target_z'] as num?)?.toDouble() ?? 0.0,
      targetO: (json['target_o'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment']?.toString() ?? '',
    );
  }

  SmartScriptEntity copyWith({
    int? entryOrGuid,
    int? sourceType,
    int? id,
    int? link,
    int? eventType,
    int? eventPhaseMask,
    int? eventChance,
    int? eventFlags,
    int? eventParam1,
    int? eventParam2,
    int? eventParam3,
    int? eventParam4,
    int? eventParam5,
    int? eventParam6,
    int? actionType,
    int? actionParam1,
    int? actionParam2,
    int? actionParam3,
    int? actionParam4,
    int? actionParam5,
    int? actionParam6,
    int? targetType,
    int? targetParam1,
    int? targetParam2,
    int? targetParam3,
    int? targetParam4,
    double? targetX,
    double? targetY,
    double? targetZ,
    double? targetO,
    String? comment,
  }) {
    return SmartScriptEntity(
      entryOrGuid: entryOrGuid ?? this.entryOrGuid,
      sourceType: sourceType ?? this.sourceType,
      id: id ?? this.id,
      link: link ?? this.link,
      eventType: eventType ?? this.eventType,
      eventPhaseMask: eventPhaseMask ?? this.eventPhaseMask,
      eventChance: eventChance ?? this.eventChance,
      eventFlags: eventFlags ?? this.eventFlags,
      eventParam1: eventParam1 ?? this.eventParam1,
      eventParam2: eventParam2 ?? this.eventParam2,
      eventParam3: eventParam3 ?? this.eventParam3,
      eventParam4: eventParam4 ?? this.eventParam4,
      eventParam5: eventParam5 ?? this.eventParam5,
      eventParam6: eventParam6 ?? this.eventParam6,
      actionType: actionType ?? this.actionType,
      actionParam1: actionParam1 ?? this.actionParam1,
      actionParam2: actionParam2 ?? this.actionParam2,
      actionParam3: actionParam3 ?? this.actionParam3,
      actionParam4: actionParam4 ?? this.actionParam4,
      actionParam5: actionParam5 ?? this.actionParam5,
      actionParam6: actionParam6 ?? this.actionParam6,
      targetType: targetType ?? this.targetType,
      targetParam1: targetParam1 ?? this.targetParam1,
      targetParam2: targetParam2 ?? this.targetParam2,
      targetParam3: targetParam3 ?? this.targetParam3,
      targetParam4: targetParam4 ?? this.targetParam4,
      targetX: targetX ?? this.targetX,
      targetY: targetY ?? this.targetY,
      targetZ: targetZ ?? this.targetZ,
      targetO: targetO ?? this.targetO,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entryorguid': entryOrGuid,
      'source_type': sourceType,
      'id': id,
      'link': link,
      'event_type': eventType,
      'event_phase_mask': eventPhaseMask,
      'event_chance': eventChance,
      'event_flags': eventFlags,
      'event_param1': eventParam1,
      'event_param2': eventParam2,
      'event_param3': eventParam3,
      'event_param4': eventParam4,
      'event_param5': eventParam5,
      'event_param6': eventParam6,
      'action_type': actionType,
      'action_param1': actionParam1,
      'action_param2': actionParam2,
      'action_param3': actionParam3,
      'action_param4': actionParam4,
      'action_param5': actionParam5,
      'action_param6': actionParam6,
      'target_type': targetType,
      'target_param1': targetParam1,
      'target_param2': targetParam2,
      'target_param3': targetParam3,
      'target_param4': targetParam4,
      'target_x': targetX,
      'target_y': targetY,
      'target_z': targetZ,
      'target_o': targetO,
      'comment': comment,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SmartScriptEntity &&
            runtimeType == other.runtimeType &&
            entryOrGuid == other.entryOrGuid &&
            sourceType == other.sourceType &&
            id == other.id &&
            link == other.link &&
            eventType == other.eventType &&
            eventPhaseMask == other.eventPhaseMask &&
            eventChance == other.eventChance &&
            eventFlags == other.eventFlags &&
            eventParam1 == other.eventParam1 &&
            eventParam2 == other.eventParam2 &&
            eventParam3 == other.eventParam3 &&
            eventParam4 == other.eventParam4 &&
            eventParam5 == other.eventParam5 &&
            eventParam6 == other.eventParam6 &&
            actionType == other.actionType &&
            actionParam1 == other.actionParam1 &&
            actionParam2 == other.actionParam2 &&
            actionParam3 == other.actionParam3 &&
            actionParam4 == other.actionParam4 &&
            actionParam5 == other.actionParam5 &&
            actionParam6 == other.actionParam6 &&
            targetType == other.targetType &&
            targetParam1 == other.targetParam1 &&
            targetParam2 == other.targetParam2 &&
            targetParam3 == other.targetParam3 &&
            targetParam4 == other.targetParam4 &&
            targetX == other.targetX &&
            targetY == other.targetY &&
            targetZ == other.targetZ &&
            targetO == other.targetO &&
            comment == other.comment;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      entryOrGuid,
      sourceType,
      id,
      link,
      eventType,
      eventPhaseMask,
      eventChance,
      eventFlags,
      eventParam1,
      eventParam2,
      eventParam3,
      eventParam4,
      eventParam5,
      eventParam6,
      actionType,
      actionParam1,
      actionParam2,
      actionParam3,
      actionParam4,
      actionParam5,
      actionParam6,
      targetType,
      targetParam1,
      targetParam2,
      targetParam3,
      targetParam4,
      targetX,
      targetY,
      targetZ,
      targetO,
      comment,
    ]);
  }

  @override
  String toString() {
    return 'SmartScriptEntity('
        'entryOrGuid: $entryOrGuid, '
        'sourceType: $sourceType, '
        'id: $id, '
        'link: $link, '
        'eventType: $eventType, '
        'eventPhaseMask: $eventPhaseMask, '
        'eventChance: $eventChance, '
        'eventFlags: $eventFlags, '
        'eventParam1: $eventParam1, '
        'eventParam2: $eventParam2, '
        'eventParam3: $eventParam3, '
        'eventParam4: $eventParam4, '
        'eventParam5: $eventParam5, '
        'eventParam6: $eventParam6, '
        'actionType: $actionType, '
        'actionParam1: $actionParam1, '
        'actionParam2: $actionParam2, '
        'actionParam3: $actionParam3, '
        'actionParam4: $actionParam4, '
        'actionParam5: $actionParam5, '
        'actionParam6: $actionParam6, '
        'targetType: $targetType, '
        'targetParam1: $targetParam1, '
        'targetParam2: $targetParam2, '
        'targetParam3: $targetParam3, '
        'targetParam4: $targetParam4, '
        'targetX: $targetX, '
        'targetY: $targetY, '
        'targetZ: $targetZ, '
        'targetO: $targetO, '
        'comment: $comment'
        ')';
  }
}
