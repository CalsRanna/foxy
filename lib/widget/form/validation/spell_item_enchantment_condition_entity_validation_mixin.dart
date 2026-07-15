import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellItemEnchantmentConditionValidationMixin on ViewModelValidationMixin {
  void validateSpellItemEnchantmentConditionFields(
    SpellItemEnchantmentConditionEntity value,
  ) => value._validateFields();
}

extension on SpellItemEnchantmentConditionEntity {
  void _validateFields() {
    if (id <= 0 || id > 0x7fffffff) {
      throw ArgumentError('SpellItemEnchantmentCondition ID 必须大于 0');
    }
    _validateByte(ltOperandType0, 'Lt_operandType0');
    _validateByte(ltOperandType1, 'Lt_operandType1');
    _validateByte(ltOperandType2, 'Lt_operandType2');
    _validateByte(ltOperandType3, 'Lt_operandType3');
    _validateByte(ltOperandType4, 'Lt_operandType4');
    _validateByte(operator0, 'Operator0');
    _validateByte(operator1, 'Operator1');
    _validateByte(operator2, 'Operator2');
    _validateByte(operator3, 'Operator3');
    _validateByte(operator4, 'Operator4');
    _validateByte(rtOperandType0, 'Rt_operandType0');
    _validateByte(rtOperandType1, 'Rt_operandType1');
    _validateByte(rtOperandType2, 'Rt_operandType2');
    _validateByte(rtOperandType3, 'Rt_operandType3');
    _validateByte(rtOperandType4, 'Rt_operandType4');
    _validateByte(logic0, 'Logic0');
    _validateByte(logic1, 'Logic1');
    _validateByte(logic2, 'Logic2');
    _validateByte(logic3, 'Logic3');
    _validateByte(logic4, 'Logic4');
    _validateInt32(ltOperand0, 'Lt_operand0');
    _validateInt32(ltOperand1, 'Lt_operand1');
    _validateInt32(ltOperand2, 'Lt_operand2');
    _validateInt32(ltOperand3, 'Lt_operand3');
    _validateInt32(ltOperand4, 'Lt_operand4');
    _validateInt32(rtOperand0, 'Rt_operand0');
    _validateInt32(rtOperand1, 'Rt_operand1');
    _validateInt32(rtOperand2, 'Rt_operand2');
    _validateInt32(rtOperand3, 'Rt_operand3');
    _validateInt32(rtOperand4, 'Rt_operand4');
  }

  void _validateByte(int value, String name) {
    if (value < 0 || value > 0xff) {
      throw ArgumentError('$name 必须在 0..255 范围内');
    }
  }

  void _validateInt32(int value, String name) {
    if (value < -0x80000000 || value > 0x7fffffff) {
      throw ArgumentError('$name 必须是 32 位有符号整数');
    }
  }
}
