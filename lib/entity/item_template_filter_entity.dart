class ItemTemplateFilterEntity {
  final String entry;
  final String name;
  final String description;
  final int classId;
  final int subclass;

  const ItemTemplateFilterEntity({
    this.entry = '',
    this.name = '',
    this.description = '',
    this.classId = -1,
    this.subclass = -1,
  });

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
    return ItemTemplateFilterEntity(
      entry: json['entry'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      classId: json['classId'] ?? -1,
      subclass: json['subclass'] ?? -1,
    );
  }
}
