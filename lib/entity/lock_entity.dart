class LockEntity {
  final int id;
  final int type0;
  final int type1;
  final int type2;
  final int type3;
  final int type4;
  final int type5;
  final int type6;
  final int type7;
  final int index0;
  final int index1;
  final int index2;
  final int index3;
  final int index4;
  final int index5;
  final int index6;
  final int index7;
  final int skill0;
  final int skill1;
  final int skill2;
  final int skill3;
  final int skill4;
  final int skill5;
  final int skill6;
  final int skill7;
  final int action0;
  final int action1;
  final int action2;
  final int action3;
  final int action4;
  final int action5;
  final int action6;
  final int action7;

  const LockEntity({
    this.id = 0,
    this.type0 = 0,
    this.type1 = 0,
    this.type2 = 0,
    this.type3 = 0,
    this.type4 = 0,
    this.type5 = 0,
    this.type6 = 0,
    this.type7 = 0,
    this.index0 = 0,
    this.index1 = 0,
    this.index2 = 0,
    this.index3 = 0,
    this.index4 = 0,
    this.index5 = 0,
    this.index6 = 0,
    this.index7 = 0,
    this.skill0 = 0,
    this.skill1 = 0,
    this.skill2 = 0,
    this.skill3 = 0,
    this.skill4 = 0,
    this.skill5 = 0,
    this.skill6 = 0,
    this.skill7 = 0,
    this.action0 = 0,
    this.action1 = 0,
    this.action2 = 0,
    this.action3 = 0,
    this.action4 = 0,
    this.action5 = 0,
    this.action6 = 0,
    this.action7 = 0,
  });

  factory LockEntity.fromJson(Map<String, dynamic> json) {
    return LockEntity(
      id: json['ID'] ?? 0,
      type0: json['Type0'] ?? 0,
      type1: json['Type1'] ?? 0,
      type2: json['Type2'] ?? 0,
      type3: json['Type3'] ?? 0,
      type4: json['Type4'] ?? 0,
      type5: json['Type5'] ?? 0,
      type6: json['Type6'] ?? 0,
      type7: json['Type7'] ?? 0,
      index0: json['Index0'] ?? 0,
      index1: json['Index1'] ?? 0,
      index2: json['Index2'] ?? 0,
      index3: json['Index3'] ?? 0,
      index4: json['Index4'] ?? 0,
      index5: json['Index5'] ?? 0,
      index6: json['Index6'] ?? 0,
      index7: json['Index7'] ?? 0,
      skill0: json['Skill0'] ?? 0,
      skill1: json['Skill1'] ?? 0,
      skill2: json['Skill2'] ?? 0,
      skill3: json['Skill3'] ?? 0,
      skill4: json['Skill4'] ?? 0,
      skill5: json['Skill5'] ?? 0,
      skill6: json['Skill6'] ?? 0,
      skill7: json['Skill7'] ?? 0,
      action0: json['Action0'] ?? 0,
      action1: json['Action1'] ?? 0,
      action2: json['Action2'] ?? 0,
      action3: json['Action3'] ?? 0,
      action4: json['Action4'] ?? 0,
      action5: json['Action5'] ?? 0,
      action6: json['Action6'] ?? 0,
      action7: json['Action7'] ?? 0,
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
}


/// 锁列表/Picker 展示模型
class BriefLockEntity {
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
      id: json['ID'] ?? 0,
      type0: json['Type0'] ?? 0,
      index0: json['Index0'] ?? 0,
      skill0: json['Skill0'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Type0': type0, 'Index0': index0, 'Skill0': skill0};
  }

  BriefLockEntity copyWith({int? id, int? type0, int? index0, int? skill0}) {
    return BriefLockEntity(
      id: id ?? this.id,
      type0: type0 ?? this.type0,
      index0: index0 ?? this.index0,
      skill0: skill0 ?? this.skill0,
    );
  }
}
