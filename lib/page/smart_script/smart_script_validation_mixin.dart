import 'package:foxy/constant/smart_script_constants.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SmartScriptValidationMixin on ViewModelValidationMixin {
  void validateSmartScriptFields(SmartScriptEntity value) {
    if (value.entryOrGuid == 0) {
      throw ArgumentError.value(value.entryOrGuid, 'entryorguid', '不能为 0');
    }
    if (!kSourceTypes.containsKey(value.sourceType)) {
      throw ArgumentError.value(
        value.sourceType,
        'source_type',
        '当前 core 不加载该来源类型',
      );
    }
    if (value.id < 0 ||
        value.id > 0xFFFF ||
        value.link < 0 ||
        value.link > 0xFFFF) {
      throw ArgumentError('id 和 link 必须在 0..65535');
    }
    if (!kEventTypes.containsKey(value.eventType)) {
      throw ArgumentError.value(
        value.eventType,
        'event_type',
        '当前 core 不支持该事件',
      );
    }
    if (!smartEventTypesForSource(
      value.sourceType,
    ).containsKey(value.eventType)) {
      throw ArgumentError(
        'event_type ${value.eventType} 不能用于 source_type ${value.sourceType}',
      );
    }
    if (!kActionTypes.containsKey(value.actionType)) {
      throw ArgumentError.value(
        value.actionType,
        'action_type',
        '当前 core 不支持该动作',
      );
    }
    if (!kTargetTypes.containsKey(value.targetType)) {
      throw ArgumentError.value(
        value.targetType,
        'target_type',
        '当前 core 不支持该目标',
      );
    }
    if (value.eventPhaseMask < 0 || value.eventPhaseMask > 0xFFF) {
      throw ArgumentError.value(
        value.eventPhaseMask,
        'event_phase_mask',
        '必须在 0..4095',
      );
    }
    if (value.eventChance < 0 || value.eventChance > 100) {
      throw ArgumentError.value(
        value.eventChance,
        'event_chance',
        '必须在 0..100',
      );
    }
    if (value.eventFlags < 0 || value.eventFlags > 0x3FF) {
      throw ArgumentError.value(
        value.eventFlags,
        'event_flags',
        '包含数据库不可存储的标志位',
      );
    }
    if (value.eventType == 61 && value.link != 0 && value.link == value.id) {
      throw ArgumentError('LINK 事件不能链接到自身');
    }
    _validateUnsignedParameters(value);
    _validateUnusedParameters(value);
    if (!value.targetX.isFinite ||
        !value.targetY.isFinite ||
        !value.targetZ.isFinite ||
        !value.targetO.isFinite) {
      throw ArgumentError('目标坐标必须是有限数值');
    }
  }

  void _validateUnsignedParameters(SmartScriptEntity value) {
    void check(int fieldValue, String name) {
      if (fieldValue < 0 || fieldValue > 0xFFFFFFFF) {
        throw ArgumentError.value(fieldValue, name, '必须在 uint32 范围内');
      }
    }

    check(value.eventParam1, 'event_param1');
    check(value.eventParam2, 'event_param2');
    check(value.eventParam3, 'event_param3');
    check(value.eventParam4, 'event_param4');
    check(value.eventParam5, 'event_param5');
    check(value.eventParam6, 'event_param6');
    check(value.actionParam1, 'action_param1');
    check(value.actionParam2, 'action_param2');
    check(value.actionParam3, 'action_param3');
    check(value.actionParam4, 'action_param4');
    check(value.actionParam5, 'action_param5');
    check(value.actionParam6, 'action_param6');
    check(value.targetParam1, 'target_param1');
    check(value.targetParam2, 'target_param2');
    check(value.targetParam3, 'target_param3');
    check(value.targetParam4, 'target_param4');
  }

  void _validateUnusedParameters(SmartScriptEntity value) {
    final event = smartEventParameterConfig(value.eventType);
    final action = smartActionParameterConfig(value.actionType);
    final target = smartTargetParameterConfig(value.targetType);
    _requireZeroIfUnused(value.eventParam1, event.param1, 'event_param1');
    _requireZeroIfUnused(value.eventParam2, event.param2, 'event_param2');
    _requireZeroIfUnused(value.eventParam3, event.param3, 'event_param3');
    _requireZeroIfUnused(value.eventParam4, event.param4, 'event_param4');
    _requireZeroIfUnused(value.eventParam5, event.param5, 'event_param5');
    _requireZeroIfUnused(value.eventParam6, event.param6, 'event_param6');
    _requireZeroIfUnused(value.actionParam1, action.param1, 'action_param1');
    _requireZeroIfUnused(value.actionParam2, action.param2, 'action_param2');
    _requireZeroIfUnused(value.actionParam3, action.param3, 'action_param3');
    _requireZeroIfUnused(value.actionParam4, action.param4, 'action_param4');
    _requireZeroIfUnused(value.actionParam5, action.param5, 'action_param5');
    _requireZeroIfUnused(value.actionParam6, action.param6, 'action_param6');
    _requireZeroIfUnused(value.targetParam1, target.param1, 'target_param1');
    _requireZeroIfUnused(value.targetParam2, target.param2, 'target_param2');
    _requireZeroIfUnused(value.targetParam3, target.param3, 'target_param3');
    _requireZeroIfUnused(value.targetParam4, target.param4, 'target_param4');
  }

  void _requireZeroIfUnused(
    int value,
    SmartParameterFieldConfig config,
    String name,
  ) {
    if (!config.editable && value != 0) {
      throw ArgumentError.value(value, name, '未使用字段必须为 0');
    }
  }
}
