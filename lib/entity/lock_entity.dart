class LockEntity {
  final int id;
  final int type0;
  final int index0;
  final int skill0;

  const LockEntity({
    this.id = 0,
    this.type0 = 0,
    this.index0 = 0,
    this.skill0 = 0,
  });

  factory LockEntity.fromJson(Map<String, dynamic> json) {
    return LockEntity(
      id: json['ID'] ?? 0,
      type0: json['Type0'] ?? 0,
      index0: json['Index0'] ?? 0,
      skill0: json['Skill0'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ID': id, 'Type0': type0, 'Index0': index0, 'Skill0': skill0};
  }

  LockEntity copyWith({int? id, int? type0, int? index0, int? skill0}) {
    return LockEntity(
      id: id ?? this.id,
      type0: type0 ?? this.type0,
      index0: index0 ?? this.index0,
      skill0: skill0 ?? this.skill0,
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
