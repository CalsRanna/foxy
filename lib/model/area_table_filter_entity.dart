class AreaTableFilterEntity {
  String id = '';
  String name = '';

  AreaTableFilterEntity();

  factory AreaTableFilterEntity.fromJson(Map<String, dynamic> json) {
    return AreaTableFilterEntity()
      ..id = json['id'] ?? ''
      ..name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
