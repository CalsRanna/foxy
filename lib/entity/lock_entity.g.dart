// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_entity.dart';

mixin _LockEntityMixin {
  static LockEntity fromJson(Map<String, dynamic> json) {
    return LockEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      type0: (json['Type0'] as num?)?.toInt() ?? 0,
      type1: (json['Type1'] as num?)?.toInt() ?? 0,
      type2: (json['Type2'] as num?)?.toInt() ?? 0,
      type3: (json['Type3'] as num?)?.toInt() ?? 0,
      type4: (json['Type4'] as num?)?.toInt() ?? 0,
      type5: (json['Type5'] as num?)?.toInt() ?? 0,
      type6: (json['Type6'] as num?)?.toInt() ?? 0,
      type7: (json['Type7'] as num?)?.toInt() ?? 0,
      index0: (json['Index0'] as num?)?.toInt() ?? 0,
      index1: (json['Index1'] as num?)?.toInt() ?? 0,
      index2: (json['Index2'] as num?)?.toInt() ?? 0,
      index3: (json['Index3'] as num?)?.toInt() ?? 0,
      index4: (json['Index4'] as num?)?.toInt() ?? 0,
      index5: (json['Index5'] as num?)?.toInt() ?? 0,
      index6: (json['Index6'] as num?)?.toInt() ?? 0,
      index7: (json['Index7'] as num?)?.toInt() ?? 0,
      skill0: (json['Skill0'] as num?)?.toInt() ?? 0,
      skill1: (json['Skill1'] as num?)?.toInt() ?? 0,
      skill2: (json['Skill2'] as num?)?.toInt() ?? 0,
      skill3: (json['Skill3'] as num?)?.toInt() ?? 0,
      skill4: (json['Skill4'] as num?)?.toInt() ?? 0,
      skill5: (json['Skill5'] as num?)?.toInt() ?? 0,
      skill6: (json['Skill6'] as num?)?.toInt() ?? 0,
      skill7: (json['Skill7'] as num?)?.toInt() ?? 0,
      action0: (json['Action0'] as num?)?.toInt() ?? 0,
      action1: (json['Action1'] as num?)?.toInt() ?? 0,
      action2: (json['Action2'] as num?)?.toInt() ?? 0,
      action3: (json['Action3'] as num?)?.toInt() ?? 0,
      action4: (json['Action4'] as num?)?.toInt() ?? 0,
      action5: (json['Action5'] as num?)?.toInt() ?? 0,
      action6: (json['Action6'] as num?)?.toInt() ?? 0,
      action7: (json['Action7'] as num?)?.toInt() ?? 0,
    );
  }

  LockEntity copyWith({
    int? id,
    int? type0,
    int? type1,
    int? type2,
    int? type3,
    int? type4,
    int? type5,
    int? type6,
    int? type7,
    int? index0,
    int? index1,
    int? index2,
    int? index3,
    int? index4,
    int? index5,
    int? index6,
    int? index7,
    int? skill0,
    int? skill1,
    int? skill2,
    int? skill3,
    int? skill4,
    int? skill5,
    int? skill6,
    int? skill7,
    int? action0,
    int? action1,
    int? action2,
    int? action3,
    int? action4,
    int? action5,
    int? action6,
    int? action7,
  }) {
    final self = this as LockEntity;
    return LockEntity(
      id: id ?? self.id,
      type0: type0 ?? self.type0,
      type1: type1 ?? self.type1,
      type2: type2 ?? self.type2,
      type3: type3 ?? self.type3,
      type4: type4 ?? self.type4,
      type5: type5 ?? self.type5,
      type6: type6 ?? self.type6,
      type7: type7 ?? self.type7,
      index0: index0 ?? self.index0,
      index1: index1 ?? self.index1,
      index2: index2 ?? self.index2,
      index3: index3 ?? self.index3,
      index4: index4 ?? self.index4,
      index5: index5 ?? self.index5,
      index6: index6 ?? self.index6,
      index7: index7 ?? self.index7,
      skill0: skill0 ?? self.skill0,
      skill1: skill1 ?? self.skill1,
      skill2: skill2 ?? self.skill2,
      skill3: skill3 ?? self.skill3,
      skill4: skill4 ?? self.skill4,
      skill5: skill5 ?? self.skill5,
      skill6: skill6 ?? self.skill6,
      skill7: skill7 ?? self.skill7,
      action0: action0 ?? self.action0,
      action1: action1 ?? self.action1,
      action2: action2 ?? self.action2,
      action3: action3 ?? self.action3,
      action4: action4 ?? self.action4,
      action5: action5 ?? self.action5,
      action6: action6 ?? self.action6,
      action7: action7 ?? self.action7,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as LockEntity;
    return {
      'ID': self.id,
      'Type0': self.type0,
      'Type1': self.type1,
      'Type2': self.type2,
      'Type3': self.type3,
      'Type4': self.type4,
      'Type5': self.type5,
      'Type6': self.type6,
      'Type7': self.type7,
      'Index0': self.index0,
      'Index1': self.index1,
      'Index2': self.index2,
      'Index3': self.index3,
      'Index4': self.index4,
      'Index5': self.index5,
      'Index6': self.index6,
      'Index7': self.index7,
      'Skill0': self.skill0,
      'Skill1': self.skill1,
      'Skill2': self.skill2,
      'Skill3': self.skill3,
      'Skill4': self.skill4,
      'Skill5': self.skill5,
      'Skill6': self.skill6,
      'Skill7': self.skill7,
      'Action0': self.action0,
      'Action1': self.action1,
      'Action2': self.action2,
      'Action3': self.action3,
      'Action4': self.action4,
      'Action5': self.action5,
      'Action6': self.action6,
      'Action7': self.action7,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as LockEntity;
    return identical(self, other) ||
        other is LockEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.type0 == other.type0 &&
            self.type1 == other.type1 &&
            self.type2 == other.type2 &&
            self.type3 == other.type3 &&
            self.type4 == other.type4 &&
            self.type5 == other.type5 &&
            self.type6 == other.type6 &&
            self.type7 == other.type7 &&
            self.index0 == other.index0 &&
            self.index1 == other.index1 &&
            self.index2 == other.index2 &&
            self.index3 == other.index3 &&
            self.index4 == other.index4 &&
            self.index5 == other.index5 &&
            self.index6 == other.index6 &&
            self.index7 == other.index7 &&
            self.skill0 == other.skill0 &&
            self.skill1 == other.skill1 &&
            self.skill2 == other.skill2 &&
            self.skill3 == other.skill3 &&
            self.skill4 == other.skill4 &&
            self.skill5 == other.skill5 &&
            self.skill6 == other.skill6 &&
            self.skill7 == other.skill7 &&
            self.action0 == other.action0 &&
            self.action1 == other.action1 &&
            self.action2 == other.action2 &&
            self.action3 == other.action3 &&
            self.action4 == other.action4 &&
            self.action5 == other.action5 &&
            self.action6 == other.action6 &&
            self.action7 == other.action7;
  }

  @override
  int get hashCode {
    final self = this as LockEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.type0,
      self.type1,
      self.type2,
      self.type3,
      self.type4,
      self.type5,
      self.type6,
      self.type7,
      self.index0,
      self.index1,
      self.index2,
      self.index3,
      self.index4,
      self.index5,
      self.index6,
      self.index7,
      self.skill0,
      self.skill1,
      self.skill2,
      self.skill3,
      self.skill4,
      self.skill5,
      self.skill6,
      self.skill7,
      self.action0,
      self.action1,
      self.action2,
      self.action3,
      self.action4,
      self.action5,
      self.action6,
      self.action7,
    ]);
  }

  @override
  String toString() {
    final self = this as LockEntity;
    return 'LockEntity('
        'id: ${self.id}, '
        'type0: ${self.type0}, '
        'type1: ${self.type1}, '
        'type2: ${self.type2}, '
        'type3: ${self.type3}, '
        'type4: ${self.type4}, '
        'type5: ${self.type5}, '
        'type6: ${self.type6}, '
        'type7: ${self.type7}, '
        'index0: ${self.index0}, '
        'index1: ${self.index1}, '
        'index2: ${self.index2}, '
        'index3: ${self.index3}, '
        'index4: ${self.index4}, '
        'index5: ${self.index5}, '
        'index6: ${self.index6}, '
        'index7: ${self.index7}, '
        'skill0: ${self.skill0}, '
        'skill1: ${self.skill1}, '
        'skill2: ${self.skill2}, '
        'skill3: ${self.skill3}, '
        'skill4: ${self.skill4}, '
        'skill5: ${self.skill5}, '
        'skill6: ${self.skill6}, '
        'skill7: ${self.skill7}, '
        'action0: ${self.action0}, '
        'action1: ${self.action1}, '
        'action2: ${self.action2}, '
        'action3: ${self.action3}, '
        'action4: ${self.action4}, '
        'action5: ${self.action5}, '
        'action6: ${self.action6}, '
        'action7: ${self.action7}'
        ')';
  }
}

final class BriefLockEntity {
  final int id;
  final int type0;
  final int index0;
  final int skill0;

  const BriefLockEntity({
    this.id = 0,
    this.type0 = 0,
    this.index0 = 0,
    this.skill0 = 0,
  });

  factory BriefLockEntity.fromJson(Map<String, dynamic> json) {
    return BriefLockEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      type0: (json['Type0'] as num?)?.toInt() ?? 0,
      index0: (json['Index0'] as num?)?.toInt() ?? 0,
      skill0: (json['Skill0'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
