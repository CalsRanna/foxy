class AreaTableFilterEntity {
  final String id;
  final String name;

  const AreaTableFilterEntity({this.id = '', this.name = ''});

  factory AreaTableFilterEntity.fromJson(Map<String, dynamic> json) {
    return AreaTableFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
