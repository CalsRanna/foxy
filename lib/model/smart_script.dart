class BriefSmartScript {
  int entryOrGuid = 0;
  int sourceType = 0;
  int id = 0;
  int link = 0;
  String comment = '';
  int eventType = 0;
  int actionType = 0;
  int targetType = 0;

  BriefSmartScript();

  BriefSmartScript.fromJson(Map<String, dynamic> json) {
    entryOrGuid = json['entryorguid'] ?? 0;
    sourceType = json['source_type'] ?? 0;
    id = json['id'] ?? 0;
    link = json['link'] ?? 0;
    comment = json['comment'] ?? '';
    eventType = json['event_type'] ?? 0;
    actionType = json['action_type'] ?? 0;
    targetType = json['target_type'] ?? 0;
  }

  String get displayName => comment;
}

class SmartScript {
  int entryOrGuid = 0;
  int sourceType = 0;
  int id = 0;
  int link = 0;
  int eventType = 0;
  int eventPhaseMask = 0;
  int eventChance = 0;
  int eventFlags = 0;
  int eventParam1 = 0;
  int eventParam2 = 0;
  int eventParam3 = 0;
  int eventParam4 = 0;
  int eventParam5 = 0;
  int actionType = 0;
  int actionParam1 = 0;
  int actionParam2 = 0;
  int actionParam3 = 0;
  int actionParam4 = 0;
  int actionParam5 = 0;
  int actionParam6 = 0;
  int targetType = 0;
  int targetParam1 = 0;
  int targetParam2 = 0;
  int targetParam3 = 0;
  int targetParam4 = 0;
  double targetX = 0;
  double targetY = 0;
  double targetZ = 0;
  double targetO = 0;
  String comment = '';

  SmartScript();

  SmartScript.fromJson(Map<String, dynamic> json) {
    entryOrGuid = json['entryorguid'] ?? 0;
    sourceType = json['source_type'] ?? 0;
    id = json['id'] ?? 0;
    link = json['link'] ?? 0;
    eventType = json['event_type'] ?? 0;
    eventPhaseMask = json['event_phase_mask'] ?? 0;
    eventChance = json['event_chance'] ?? 0;
    eventFlags = json['event_flags'] ?? 0;
    eventParam1 = json['event_param1'] ?? 0;
    eventParam2 = json['event_param2'] ?? 0;
    eventParam3 = json['event_param3'] ?? 0;
    eventParam4 = json['event_param4'] ?? 0;
    eventParam5 = json['event_param5'] ?? 0;
    actionType = json['action_type'] ?? 0;
    actionParam1 = json['action_param1'] ?? 0;
    actionParam2 = json['action_param2'] ?? 0;
    actionParam3 = json['action_param3'] ?? 0;
    actionParam4 = json['action_param4'] ?? 0;
    actionParam5 = json['action_param5'] ?? 0;
    actionParam6 = json['action_param6'] ?? 0;
    targetType = json['target_type'] ?? 0;
    targetParam1 = json['target_param1'] ?? 0;
    targetParam2 = json['target_param2'] ?? 0;
    targetParam3 = json['target_param3'] ?? 0;
    targetParam4 = json['target_param4'] ?? 0;
    targetX = (json['target_x'] ?? 0).toDouble();
    targetY = (json['target_y'] ?? 0).toDouble();
    targetZ = (json['target_z'] ?? 0).toDouble();
    targetO = (json['target_o'] ?? 0).toDouble();
    comment = json['comment'] ?? '';
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

  SmartScript copyWith({
    int? entryOrGuid,
    int? sourceType,
    int? id,
    int? link,
  }) {
    return SmartScript()
      ..entryOrGuid = entryOrGuid ?? this.entryOrGuid
      ..sourceType = sourceType ?? this.sourceType
      ..id = id ?? this.id
      ..link = link ?? this.link;
  }
}
