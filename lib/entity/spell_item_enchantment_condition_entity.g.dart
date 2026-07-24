// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_condition_entity.dart';

mixin _SpellItemEnchantmentConditionEntityMixin {
  static SpellItemEnchantmentConditionEntity fromJson(
    Map<String, dynamic> json,
  ) {
    return SpellItemEnchantmentConditionEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      ltOperandType0: (json['Lt_operandType0'] as num?)?.toInt() ?? 0,
      ltOperandType1: (json['Lt_operandType1'] as num?)?.toInt() ?? 0,
      ltOperandType2: (json['Lt_operandType2'] as num?)?.toInt() ?? 0,
      ltOperandType3: (json['Lt_operandType3'] as num?)?.toInt() ?? 0,
      ltOperandType4: (json['Lt_operandType4'] as num?)?.toInt() ?? 0,
      ltOperand0: (json['Lt_operand0'] as num?)?.toInt() ?? 0,
      ltOperand1: (json['Lt_operand1'] as num?)?.toInt() ?? 0,
      ltOperand2: (json['Lt_operand2'] as num?)?.toInt() ?? 0,
      ltOperand3: (json['Lt_operand3'] as num?)?.toInt() ?? 0,
      ltOperand4: (json['Lt_operand4'] as num?)?.toInt() ?? 0,
      operator0: (json['Operator0'] as num?)?.toInt() ?? 0,
      operator1: (json['Operator1'] as num?)?.toInt() ?? 0,
      operator2: (json['Operator2'] as num?)?.toInt() ?? 0,
      operator3: (json['Operator3'] as num?)?.toInt() ?? 0,
      operator4: (json['Operator4'] as num?)?.toInt() ?? 0,
      rtOperandType0: (json['Rt_operandType0'] as num?)?.toInt() ?? 0,
      rtOperandType1: (json['Rt_operandType1'] as num?)?.toInt() ?? 0,
      rtOperandType2: (json['Rt_operandType2'] as num?)?.toInt() ?? 0,
      rtOperandType3: (json['Rt_operandType3'] as num?)?.toInt() ?? 0,
      rtOperandType4: (json['Rt_operandType4'] as num?)?.toInt() ?? 0,
      rtOperand0: (json['Rt_operand0'] as num?)?.toInt() ?? 0,
      rtOperand1: (json['Rt_operand1'] as num?)?.toInt() ?? 0,
      rtOperand2: (json['Rt_operand2'] as num?)?.toInt() ?? 0,
      rtOperand3: (json['Rt_operand3'] as num?)?.toInt() ?? 0,
      rtOperand4: (json['Rt_operand4'] as num?)?.toInt() ?? 0,
      logic0: (json['Logic0'] as num?)?.toInt() ?? 0,
      logic1: (json['Logic1'] as num?)?.toInt() ?? 0,
      logic2: (json['Logic2'] as num?)?.toInt() ?? 0,
      logic3: (json['Logic3'] as num?)?.toInt() ?? 0,
      logic4: (json['Logic4'] as num?)?.toInt() ?? 0,
    );
  }

  SpellItemEnchantmentConditionEntity copyWith({
    int? id,
    int? ltOperandType0,
    int? ltOperandType1,
    int? ltOperandType2,
    int? ltOperandType3,
    int? ltOperandType4,
    int? ltOperand0,
    int? ltOperand1,
    int? ltOperand2,
    int? ltOperand3,
    int? ltOperand4,
    int? operator0,
    int? operator1,
    int? operator2,
    int? operator3,
    int? operator4,
    int? rtOperandType0,
    int? rtOperandType1,
    int? rtOperandType2,
    int? rtOperandType3,
    int? rtOperandType4,
    int? rtOperand0,
    int? rtOperand1,
    int? rtOperand2,
    int? rtOperand3,
    int? rtOperand4,
    int? logic0,
    int? logic1,
    int? logic2,
    int? logic3,
    int? logic4,
  }) {
    final self = this as SpellItemEnchantmentConditionEntity;
    return SpellItemEnchantmentConditionEntity(
      id: id ?? self.id,
      ltOperandType0: ltOperandType0 ?? self.ltOperandType0,
      ltOperandType1: ltOperandType1 ?? self.ltOperandType1,
      ltOperandType2: ltOperandType2 ?? self.ltOperandType2,
      ltOperandType3: ltOperandType3 ?? self.ltOperandType3,
      ltOperandType4: ltOperandType4 ?? self.ltOperandType4,
      ltOperand0: ltOperand0 ?? self.ltOperand0,
      ltOperand1: ltOperand1 ?? self.ltOperand1,
      ltOperand2: ltOperand2 ?? self.ltOperand2,
      ltOperand3: ltOperand3 ?? self.ltOperand3,
      ltOperand4: ltOperand4 ?? self.ltOperand4,
      operator0: operator0 ?? self.operator0,
      operator1: operator1 ?? self.operator1,
      operator2: operator2 ?? self.operator2,
      operator3: operator3 ?? self.operator3,
      operator4: operator4 ?? self.operator4,
      rtOperandType0: rtOperandType0 ?? self.rtOperandType0,
      rtOperandType1: rtOperandType1 ?? self.rtOperandType1,
      rtOperandType2: rtOperandType2 ?? self.rtOperandType2,
      rtOperandType3: rtOperandType3 ?? self.rtOperandType3,
      rtOperandType4: rtOperandType4 ?? self.rtOperandType4,
      rtOperand0: rtOperand0 ?? self.rtOperand0,
      rtOperand1: rtOperand1 ?? self.rtOperand1,
      rtOperand2: rtOperand2 ?? self.rtOperand2,
      rtOperand3: rtOperand3 ?? self.rtOperand3,
      rtOperand4: rtOperand4 ?? self.rtOperand4,
      logic0: logic0 ?? self.logic0,
      logic1: logic1 ?? self.logic1,
      logic2: logic2 ?? self.logic2,
      logic3: logic3 ?? self.logic3,
      logic4: logic4 ?? self.logic4,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SpellItemEnchantmentConditionEntity;
    return {
      'ID': self.id,
      'Lt_operandType0': self.ltOperandType0,
      'Lt_operandType1': self.ltOperandType1,
      'Lt_operandType2': self.ltOperandType2,
      'Lt_operandType3': self.ltOperandType3,
      'Lt_operandType4': self.ltOperandType4,
      'Lt_operand0': self.ltOperand0,
      'Lt_operand1': self.ltOperand1,
      'Lt_operand2': self.ltOperand2,
      'Lt_operand3': self.ltOperand3,
      'Lt_operand4': self.ltOperand4,
      'Operator0': self.operator0,
      'Operator1': self.operator1,
      'Operator2': self.operator2,
      'Operator3': self.operator3,
      'Operator4': self.operator4,
      'Rt_operandType0': self.rtOperandType0,
      'Rt_operandType1': self.rtOperandType1,
      'Rt_operandType2': self.rtOperandType2,
      'Rt_operandType3': self.rtOperandType3,
      'Rt_operandType4': self.rtOperandType4,
      'Rt_operand0': self.rtOperand0,
      'Rt_operand1': self.rtOperand1,
      'Rt_operand2': self.rtOperand2,
      'Rt_operand3': self.rtOperand3,
      'Rt_operand4': self.rtOperand4,
      'Logic0': self.logic0,
      'Logic1': self.logic1,
      'Logic2': self.logic2,
      'Logic3': self.logic3,
      'Logic4': self.logic4,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as SpellItemEnchantmentConditionEntity;
    return identical(self, other) ||
        other is SpellItemEnchantmentConditionEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.ltOperandType0 == other.ltOperandType0 &&
            self.ltOperandType1 == other.ltOperandType1 &&
            self.ltOperandType2 == other.ltOperandType2 &&
            self.ltOperandType3 == other.ltOperandType3 &&
            self.ltOperandType4 == other.ltOperandType4 &&
            self.ltOperand0 == other.ltOperand0 &&
            self.ltOperand1 == other.ltOperand1 &&
            self.ltOperand2 == other.ltOperand2 &&
            self.ltOperand3 == other.ltOperand3 &&
            self.ltOperand4 == other.ltOperand4 &&
            self.operator0 == other.operator0 &&
            self.operator1 == other.operator1 &&
            self.operator2 == other.operator2 &&
            self.operator3 == other.operator3 &&
            self.operator4 == other.operator4 &&
            self.rtOperandType0 == other.rtOperandType0 &&
            self.rtOperandType1 == other.rtOperandType1 &&
            self.rtOperandType2 == other.rtOperandType2 &&
            self.rtOperandType3 == other.rtOperandType3 &&
            self.rtOperandType4 == other.rtOperandType4 &&
            self.rtOperand0 == other.rtOperand0 &&
            self.rtOperand1 == other.rtOperand1 &&
            self.rtOperand2 == other.rtOperand2 &&
            self.rtOperand3 == other.rtOperand3 &&
            self.rtOperand4 == other.rtOperand4 &&
            self.logic0 == other.logic0 &&
            self.logic1 == other.logic1 &&
            self.logic2 == other.logic2 &&
            self.logic3 == other.logic3 &&
            self.logic4 == other.logic4;
  }

  @override
  int get hashCode {
    final self = this as SpellItemEnchantmentConditionEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.ltOperandType0,
      self.ltOperandType1,
      self.ltOperandType2,
      self.ltOperandType3,
      self.ltOperandType4,
      self.ltOperand0,
      self.ltOperand1,
      self.ltOperand2,
      self.ltOperand3,
      self.ltOperand4,
      self.operator0,
      self.operator1,
      self.operator2,
      self.operator3,
      self.operator4,
      self.rtOperandType0,
      self.rtOperandType1,
      self.rtOperandType2,
      self.rtOperandType3,
      self.rtOperandType4,
      self.rtOperand0,
      self.rtOperand1,
      self.rtOperand2,
      self.rtOperand3,
      self.rtOperand4,
      self.logic0,
      self.logic1,
      self.logic2,
      self.logic3,
      self.logic4,
    ]);
  }

  @override
  String toString() {
    final self = this as SpellItemEnchantmentConditionEntity;
    return 'SpellItemEnchantmentConditionEntity('
        'id: ${self.id}, '
        'ltOperandType0: ${self.ltOperandType0}, '
        'ltOperandType1: ${self.ltOperandType1}, '
        'ltOperandType2: ${self.ltOperandType2}, '
        'ltOperandType3: ${self.ltOperandType3}, '
        'ltOperandType4: ${self.ltOperandType4}, '
        'ltOperand0: ${self.ltOperand0}, '
        'ltOperand1: ${self.ltOperand1}, '
        'ltOperand2: ${self.ltOperand2}, '
        'ltOperand3: ${self.ltOperand3}, '
        'ltOperand4: ${self.ltOperand4}, '
        'operator0: ${self.operator0}, '
        'operator1: ${self.operator1}, '
        'operator2: ${self.operator2}, '
        'operator3: ${self.operator3}, '
        'operator4: ${self.operator4}, '
        'rtOperandType0: ${self.rtOperandType0}, '
        'rtOperandType1: ${self.rtOperandType1}, '
        'rtOperandType2: ${self.rtOperandType2}, '
        'rtOperandType3: ${self.rtOperandType3}, '
        'rtOperandType4: ${self.rtOperandType4}, '
        'rtOperand0: ${self.rtOperand0}, '
        'rtOperand1: ${self.rtOperand1}, '
        'rtOperand2: ${self.rtOperand2}, '
        'rtOperand3: ${self.rtOperand3}, '
        'rtOperand4: ${self.rtOperand4}, '
        'logic0: ${self.logic0}, '
        'logic1: ${self.logic1}, '
        'logic2: ${self.logic2}, '
        'logic3: ${self.logic3}, '
        'logic4: ${self.logic4}'
        ')';
  }
}
