import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_item_enchantment_condition_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_spell_item_enchantment_condition')
class SpellItemEnchantmentConditionEntity
    with _SpellItemEnchantmentConditionEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Lt_operandType0')
  final int ltOperandType0;

  @FoxyFullField('Lt_operandType1')
  final int ltOperandType1;

  @FoxyFullField('Lt_operandType2')
  final int ltOperandType2;

  @FoxyFullField('Lt_operandType3')
  final int ltOperandType3;

  @FoxyFullField('Lt_operandType4')
  final int ltOperandType4;

  @FoxyFullField('Lt_operand0')
  final int ltOperand0;

  @FoxyFullField('Lt_operand1')
  final int ltOperand1;

  @FoxyFullField('Lt_operand2')
  final int ltOperand2;

  @FoxyFullField('Lt_operand3')
  final int ltOperand3;

  @FoxyFullField('Lt_operand4')
  final int ltOperand4;

  @FoxyFullField('Operator0')
  final int operator0;

  @FoxyFullField('Operator1')
  final int operator1;

  @FoxyFullField('Operator2')
  final int operator2;

  @FoxyFullField('Operator3')
  final int operator3;

  @FoxyFullField('Operator4')
  final int operator4;

  @FoxyFullField('Rt_operandType0')
  final int rtOperandType0;

  @FoxyFullField('Rt_operandType1')
  final int rtOperandType1;

  @FoxyFullField('Rt_operandType2')
  final int rtOperandType2;

  @FoxyFullField('Rt_operandType3')
  final int rtOperandType3;

  @FoxyFullField('Rt_operandType4')
  final int rtOperandType4;

  @FoxyFullField('Rt_operand0')
  final int rtOperand0;

  @FoxyFullField('Rt_operand1')
  final int rtOperand1;

  @FoxyFullField('Rt_operand2')
  final int rtOperand2;

  @FoxyFullField('Rt_operand3')
  final int rtOperand3;

  @FoxyFullField('Rt_operand4')
  final int rtOperand4;

  @FoxyFullField('Logic0')
  final int logic0;

  @FoxyFullField('Logic1')
  final int logic1;

  @FoxyFullField('Logic2')
  final int logic2;

  @FoxyFullField('Logic3')
  final int logic3;

  @FoxyFullField('Logic4')
  final int logic4;

  const SpellItemEnchantmentConditionEntity({
    this.id = 0,
    this.ltOperandType0 = 0,
    this.ltOperandType1 = 0,
    this.ltOperandType2 = 0,
    this.ltOperandType3 = 0,
    this.ltOperandType4 = 0,
    this.ltOperand0 = 0,
    this.ltOperand1 = 0,
    this.ltOperand2 = 0,
    this.ltOperand3 = 0,
    this.ltOperand4 = 0,
    this.operator0 = 0,
    this.operator1 = 0,
    this.operator2 = 0,
    this.operator3 = 0,
    this.operator4 = 0,
    this.rtOperandType0 = 0,
    this.rtOperandType1 = 0,
    this.rtOperandType2 = 0,
    this.rtOperandType3 = 0,
    this.rtOperandType4 = 0,
    this.rtOperand0 = 0,
    this.rtOperand1 = 0,
    this.rtOperand2 = 0,
    this.rtOperand3 = 0,
    this.rtOperand4 = 0,
    this.logic0 = 0,
    this.logic1 = 0,
    this.logic2 = 0,
    this.logic3 = 0,
    this.logic4 = 0,
  });

  factory SpellItemEnchantmentConditionEntity.fromJson(
    Map<String, dynamic> json,
  ) => _SpellItemEnchantmentConditionEntityMixin.fromJson(json);
}
