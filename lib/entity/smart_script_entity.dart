// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'smart_script_entity.g.dart';

@FoxyFilterEntity()
@FoxyFullEntity(table: 'smart_scripts')
class SmartScriptEntity with _SmartScriptEntityMixin {
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('entryorguid', key: true)
  final int entryOrGuid;

  @FoxyFullField('source_type', key: true)
  final int sourceType;

  @FoxyFullField('id', key: true)
  final int id;

  @FoxyFullField('link', key: true)
  final int link;

  @FoxyFullField('event_type')
  final int eventType;

  @FoxyFullField('event_phase_mask')
  final int eventPhaseMask;

  @FoxyFullField('event_chance')
  final int eventChance;

  @FoxyFullField('event_flags')
  final int eventFlags;

  @FoxyFullField('event_param1')
  final int eventParam1;

  @FoxyFullField('event_param2')
  final int eventParam2;

  @FoxyFullField('event_param3')
  final int eventParam3;

  @FoxyFullField('event_param4')
  final int eventParam4;

  @FoxyFullField('event_param5')
  final int eventParam5;

  @FoxyFullField('event_param6')
  final int eventParam6;

  @FoxyFullField('action_type')
  final int actionType;

  @FoxyFullField('action_param1')
  final int actionParam1;

  @FoxyFullField('action_param2')
  final int actionParam2;

  @FoxyFullField('action_param3')
  final int actionParam3;

  @FoxyFullField('action_param4')
  final int actionParam4;

  @FoxyFullField('action_param5')
  final int actionParam5;

  @FoxyFullField('action_param6')
  final int actionParam6;

  @FoxyFullField('target_type')
  final int targetType;

  @FoxyFullField('target_param1')
  final int targetParam1;

  @FoxyFullField('target_param2')
  final int targetParam2;

  @FoxyFullField('target_param3')
  final int targetParam3;

  @FoxyFullField('target_param4')
  final int targetParam4;

  @FoxyFullField('target_x')
  final double targetX;

  @FoxyFullField('target_y')
  final double targetY;

  @FoxyFullField('target_z')
  final double targetZ;

  @FoxyFullField('target_o')
  final double targetO;

  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('comment')
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

  factory SmartScriptEntity.fromJson(Map<String, dynamic> json) =>
      _SmartScriptEntityMixin.fromJson(json);
}
