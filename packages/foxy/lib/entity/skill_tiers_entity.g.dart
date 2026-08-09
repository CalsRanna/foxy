// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_tiers_entity.dart';

final class BriefSkillTiersEntity {
  final int id;

  const BriefSkillTiersEntity({this.id = 0});

  factory BriefSkillTiersEntity.fromJson(Map<String, dynamic> json) {
    return BriefSkillTiersEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  int get hashCode => Object.hashAll([id]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefSkillTiersEntity && id == other.id;
  }

  @override
  String toString() {
    return 'BriefSkillTiersEntity('
        'id: $id'
        ')';
  }
}

mixin _SkillTiersEntityMixin {
  @override
  int get hashCode {
    final self = this as SkillTiersEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.cost0,
      self.cost1,
      self.cost2,
      self.cost3,
      self.cost4,
      self.cost5,
      self.cost6,
      self.cost7,
      self.cost8,
      self.cost9,
      self.cost10,
      self.cost11,
      self.cost12,
      self.cost13,
      self.cost14,
      self.cost15,
      self.value0,
      self.value1,
      self.value2,
      self.value3,
      self.value4,
      self.value5,
      self.value6,
      self.value7,
      self.value8,
      self.value9,
      self.value10,
      self.value11,
      self.value12,
      self.value13,
      self.value14,
      self.value15,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as SkillTiersEntity;
    return identical(self, other) ||
        other is SkillTiersEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.cost0 == other.cost0 &&
            self.cost1 == other.cost1 &&
            self.cost2 == other.cost2 &&
            self.cost3 == other.cost3 &&
            self.cost4 == other.cost4 &&
            self.cost5 == other.cost5 &&
            self.cost6 == other.cost6 &&
            self.cost7 == other.cost7 &&
            self.cost8 == other.cost8 &&
            self.cost9 == other.cost9 &&
            self.cost10 == other.cost10 &&
            self.cost11 == other.cost11 &&
            self.cost12 == other.cost12 &&
            self.cost13 == other.cost13 &&
            self.cost14 == other.cost14 &&
            self.cost15 == other.cost15 &&
            self.value0 == other.value0 &&
            self.value1 == other.value1 &&
            self.value2 == other.value2 &&
            self.value3 == other.value3 &&
            self.value4 == other.value4 &&
            self.value5 == other.value5 &&
            self.value6 == other.value6 &&
            self.value7 == other.value7 &&
            self.value8 == other.value8 &&
            self.value9 == other.value9 &&
            self.value10 == other.value10 &&
            self.value11 == other.value11 &&
            self.value12 == other.value12 &&
            self.value13 == other.value13 &&
            self.value14 == other.value14 &&
            self.value15 == other.value15;
  }

  SkillTiersEntity copyWith({
    int? id,
    int? cost0,
    int? cost1,
    int? cost2,
    int? cost3,
    int? cost4,
    int? cost5,
    int? cost6,
    int? cost7,
    int? cost8,
    int? cost9,
    int? cost10,
    int? cost11,
    int? cost12,
    int? cost13,
    int? cost14,
    int? cost15,
    int? value0,
    int? value1,
    int? value2,
    int? value3,
    int? value4,
    int? value5,
    int? value6,
    int? value7,
    int? value8,
    int? value9,
    int? value10,
    int? value11,
    int? value12,
    int? value13,
    int? value14,
    int? value15,
  }) {
    final self = this as SkillTiersEntity;
    return SkillTiersEntity(
      id: id ?? self.id,
      cost0: cost0 ?? self.cost0,
      cost1: cost1 ?? self.cost1,
      cost2: cost2 ?? self.cost2,
      cost3: cost3 ?? self.cost3,
      cost4: cost4 ?? self.cost4,
      cost5: cost5 ?? self.cost5,
      cost6: cost6 ?? self.cost6,
      cost7: cost7 ?? self.cost7,
      cost8: cost8 ?? self.cost8,
      cost9: cost9 ?? self.cost9,
      cost10: cost10 ?? self.cost10,
      cost11: cost11 ?? self.cost11,
      cost12: cost12 ?? self.cost12,
      cost13: cost13 ?? self.cost13,
      cost14: cost14 ?? self.cost14,
      cost15: cost15 ?? self.cost15,
      value0: value0 ?? self.value0,
      value1: value1 ?? self.value1,
      value2: value2 ?? self.value2,
      value3: value3 ?? self.value3,
      value4: value4 ?? self.value4,
      value5: value5 ?? self.value5,
      value6: value6 ?? self.value6,
      value7: value7 ?? self.value7,
      value8: value8 ?? self.value8,
      value9: value9 ?? self.value9,
      value10: value10 ?? self.value10,
      value11: value11 ?? self.value11,
      value12: value12 ?? self.value12,
      value13: value13 ?? self.value13,
      value14: value14 ?? self.value14,
      value15: value15 ?? self.value15,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SkillTiersEntity;
    return {
      'ID': self.id,
      'Cost0': self.cost0,
      'Cost1': self.cost1,
      'Cost2': self.cost2,
      'Cost3': self.cost3,
      'Cost4': self.cost4,
      'Cost5': self.cost5,
      'Cost6': self.cost6,
      'Cost7': self.cost7,
      'Cost8': self.cost8,
      'Cost9': self.cost9,
      'Cost10': self.cost10,
      'Cost11': self.cost11,
      'Cost12': self.cost12,
      'Cost13': self.cost13,
      'Cost14': self.cost14,
      'Cost15': self.cost15,
      'Value0': self.value0,
      'Value1': self.value1,
      'Value2': self.value2,
      'Value3': self.value3,
      'Value4': self.value4,
      'Value5': self.value5,
      'Value6': self.value6,
      'Value7': self.value7,
      'Value8': self.value8,
      'Value9': self.value9,
      'Value10': self.value10,
      'Value11': self.value11,
      'Value12': self.value12,
      'Value13': self.value13,
      'Value14': self.value14,
      'Value15': self.value15,
    };
  }

  @override
  String toString() {
    final self = this as SkillTiersEntity;
    return 'SkillTiersEntity('
        'id: ${self.id}, '
        'cost0: ${self.cost0}, '
        'cost1: ${self.cost1}, '
        'cost2: ${self.cost2}, '
        'cost3: ${self.cost3}, '
        'cost4: ${self.cost4}, '
        'cost5: ${self.cost5}, '
        'cost6: ${self.cost6}, '
        'cost7: ${self.cost7}, '
        'cost8: ${self.cost8}, '
        'cost9: ${self.cost9}, '
        'cost10: ${self.cost10}, '
        'cost11: ${self.cost11}, '
        'cost12: ${self.cost12}, '
        'cost13: ${self.cost13}, '
        'cost14: ${self.cost14}, '
        'cost15: ${self.cost15}, '
        'value0: ${self.value0}, '
        'value1: ${self.value1}, '
        'value2: ${self.value2}, '
        'value3: ${self.value3}, '
        'value4: ${self.value4}, '
        'value5: ${self.value5}, '
        'value6: ${self.value6}, '
        'value7: ${self.value7}, '
        'value8: ${self.value8}, '
        'value9: ${self.value9}, '
        'value10: ${self.value10}, '
        'value11: ${self.value11}, '
        'value12: ${self.value12}, '
        'value13: ${self.value13}, '
        'value14: ${self.value14}, '
        'value15: ${self.value15}'
        ')';
  }

  static SkillTiersEntity fromJson(Map<String, dynamic> json) {
    return SkillTiersEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      cost0: json['Cost0'] == true
          ? 1
          : json['Cost0'] == false
          ? 0
          : (json['Cost0'] as num?)?.toInt() ?? 0,
      cost1: json['Cost1'] == true
          ? 1
          : json['Cost1'] == false
          ? 0
          : (json['Cost1'] as num?)?.toInt() ?? 0,
      cost2: json['Cost2'] == true
          ? 1
          : json['Cost2'] == false
          ? 0
          : (json['Cost2'] as num?)?.toInt() ?? 0,
      cost3: json['Cost3'] == true
          ? 1
          : json['Cost3'] == false
          ? 0
          : (json['Cost3'] as num?)?.toInt() ?? 0,
      cost4: json['Cost4'] == true
          ? 1
          : json['Cost4'] == false
          ? 0
          : (json['Cost4'] as num?)?.toInt() ?? 0,
      cost5: json['Cost5'] == true
          ? 1
          : json['Cost5'] == false
          ? 0
          : (json['Cost5'] as num?)?.toInt() ?? 0,
      cost6: json['Cost6'] == true
          ? 1
          : json['Cost6'] == false
          ? 0
          : (json['Cost6'] as num?)?.toInt() ?? 0,
      cost7: json['Cost7'] == true
          ? 1
          : json['Cost7'] == false
          ? 0
          : (json['Cost7'] as num?)?.toInt() ?? 0,
      cost8: json['Cost8'] == true
          ? 1
          : json['Cost8'] == false
          ? 0
          : (json['Cost8'] as num?)?.toInt() ?? 0,
      cost9: json['Cost9'] == true
          ? 1
          : json['Cost9'] == false
          ? 0
          : (json['Cost9'] as num?)?.toInt() ?? 0,
      cost10: json['Cost10'] == true
          ? 1
          : json['Cost10'] == false
          ? 0
          : (json['Cost10'] as num?)?.toInt() ?? 0,
      cost11: json['Cost11'] == true
          ? 1
          : json['Cost11'] == false
          ? 0
          : (json['Cost11'] as num?)?.toInt() ?? 0,
      cost12: json['Cost12'] == true
          ? 1
          : json['Cost12'] == false
          ? 0
          : (json['Cost12'] as num?)?.toInt() ?? 0,
      cost13: json['Cost13'] == true
          ? 1
          : json['Cost13'] == false
          ? 0
          : (json['Cost13'] as num?)?.toInt() ?? 0,
      cost14: json['Cost14'] == true
          ? 1
          : json['Cost14'] == false
          ? 0
          : (json['Cost14'] as num?)?.toInt() ?? 0,
      cost15: json['Cost15'] == true
          ? 1
          : json['Cost15'] == false
          ? 0
          : (json['Cost15'] as num?)?.toInt() ?? 0,
      value0: json['Value0'] == true
          ? 1
          : json['Value0'] == false
          ? 0
          : (json['Value0'] as num?)?.toInt() ?? 0,
      value1: json['Value1'] == true
          ? 1
          : json['Value1'] == false
          ? 0
          : (json['Value1'] as num?)?.toInt() ?? 0,
      value2: json['Value2'] == true
          ? 1
          : json['Value2'] == false
          ? 0
          : (json['Value2'] as num?)?.toInt() ?? 0,
      value3: json['Value3'] == true
          ? 1
          : json['Value3'] == false
          ? 0
          : (json['Value3'] as num?)?.toInt() ?? 0,
      value4: json['Value4'] == true
          ? 1
          : json['Value4'] == false
          ? 0
          : (json['Value4'] as num?)?.toInt() ?? 0,
      value5: json['Value5'] == true
          ? 1
          : json['Value5'] == false
          ? 0
          : (json['Value5'] as num?)?.toInt() ?? 0,
      value6: json['Value6'] == true
          ? 1
          : json['Value6'] == false
          ? 0
          : (json['Value6'] as num?)?.toInt() ?? 0,
      value7: json['Value7'] == true
          ? 1
          : json['Value7'] == false
          ? 0
          : (json['Value7'] as num?)?.toInt() ?? 0,
      value8: json['Value8'] == true
          ? 1
          : json['Value8'] == false
          ? 0
          : (json['Value8'] as num?)?.toInt() ?? 0,
      value9: json['Value9'] == true
          ? 1
          : json['Value9'] == false
          ? 0
          : (json['Value9'] as num?)?.toInt() ?? 0,
      value10: json['Value10'] == true
          ? 1
          : json['Value10'] == false
          ? 0
          : (json['Value10'] as num?)?.toInt() ?? 0,
      value11: json['Value11'] == true
          ? 1
          : json['Value11'] == false
          ? 0
          : (json['Value11'] as num?)?.toInt() ?? 0,
      value12: json['Value12'] == true
          ? 1
          : json['Value12'] == false
          ? 0
          : (json['Value12'] as num?)?.toInt() ?? 0,
      value13: json['Value13'] == true
          ? 1
          : json['Value13'] == false
          ? 0
          : (json['Value13'] as num?)?.toInt() ?? 0,
      value14: json['Value14'] == true
          ? 1
          : json['Value14'] == false
          ? 0
          : (json['Value14'] as num?)?.toInt() ?? 0,
      value15: json['Value15'] == true
          ? 1
          : json['Value15'] == false
          ? 0
          : (json['Value15'] as num?)?.toInt() ?? 0,
    );
  }
}
