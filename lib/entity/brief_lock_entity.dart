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

  int get key => id;
}
