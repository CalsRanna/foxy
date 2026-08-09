// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_costs_data_entity.dart';

final class BriefSkillCostsDataEntity {
  final int id;

  const BriefSkillCostsDataEntity({this.id = 0});

  factory BriefSkillCostsDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefSkillCostsDataEntity(
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
        other is BriefSkillCostsDataEntity && id == other.id;
  }

  @override
  String toString() {
    return 'BriefSkillCostsDataEntity('
        'id: $id'
        ')';
  }
}

mixin _SkillCostsDataEntityMixin {
  @override
  int get hashCode {
    final self = this as SkillCostsDataEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.skillCostsId,
      self.cost0,
      self.cost1,
      self.cost2,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as SkillCostsDataEntity;
    return identical(self, other) ||
        other is SkillCostsDataEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.skillCostsId == other.skillCostsId &&
            self.cost0 == other.cost0 &&
            self.cost1 == other.cost1 &&
            self.cost2 == other.cost2;
  }

  SkillCostsDataEntity copyWith({
    int? id,
    int? skillCostsId,
    int? cost0,
    int? cost1,
    int? cost2,
  }) {
    final self = this as SkillCostsDataEntity;
    return SkillCostsDataEntity(
      id: id ?? self.id,
      skillCostsId: skillCostsId ?? self.skillCostsId,
      cost0: cost0 ?? self.cost0,
      cost1: cost1 ?? self.cost1,
      cost2: cost2 ?? self.cost2,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as SkillCostsDataEntity;
    return {
      'ID': self.id,
      'SkillCostsID': self.skillCostsId,
      'Cost0': self.cost0,
      'Cost1': self.cost1,
      'Cost2': self.cost2,
    };
  }

  @override
  String toString() {
    final self = this as SkillCostsDataEntity;
    return 'SkillCostsDataEntity('
        'id: ${self.id}, '
        'skillCostsId: ${self.skillCostsId}, '
        'cost0: ${self.cost0}, '
        'cost1: ${self.cost1}, '
        'cost2: ${self.cost2}'
        ')';
  }

  static SkillCostsDataEntity fromJson(Map<String, dynamic> json) {
    return SkillCostsDataEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      skillCostsId: json['SkillCostsID'] == true
          ? 1
          : json['SkillCostsID'] == false
          ? 0
          : (json['SkillCostsID'] as num?)?.toInt() ?? 0,
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
    );
  }
}
