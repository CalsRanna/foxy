class AreaTableFilterEntity {
  String id = '';
  String name = '';

  AreaTableFilterEntity();

  AreaTableFilterEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
