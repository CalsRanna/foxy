class Lock {
  final int id;
  final int type0;
  final int index0;
  final int skill0;

  const Lock({
    this.id = 0,
    this.type0 = 0,
    this.index0 = 0,
    this.skill0 = 0,
  });

  factory Lock.fromJson(Map<String, dynamic> json) {
    return Lock(
      id: json['ID'] ?? 0,
      type0: json['Type0'] ?? 0,
      index0: json['Index0'] ?? 0,
      skill0: json['Skill0'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Type0': type0,
      'Index0': index0,
      'Skill0': skill0,
    };
  }
}
