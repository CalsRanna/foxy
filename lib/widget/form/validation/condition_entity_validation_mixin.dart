import 'package:foxy/constant/condition_error_types.dart';
import 'package:foxy/constant/condition_source_type.dart';
import 'package:foxy/constant/condition_type.dart';
import 'package:foxy/constant/condition_value_config.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ConditionValidationMixin on ViewModelValidationMixin {
  void validateConditionFields(ConditionEntity value) {
    final sourceTypeOrReferenceId = value.sourceTypeOrReferenceId;
    final sourceGroup = value.sourceGroup;
    final sourceEntry = value.sourceEntry;
    final sourceId = value.sourceId;
    final elseGroup = value.elseGroup;
    final conditionTypeOrReference = value.conditionTypeOrReference;
    final conditionTarget = value.conditionTarget;
    final conditionValue1 = value.conditionValue1;
    final conditionValue2 = value.conditionValue2;
    final conditionValue3 = value.conditionValue3;
    final negativeCondition = value.negativeCondition;
    final errorType = value.errorType;
    final errorTextId = value.errorTextId;
    final scriptName = value.scriptName;
    final comment = value.comment;

    void validateNormalSource() {
      if (sourceTypeOrReferenceId < 0) return;
      if (!kConditionSourceTypeLabels.containsKey(sourceTypeOrReferenceId)) {
        throw ArgumentError.value(
          sourceTypeOrReferenceId,
          'SourceTypeOrReferenceId',
          '当前 3.3.5a core 不加载该来源类型',
        );
      }
      if (sourceGroup != 0 &&
          !kConditionSourceTypesWithGroup.contains(sourceTypeOrReferenceId)) {
        throw ArgumentError(
          'SourceTypeOrReferenceId $sourceTypeOrReferenceId 不允许 SourceGroup',
        );
      }
      if (sourceId != 0 &&
          !kConditionSourceTypesWithSourceId.contains(
            sourceTypeOrReferenceId,
          )) {
        throw ArgumentError(
          'SourceTypeOrReferenceId $sourceTypeOrReferenceId 不允许 SourceId',
        );
      }
      if (sourceTypeOrReferenceId == 13 &&
          (sourceGroup == 0 || sourceGroup > 0x07)) {
        throw ArgumentError.value(
          sourceGroup,
          'SourceGroup',
          '法术隐式目标效果掩码必须在 1..7',
        );
      }
      if (sourceTypeOrReferenceId == 22 &&
          !const {0, 1, 2, 9}.contains(sourceId)) {
        throw ArgumentError.value(sourceId, 'SourceId', 'SmartAI 来源类型无效');
      }
      if (sourceTypeOrReferenceId == 30 &&
          (sourceGroup > 1 || sourceEntry <= 0)) {
        throw ArgumentError('对象可见性要求 SourceGroup 为 0/1 且 SourceEntry 为正数');
      }
      if (conditionTarget >= conditionTargetCount(sourceTypeOrReferenceId)) {
        throw ArgumentError.value(
          conditionTarget,
          'ConditionTarget',
          '超出当前来源可用目标范围',
        );
      }
      if (errorType != 0 && sourceTypeOrReferenceId != 17) {
        throw ArgumentError('只有法术来源可以设置 ErrorType');
      }
      if (!kConditionErrorTypeOptions.containsKey(errorType)) {
        throw ArgumentError.value(errorType, 'ErrorType', '法术失败类型无效');
      }
      if (errorTextId != 0 && errorType != 172) {
        throw ArgumentError('只有 CUSTOM_ERROR 可以设置 ErrorTextId');
      }
      if (errorType == 172 &&
          !kConditionCustomErrorOptions.containsKey(errorTextId)) {
        throw ArgumentError.value(errorTextId, 'ErrorTextId', '自定义错误文本无效');
      }
    }

    void validateReference() {
      if (conditionTypeOrReference == sourceTypeOrReferenceId) {
        throw ArgumentError('条件引用不能引用自身');
      }
      if (conditionTarget != 0 ||
          conditionValue1 != 0 ||
          conditionValue2 != 0 ||
          conditionValue3 != 0 ||
          negativeCondition != 0) {
        throw ArgumentError('引用条件不能设置目标、参数或否定标记');
      }
      if (sourceTypeOrReferenceId < 0 &&
          (sourceGroup != 0 || sourceEntry != 0)) {
        throw ArgumentError('引用模板不能设置 SourceGroup 或 SourceEntry');
      }
    }

    void validateOtherTarget() {
      if (conditionValue1 >= conditionTargetCount(sourceTypeOrReferenceId) ||
          conditionValue1 == conditionTarget) {
        throw ArgumentError.value(
          conditionValue1,
          'ConditionValue1',
          '必须指向当前来源的另一个有效目标',
        );
      }
    }

    void requireZeroIfUnused(
      int value,
      ConditionValueFieldConfig config,
      String name,
    ) {
      if (!config.editable && value != 0) {
        throw ArgumentError.value(value, name, '当前条件类型不使用该字段');
      }
    }

    void requireRange(int value, int min, int max, String name) {
      if (value < min || value > max) {
        throw RangeError.range(value, min, max, name);
      }
    }

    void requireBoolean(int value, String name) {
      requireRange(value, 0, 1, name);
    }

    void validateParameters() {
      final config = conditionValueConfig(
        conditionTypeOrReference,
        value1: conditionValue1,
      );
      requireZeroIfUnused(conditionValue1, config.value1, 'ConditionValue1');
      requireZeroIfUnused(conditionValue2, config.value2, 'ConditionValue2');
      requireZeroIfUnused(conditionValue3, config.value3, 'ConditionValue3');

      switch (conditionTypeOrReference) {
        case 1:
          requireRange(conditionValue2, 0, 2, 'ConditionValue2');
        case 2:
          if (conditionValue2 == 0) {
            throw ArgumentError.value(
              conditionValue2,
              'ConditionValue2',
              '物品数量不能为 0',
            );
          }
        case 6:
          if (conditionValue1 != 469 && conditionValue1 != 67) {
            throw ArgumentError.value(
              conditionValue1,
              'ConditionValue1',
              '阵营只能为联盟或部落',
            );
          }
        case 7:
          if (conditionValue2 == 0) {
            throw ArgumentError.value(
              conditionValue2,
              'ConditionValue2',
              '技能值不能为 0',
            );
          }
        case 10:
          requireRange(conditionValue1, 0, 3, 'ConditionValue1');
        case 13:
          requireRange(conditionValue3, 0, 3, 'ConditionValue3');
        case 15:
          if ((conditionValue1 & 0x5FF) == 0) {
            throw ArgumentError.value(
              conditionValue1,
              'ConditionValue1',
              '必须包含可玩职业',
            );
          }
        case 16:
          if ((conditionValue1 & 0x6FF) == 0) {
            throw ArgumentError.value(
              conditionValue1,
              'ConditionValue1',
              '必须包含可玩种族',
            );
          }
        case 19:
          requireRange(conditionValue1, 0, 0x0F, 'ConditionValue1');
        case 20:
          requireRange(conditionValue1, 0, 1, 'ConditionValue1');
        case 21:
          if ((conditionValue1 & 0x3FF7FFBF) == 0) {
            throw ArgumentError.value(
              conditionValue1,
              'ConditionValue1',
              '未包含 core 支持的单位状态',
            );
          }
        case 24:
          requireRange(conditionValue1, 1, 13, 'ConditionValue1');
        case 27 || 37:
          requireRange(conditionValue2, 0, 4, 'ConditionValue2');
        case 30:
          requireRange(conditionValue3, 0, 2, 'ConditionValue3');
        case 31:
          if (!const {3, 4, 5, 7}.contains(conditionValue1)) {
            throw ArgumentError.value(
              conditionValue1,
              'ConditionValue1',
              '对象类型无效',
            );
          }
        case 32:
          if (conditionValue1 == 0 ||
              (conditionValue1 & ~(0x08 | 0x10 | 0x20 | 0x80)) != 0) {
            throw ArgumentError.value(
              conditionValue1,
              'ConditionValue1',
              '对象类型掩码无效',
            );
          }
        case 33:
          validateOtherTarget();
          requireRange(conditionValue2, 0, 5, 'ConditionValue2');
        case 34:
          validateOtherTarget();
          if (conditionValue2 == 0) {
            throw ArgumentError.value(
              conditionValue2,
              'ConditionValue2',
              '反应等级掩码不能为 0',
            );
          }
        case 35:
          validateOtherTarget();
          requireRange(conditionValue3, 0, 4, 'ConditionValue3');
        case 38:
          requireRange(conditionValue1, 0, 100, 'ConditionValue1');
          requireRange(conditionValue2, 0, 4, 'ConditionValue2');
        case 42:
          requireRange(conditionValue1, 0, 1, 'ConditionValue1');
          requireRange(
            conditionValue2,
            0,
            conditionValue1 == 0 ? 9 : 1,
            'ConditionValue2',
          );
        case 45:
          requireRange(conditionValue1, 0, 15, 'ConditionValue1');
        case 47:
          if ((conditionValue2 & ~0x6B) != 0 || conditionValue2 >= 128) {
            throw ArgumentError.value(
              conditionValue2,
              'ConditionValue2',
              '任务状态掩码无效',
            );
          }
        case 48:
          requireRange(conditionValue2, 0, 3, 'ConditionValue2');
        case 49:
          requireRange(conditionValue1, 0, 3, 'ConditionValue1');
        case 102:
          if (!kConditionAuraTypeOptions.containsKey(conditionValue1)) {
            throw ArgumentError.value(
              conditionValue1,
              'ConditionValue1',
              '光环类型无效',
            );
          }
        case 105:
          requireBoolean(conditionValue1, 'ConditionValue1');
          requireRange(conditionValue2, 0, 3, 'ConditionValue2');
      }
    }

    void requireInt32(int value, String name) {
      if (value < -0x80000000 || value > 0x7FFFFFFF) {
        throw RangeError.range(value, -0x80000000, 0x7FFFFFFF, name);
      }
    }

    void requireUint32(int value, String name) {
      if (value < 0 || value > 0xFFFFFFFF) {
        throw RangeError.range(value, 0, 0xFFFFFFFF, name);
      }
    }

    requireInt32(sourceTypeOrReferenceId, 'SourceTypeOrReferenceId');
    requireUint32(sourceGroup, 'SourceGroup');
    requireInt32(sourceEntry, 'SourceEntry');
    requireInt32(sourceId, 'SourceId');
    if (sourceId < 0) {
      throw ArgumentError.value(sourceId, 'SourceId', '不能为负数');
    }
    requireUint32(elseGroup, 'ElseGroup');
    requireInt32(conditionTypeOrReference, 'ConditionTypeOrReference');
    requireUint32(conditionValue1, 'ConditionValue1');
    requireUint32(conditionValue2, 'ConditionValue2');
    requireUint32(conditionValue3, 'ConditionValue3');
    requireUint32(errorType, 'ErrorType');
    requireUint32(errorTextId, 'ErrorTextId');
    if (conditionTarget < 0 || conditionTarget > 0xFF) {
      throw ArgumentError.value(
        conditionTarget,
        'ConditionTarget',
        '必须在 uint8 范围内',
      );
    }
    if (negativeCondition != 0 && negativeCondition != 1) {
      throw ArgumentError.value(
        negativeCondition,
        'NegativeCondition',
        '只能为 0 或 1',
      );
    }
    if (scriptName.length > 64) {
      throw ArgumentError.value(scriptName, 'ScriptName', '长度不能超过 64');
    }
    if (comment.length > 255) {
      throw ArgumentError.value(comment, 'Comment', '长度不能超过 255');
    }

    if (conditionTypeOrReference < 0) {
      validateReference();
      validateNormalSource();
      return;
    }
    if (!kConditionTypeLabels.containsKey(conditionTypeOrReference)) {
      throw ArgumentError.value(
        conditionTypeOrReference,
        'ConditionTypeOrReference',
        '当前 3.3.5a core 不加载该条件类型',
      );
    }
    if (sourceTypeOrReferenceId < 0) {
      if (sourceGroup != 0 ||
          sourceEntry != 0 ||
          sourceId != 0 ||
          conditionTarget != 0 ||
          errorType != 0 ||
          errorTextId != 0) {
        throw ArgumentError('引用模板不使用来源字段、条件目标或错误字段');
      }
      validateParameters();
      return;
    }
    validateNormalSource();
    validateParameters();
  }
}
