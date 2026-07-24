// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_entity.dart';

mixin _LockEntityMixin {
  int get id;
  int get type0;
  int get type1;
  int get type2;
  int get type3;
  int get type4;
  int get type5;
  int get type6;
  int get type7;
  int get index0;
  int get index1;
  int get index2;
  int get index3;
  int get index4;
  int get index5;
  int get index6;
  int get index7;
  int get skill0;
  int get skill1;
  int get skill2;
  int get skill3;
  int get skill4;
  int get skill5;
  int get skill6;
  int get skill7;
  int get action0;
  int get action1;
  int get action2;
  int get action3;
  int get action4;
  int get action5;
  int get action6;
  int get action7;

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
    return LockEntity(
      id: id ?? this.id,
      type0: type0 ?? this.type0,
      type1: type1 ?? this.type1,
      type2: type2 ?? this.type2,
      type3: type3 ?? this.type3,
      type4: type4 ?? this.type4,
      type5: type5 ?? this.type5,
      type6: type6 ?? this.type6,
      type7: type7 ?? this.type7,
      index0: index0 ?? this.index0,
      index1: index1 ?? this.index1,
      index2: index2 ?? this.index2,
      index3: index3 ?? this.index3,
      index4: index4 ?? this.index4,
      index5: index5 ?? this.index5,
      index6: index6 ?? this.index6,
      index7: index7 ?? this.index7,
      skill0: skill0 ?? this.skill0,
      skill1: skill1 ?? this.skill1,
      skill2: skill2 ?? this.skill2,
      skill3: skill3 ?? this.skill3,
      skill4: skill4 ?? this.skill4,
      skill5: skill5 ?? this.skill5,
      skill6: skill6 ?? this.skill6,
      skill7: skill7 ?? this.skill7,
      action0: action0 ?? this.action0,
      action1: action1 ?? this.action1,
      action2: action2 ?? this.action2,
      action3: action3 ?? this.action3,
      action4: action4 ?? this.action4,
      action5: action5 ?? this.action5,
      action6: action6 ?? this.action6,
      action7: action7 ?? this.action7,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Type0': type0,
      'Type1': type1,
      'Type2': type2,
      'Type3': type3,
      'Type4': type4,
      'Type5': type5,
      'Type6': type6,
      'Type7': type7,
      'Index0': index0,
      'Index1': index1,
      'Index2': index2,
      'Index3': index3,
      'Index4': index4,
      'Index5': index5,
      'Index6': index6,
      'Index7': index7,
      'Skill0': skill0,
      'Skill1': skill1,
      'Skill2': skill2,
      'Skill3': skill3,
      'Skill4': skill4,
      'Skill5': skill5,
      'Skill6': skill6,
      'Skill7': skill7,
      'Action0': action0,
      'Action1': action1,
      'Action2': action2,
      'Action3': action3,
      'Action4': action4,
      'Action5': action5,
      'Action6': action6,
      'Action7': action7,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LockEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            type0 == other.type0 &&
            type1 == other.type1 &&
            type2 == other.type2 &&
            type3 == other.type3 &&
            type4 == other.type4 &&
            type5 == other.type5 &&
            type6 == other.type6 &&
            type7 == other.type7 &&
            index0 == other.index0 &&
            index1 == other.index1 &&
            index2 == other.index2 &&
            index3 == other.index3 &&
            index4 == other.index4 &&
            index5 == other.index5 &&
            index6 == other.index6 &&
            index7 == other.index7 &&
            skill0 == other.skill0 &&
            skill1 == other.skill1 &&
            skill2 == other.skill2 &&
            skill3 == other.skill3 &&
            skill4 == other.skill4 &&
            skill5 == other.skill5 &&
            skill6 == other.skill6 &&
            skill7 == other.skill7 &&
            action0 == other.action0 &&
            action1 == other.action1 &&
            action2 == other.action2 &&
            action3 == other.action3 &&
            action4 == other.action4 &&
            action5 == other.action5 &&
            action6 == other.action6 &&
            action7 == other.action7;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      type0,
      type1,
      type2,
      type3,
      type4,
      type5,
      type6,
      type7,
      index0,
      index1,
      index2,
      index3,
      index4,
      index5,
      index6,
      index7,
      skill0,
      skill1,
      skill2,
      skill3,
      skill4,
      skill5,
      skill6,
      skill7,
      action0,
      action1,
      action2,
      action3,
      action4,
      action5,
      action6,
      action7,
    ]);
  }

  @override
  String toString() {
    return 'LockEntity('
        'id: $id, '
        'type0: $type0, '
        'type1: $type1, '
        'type2: $type2, '
        'type3: $type3, '
        'type4: $type4, '
        'type5: $type5, '
        'type6: $type6, '
        'type7: $type7, '
        'index0: $index0, '
        'index1: $index1, '
        'index2: $index2, '
        'index3: $index3, '
        'index4: $index4, '
        'index5: $index5, '
        'index6: $index6, '
        'index7: $index7, '
        'skill0: $skill0, '
        'skill1: $skill1, '
        'skill2: $skill2, '
        'skill3: $skill3, '
        'skill4: $skill4, '
        'skill5: $skill5, '
        'skill6: $skill6, '
        'skill7: $skill7, '
        'action0: $action0, '
        'action1: $action1, '
        'action2: $action2, '
        'action3: $action3, '
        'action4: $action4, '
        'action5: $action5, '
        'action6: $action6, '
        'action7: $action7'
        ')';
  }
}
