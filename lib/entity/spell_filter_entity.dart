class SpellFilterEntity {
  final String id;
  final String name;

  const SpellFilterEntity({this.id = '', this.name = ''});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory SpellFilterEntity.fromJson(Map<String, dynamic> json) {
    return SpellFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
