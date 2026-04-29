class Lock {
  int id = 0;
  int type0 = 0;
  int index0 = 0;
  int skill0 = 0;

  Lock();

  factory Lock.fromJson(Map<String, dynamic> json) {
    return Lock()
      ..id = json['ID'] ?? 0
      ..type0 = json['Type0'] ?? 0
      ..index0 = json['Index0'] ?? 0
      ..skill0 = json['Skill0'] ?? 0;
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
