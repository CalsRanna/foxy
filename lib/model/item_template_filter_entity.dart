class ItemTemplateFilterEntity {
  String entry = '';
  String name = '';
  String description = '';
  int classId = -1;
  int subclass = -1;

  ItemTemplateFilterEntity();

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'name': name,
      'description': description,
      'classId': classId,
      'subclass': subclass,
    };
  }

  factory ItemTemplateFilterEntity.fromJson(Map<String, dynamic> json) {
    return ItemTemplateFilterEntity()
      ..entry = json['entry'] ?? ''
      ..name = json['name'] ?? ''
      ..description = json['description'] ?? ''
      ..classId = json['classId'] ?? -1
      ..subclass = json['subclass'] ?? -1;
  }
}
