import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellItemEnchantmentConditionValidationMixin on ViewModelValidationMixin {
  void validateSpellItemEnchantmentConditionFields(
    SpellItemEnchantmentConditionEntity value,
  ) {
    final id = value.id;
    final ltOperandType0 = value.ltOperandType0;
    final ltOperandType1 = value.ltOperandType1;
    final ltOperandType2 = value.ltOperandType2;
    final ltOperandType3 = value.ltOperandType3;
    final ltOperandType4 = value.ltOperandType4;
    final ltOperand0 = value.ltOperand0;
    final ltOperand1 = value.ltOperand1;
    final ltOperand2 = value.ltOperand2;
    final ltOperand3 = value.ltOperand3;
    final ltOperand4 = value.ltOperand4;
    final operator0 = value.operator0;
    final operator1 = value.operator1;
    final operator2 = value.operator2;
    final operator3 = value.operator3;
    final operator4 = value.operator4;
    final rtOperandType0 = value.rtOperandType0;
    final rtOperandType1 = value.rtOperandType1;
    final rtOperandType2 = value.rtOperandType2;
    final rtOperandType3 = value.rtOperandType3;
    final rtOperandType4 = value.rtOperandType4;
    final rtOperand0 = value.rtOperand0;
    final rtOperand1 = value.rtOperand1;
    final rtOperand2 = value.rtOperand2;
    final rtOperand3 = value.rtOperand3;
    final rtOperand4 = value.rtOperand4;
    final logic0 = value.logic0;
    final logic1 = value.logic1;
    final logic2 = value.logic2;
    final logic3 = value.logic3;
    final logic4 = value.logic4;

    void validateByte(int value, String name) {
      if (value < 0 || value > 0xff) {
        throw ArgumentError('$name 必须在 0..255 范围内');
      }
    }

    void validateInt32(int value, String name) {
      if (value < -0x80000000 || value > 0x7fffffff) {
        throw ArgumentError('$name 必须是 32 位有符号整数');
      }
    }

    if (id <= 0 || id > 0x7fffffff) {
      throw ArgumentError('SpellItemEnchantmentCondition ID 必须大于 0');
    }
    validateByte(ltOperandType0, 'Lt_operandType0');
    validateByte(ltOperandType1, 'Lt_operandType1');
    validateByte(ltOperandType2, 'Lt_operandType2');
    validateByte(ltOperandType3, 'Lt_operandType3');
    validateByte(ltOperandType4, 'Lt_operandType4');
    validateByte(operator0, 'Operator0');
    validateByte(operator1, 'Operator1');
    validateByte(operator2, 'Operator2');
    validateByte(operator3, 'Operator3');
    validateByte(operator4, 'Operator4');
    validateByte(rtOperandType0, 'Rt_operandType0');
    validateByte(rtOperandType1, 'Rt_operandType1');
    validateByte(rtOperandType2, 'Rt_operandType2');
    validateByte(rtOperandType3, 'Rt_operandType3');
    validateByte(rtOperandType4, 'Rt_operandType4');
    validateByte(logic0, 'Logic0');
    validateByte(logic1, 'Logic1');
    validateByte(logic2, 'Logic2');
    validateByte(logic3, 'Logic3');
    validateByte(logic4, 'Logic4');
    validateInt32(ltOperand0, 'Lt_operand0');
    validateInt32(ltOperand1, 'Lt_operand1');
    validateInt32(ltOperand2, 'Lt_operand2');
    validateInt32(ltOperand3, 'Lt_operand3');
    validateInt32(ltOperand4, 'Lt_operand4');
    validateInt32(rtOperand0, 'Rt_operand0');
    validateInt32(rtOperand1, 'Rt_operand1');
    validateInt32(rtOperand2, 'Rt_operand2');
    validateInt32(rtOperand3, 'Rt_operand3');
    validateInt32(rtOperand4, 'Rt_operand4');
  }
}
