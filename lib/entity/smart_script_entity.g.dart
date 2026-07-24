// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_script_entity.dart';

mixin _SmartScriptEntityMixin {
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
    final self = this as SmartScriptEntity;
    return SmartScriptEntity(
      entryOrGuid: entryOrGuid ?? self.entryOrGuid,
      sourceType: sourceType ?? self.sourceType,
      id: id ?? self.id,
      link: link ?? self.link,
      eventType: eventType ?? self.eventType,
      eventPhaseMask: eventPhaseMask ?? self.eventPhaseMask,
      eventChance: eventChance ?? self.eventChance,
      eventFlags: eventFlags ?? self.eventFlags,
      eventParam1: eventParam1 ?? self.eventParam1,
      eventParam2: eventParam2 ?? self.eventParam2,
      eventParam3: eventParam3 ?? self.eventParam3,
      eventParam4: eventParam4 ?? self.eventParam4,
      eventParam5: eventParam5 ?? self.eventParam5,
      eventParam6: eventParam6 ?? self.eventParam6,
      actionType: actionType ?? self.actionType,
      actionParam1: actionParam1 ?? self.actionParam1,
      actionParam2: actionParam2 ?? self.actionParam2,
      actionParam3: actionParam3 ?? self.actionParam3,
      actionParam4: actionParam4 ?? self.actionParam4,
      actionParam5: actionParam5 ?? self.actionParam5,
      actionParam6: actionParam6 ?? self.actionParam6,
      targetType: targetType ?? self.targetType,
      targetParam1: targetParam1 ?? self.targetParam1,
      targetParam2: targetParam2 ?? self.targetParam2,
      targetParam3: targetParam3 ?? self.targetParam3,
      targetParam4: targetParam4 ?? self.targetParam4,
      targetX: targetX ?? self.targetX,
      targetY: targetY ?? self.targetY,
      targetZ: targetZ ?? self.targetZ,
      targetO: targetO ?? self.targetO,
      comment: comment ?? self.comment,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SmartScriptEntity;
    return {
      'entryorguid': self.entryOrGuid,
      'source_type': self.sourceType,
      'id': self.id,
      'link': self.link,
      'event_type': self.eventType,
      'event_phase_mask': self.eventPhaseMask,
      'event_chance': self.eventChance,
      'event_flags': self.eventFlags,
      'event_param1': self.eventParam1,
      'event_param2': self.eventParam2,
      'event_param3': self.eventParam3,
      'event_param4': self.eventParam4,
      'event_param5': self.eventParam5,
      'event_param6': self.eventParam6,
      'action_type': self.actionType,
      'action_param1': self.actionParam1,
      'action_param2': self.actionParam2,
      'action_param3': self.actionParam3,
      'action_param4': self.actionParam4,
      'action_param5': self.actionParam5,
      'action_param6': self.actionParam6,
      'target_type': self.targetType,
      'target_param1': self.targetParam1,
      'target_param2': self.targetParam2,
      'target_param3': self.targetParam3,
      'target_param4': self.targetParam4,
      'target_x': self.targetX,
      'target_y': self.targetY,
      'target_z': self.targetZ,
      'target_o': self.targetO,
      'comment': self.comment,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SmartScriptEntity;
    return identical(self, other) ||
        other is SmartScriptEntity &&
            self.runtimeType == other.runtimeType &&
            self.entryOrGuid == other.entryOrGuid &&
            self.sourceType == other.sourceType &&
            self.id == other.id &&
            self.link == other.link &&
            self.eventType == other.eventType &&
            self.eventPhaseMask == other.eventPhaseMask &&
            self.eventChance == other.eventChance &&
            self.eventFlags == other.eventFlags &&
            self.eventParam1 == other.eventParam1 &&
            self.eventParam2 == other.eventParam2 &&
            self.eventParam3 == other.eventParam3 &&
            self.eventParam4 == other.eventParam4 &&
            self.eventParam5 == other.eventParam5 &&
            self.eventParam6 == other.eventParam6 &&
            self.actionType == other.actionType &&
            self.actionParam1 == other.actionParam1 &&
            self.actionParam2 == other.actionParam2 &&
            self.actionParam3 == other.actionParam3 &&
            self.actionParam4 == other.actionParam4 &&
            self.actionParam5 == other.actionParam5 &&
            self.actionParam6 == other.actionParam6 &&
            self.targetType == other.targetType &&
            self.targetParam1 == other.targetParam1 &&
            self.targetParam2 == other.targetParam2 &&
            self.targetParam3 == other.targetParam3 &&
            self.targetParam4 == other.targetParam4 &&
            self.targetX == other.targetX &&
            self.targetY == other.targetY &&
            self.targetZ == other.targetZ &&
            self.targetO == other.targetO &&
            self.comment == other.comment;
  }

  @override
  int get hashCode {
    final self = this as SmartScriptEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entryOrGuid,
      self.sourceType,
      self.id,
      self.link,
      self.eventType,
      self.eventPhaseMask,
      self.eventChance,
      self.eventFlags,
      self.eventParam1,
      self.eventParam2,
      self.eventParam3,
      self.eventParam4,
      self.eventParam5,
      self.eventParam6,
      self.actionType,
      self.actionParam1,
      self.actionParam2,
      self.actionParam3,
      self.actionParam4,
      self.actionParam5,
      self.actionParam6,
      self.targetType,
      self.targetParam1,
      self.targetParam2,
      self.targetParam3,
      self.targetParam4,
      self.targetX,
      self.targetY,
      self.targetZ,
      self.targetO,
      self.comment,
    ]);
  }

  @override
  String toString() {
    final self = this as SmartScriptEntity;
    return 'SmartScriptEntity('
        'entryOrGuid: ${self.entryOrGuid}, '
        'sourceType: ${self.sourceType}, '
        'id: ${self.id}, '
        'link: ${self.link}, '
        'eventType: ${self.eventType}, '
        'eventPhaseMask: ${self.eventPhaseMask}, '
        'eventChance: ${self.eventChance}, '
        'eventFlags: ${self.eventFlags}, '
        'eventParam1: ${self.eventParam1}, '
        'eventParam2: ${self.eventParam2}, '
        'eventParam3: ${self.eventParam3}, '
        'eventParam4: ${self.eventParam4}, '
        'eventParam5: ${self.eventParam5}, '
        'eventParam6: ${self.eventParam6}, '
        'actionType: ${self.actionType}, '
        'actionParam1: ${self.actionParam1}, '
        'actionParam2: ${self.actionParam2}, '
        'actionParam3: ${self.actionParam3}, '
        'actionParam4: ${self.actionParam4}, '
        'actionParam5: ${self.actionParam5}, '
        'actionParam6: ${self.actionParam6}, '
        'targetType: ${self.targetType}, '
        'targetParam1: ${self.targetParam1}, '
        'targetParam2: ${self.targetParam2}, '
        'targetParam3: ${self.targetParam3}, '
        'targetParam4: ${self.targetParam4}, '
        'targetX: ${self.targetX}, '
        'targetY: ${self.targetY}, '
        'targetZ: ${self.targetZ}, '
        'targetO: ${self.targetO}, '
        'comment: ${self.comment}'
        ')';
  }
}

final class SmartScriptKey {
  final int entryOrGuid;
  final int sourceType;
  final int id;
  final int link;

  const SmartScriptKey({
    required this.entryOrGuid,
    required this.sourceType,
    required this.id,
    required this.link,
  });

  factory SmartScriptKey.fromEntity(SmartScriptEntity entity) {
    return SmartScriptKey(
      entryOrGuid: entity.entryOrGuid,
      sourceType: entity.sourceType,
      id: entity.id,
      link: entity.link,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SmartScriptKey &&
            entryOrGuid == other.entryOrGuid &&
            sourceType == other.sourceType &&
            id == other.id &&
            link == other.link;
  }

  @override
  int get hashCode => Object.hashAll([entryOrGuid, sourceType, id, link]);

  @override
  String toString() {
    return 'SmartScriptKey('
        'entryOrGuid: $entryOrGuid, '
        'sourceType: $sourceType, '
        'id: $id, '
        'link: $link'
        ')';
  }
}
