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

  Map<String, dynamic> toJson() {
    return {
      'entryorguid': entryOrGuid,
      'source_type': sourceType,
      'id': id,
      'link': link,
      'comment': comment,
      'event_type': eventType,
      'action_type': actionType,
      'target_type': targetType,
    };
  }
}

class SmartScriptEntity {
  final int entryOrGuid;
  final int sourceType;
  final int id;
  final int link;
  final int eventType;
  final int eventPhaseMask;
  final int eventChance;
  final int eventFlags;
  final int eventParam1;
  final int eventParam2;
  final int eventParam3;
  final int eventParam4;
  final int eventParam5;
  final int eventParam6;
  final int actionType;
  final int actionParam1;
  final int actionParam2;
  final int actionParam3;
  final int actionParam4;
  final int actionParam5;
  final int actionParam6;
  final int targetType;
  final int targetParam1;
  final int targetParam2;
  final int targetParam3;
  final int targetParam4;
  final double targetX;
  final double targetY;
  final double targetZ;
  final double targetO;
  final String comment;

  const SmartScriptEntity({
    this.entryOrGuid = 0,
    this.sourceType = 0,
    this.id = 0,
    this.link = 0,
    this.eventType = 0,
    this.eventPhaseMask = 0,
    this.eventChance = 100,
    this.eventFlags = 0,
    this.eventParam1 = 0,
    this.eventParam2 = 0,
    this.eventParam3 = 0,
    this.eventParam4 = 0,
    this.eventParam5 = 0,
    this.eventParam6 = 0,
    this.actionType = 0,
    this.actionParam1 = 0,
    this.actionParam2 = 0,
    this.actionParam3 = 0,
    this.actionParam4 = 0,
    this.actionParam5 = 0,
    this.actionParam6 = 0,
    this.targetType = 0,
    this.targetParam1 = 0,
    this.targetParam2 = 0,
    this.targetParam3 = 0,
    this.targetParam4 = 0,
    this.targetX = 0,
    this.targetY = 0,
    this.targetZ = 0,
    this.targetO = 0,
    this.comment = '',
  });

  factory SmartScriptEntity.fromJson(Map<String, dynamic> json) {
    return SmartScriptEntity(
      entryOrGuid: json['entryorguid'] ?? 0,
      sourceType: json['source_type'] ?? 0,
      id: json['id'] ?? 0,
      link: json['link'] ?? 0,
      eventType: json['event_type'] ?? 0,
      eventPhaseMask: json['event_phase_mask'] ?? 0,
      eventChance: json['event_chance'] ?? 0,
      eventFlags: json['event_flags'] ?? 0,
      eventParam1: json['event_param1'] ?? 0,
      eventParam2: json['event_param2'] ?? 0,
      eventParam3: json['event_param3'] ?? 0,
      eventParam4: json['event_param4'] ?? 0,
      eventParam5: json['event_param5'] ?? 0,
      eventParam6: json['event_param6'] ?? 0,
      actionType: json['action_type'] ?? 0,
      actionParam1: json['action_param1'] ?? 0,
      actionParam2: json['action_param2'] ?? 0,
      actionParam3: json['action_param3'] ?? 0,
      actionParam4: json['action_param4'] ?? 0,
      actionParam5: json['action_param5'] ?? 0,
      actionParam6: json['action_param6'] ?? 0,
      targetType: json['target_type'] ?? 0,
      targetParam1: json['target_param1'] ?? 0,
      targetParam2: json['target_param2'] ?? 0,
      targetParam3: json['target_param3'] ?? 0,
      targetParam4: json['target_param4'] ?? 0,
      targetX: (json['target_x'] as num? ?? 0).toDouble(),
      targetY: (json['target_y'] as num? ?? 0).toDouble(),
      targetZ: (json['target_z'] as num? ?? 0).toDouble(),
      targetO: (json['target_o'] as num? ?? 0).toDouble(),
      comment: json['comment'] ?? '',
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
}
