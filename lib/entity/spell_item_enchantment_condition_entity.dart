class SpellItemEnchantmentConditionEntity {
  final int id;
  final int ltOperandType0;
  final int ltOperandType1;
  final int ltOperandType2;
  final int ltOperandType3;
  final int ltOperandType4;
  final int ltOperand0;
  final int ltOperand1;
  final int ltOperand2;
  final int ltOperand3;
  final int ltOperand4;
  final int operator0;
  final int operator1;
  final int operator2;
  final int operator3;
  final int operator4;
  final int rtOperandType0;
  final int rtOperandType1;
  final int rtOperandType2;
  final int rtOperandType3;
  final int rtOperandType4;
  final int rtOperand0;
  final int rtOperand1;
  final int rtOperand2;
  final int rtOperand3;
  final int rtOperand4;
  final int logic0;
  final int logic1;
  final int logic2;
  final int logic3;
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
  ) {
    return SpellItemEnchantmentConditionEntity(
      id: json['ID'] ?? 0,
      ltOperandType0: json['Lt_operandType0'] ?? 0,
      ltOperandType1: json['Lt_operandType1'] ?? 0,
      ltOperandType2: json['Lt_operandType2'] ?? 0,
      ltOperandType3: json['Lt_operandType3'] ?? 0,
      ltOperandType4: json['Lt_operandType4'] ?? 0,
      ltOperand0: json['Lt_operand0'] ?? 0,
      ltOperand1: json['Lt_operand1'] ?? 0,
      ltOperand2: json['Lt_operand2'] ?? 0,
      ltOperand3: json['Lt_operand3'] ?? 0,
      ltOperand4: json['Lt_operand4'] ?? 0,
      operator0: json['Operator0'] ?? 0,
      operator1: json['Operator1'] ?? 0,
      operator2: json['Operator2'] ?? 0,
      operator3: json['Operator3'] ?? 0,
      operator4: json['Operator4'] ?? 0,
      rtOperandType0: json['Rt_operandType0'] ?? 0,
      rtOperandType1: json['Rt_operandType1'] ?? 0,
      rtOperandType2: json['Rt_operandType2'] ?? 0,
      rtOperandType3: json['Rt_operandType3'] ?? 0,
      rtOperandType4: json['Rt_operandType4'] ?? 0,
      rtOperand0: json['Rt_operand0'] ?? 0,
      rtOperand1: json['Rt_operand1'] ?? 0,
      rtOperand2: json['Rt_operand2'] ?? 0,
      rtOperand3: json['Rt_operand3'] ?? 0,
      rtOperand4: json['Rt_operand4'] ?? 0,
      logic0: json['Logic0'] ?? 0,
      logic1: json['Logic1'] ?? 0,
      logic2: json['Logic2'] ?? 0,
      logic3: json['Logic3'] ?? 0,
      logic4: json['Logic4'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'Lt_operandType0': ltOperandType0,
    'Lt_operandType1': ltOperandType1,
    'Lt_operandType2': ltOperandType2,
    'Lt_operandType3': ltOperandType3,
    'Lt_operandType4': ltOperandType4,
    'Lt_operand0': ltOperand0,
    'Lt_operand1': ltOperand1,
    'Lt_operand2': ltOperand2,
    'Lt_operand3': ltOperand3,
    'Lt_operand4': ltOperand4,
    'Operator0': operator0,
    'Operator1': operator1,
    'Operator2': operator2,
    'Operator3': operator3,
    'Operator4': operator4,
    'Rt_operandType0': rtOperandType0,
    'Rt_operandType1': rtOperandType1,
    'Rt_operandType2': rtOperandType2,
    'Rt_operandType3': rtOperandType3,
    'Rt_operandType4': rtOperandType4,
    'Rt_operand0': rtOperand0,
    'Rt_operand1': rtOperand1,
    'Rt_operand2': rtOperand2,
    'Rt_operand3': rtOperand3,
    'Rt_operand4': rtOperand4,
    'Logic0': logic0,
    'Logic1': logic1,
    'Logic2': logic2,
    'Logic3': logic3,
    'Logic4': logic4,
  };

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
    return SpellItemEnchantmentConditionEntity(
      id: id ?? this.id,
      ltOperandType0: ltOperandType0 ?? this.ltOperandType0,
      ltOperandType1: ltOperandType1 ?? this.ltOperandType1,
      ltOperandType2: ltOperandType2 ?? this.ltOperandType2,
      ltOperandType3: ltOperandType3 ?? this.ltOperandType3,
      ltOperandType4: ltOperandType4 ?? this.ltOperandType4,
      ltOperand0: ltOperand0 ?? this.ltOperand0,
      ltOperand1: ltOperand1 ?? this.ltOperand1,
      ltOperand2: ltOperand2 ?? this.ltOperand2,
      ltOperand3: ltOperand3 ?? this.ltOperand3,
      ltOperand4: ltOperand4 ?? this.ltOperand4,
      operator0: operator0 ?? this.operator0,
      operator1: operator1 ?? this.operator1,
      operator2: operator2 ?? this.operator2,
      operator3: operator3 ?? this.operator3,
      operator4: operator4 ?? this.operator4,
      rtOperandType0: rtOperandType0 ?? this.rtOperandType0,
      rtOperandType1: rtOperandType1 ?? this.rtOperandType1,
      rtOperandType2: rtOperandType2 ?? this.rtOperandType2,
      rtOperandType3: rtOperandType3 ?? this.rtOperandType3,
      rtOperandType4: rtOperandType4 ?? this.rtOperandType4,
      rtOperand0: rtOperand0 ?? this.rtOperand0,
      rtOperand1: rtOperand1 ?? this.rtOperand1,
      rtOperand2: rtOperand2 ?? this.rtOperand2,
      rtOperand3: rtOperand3 ?? this.rtOperand3,
      rtOperand4: rtOperand4 ?? this.rtOperand4,
      logic0: logic0 ?? this.logic0,
      logic1: logic1 ?? this.logic1,
      logic2: logic2 ?? this.logic2,
      logic3: logic3 ?? this.logic3,
      logic4: logic4 ?? this.logic4,
    );
  }
}

class BriefSpellItemEnchantmentConditionEntity {
  final int id;

  const BriefSpellItemEnchantmentConditionEntity({this.id = 0});

  factory BriefSpellItemEnchantmentConditionEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefSpellItemEnchantmentConditionEntity(id: json['ID'] ?? 0);
  }
}
