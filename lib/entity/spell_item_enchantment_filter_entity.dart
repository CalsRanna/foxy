class SpellItemEnchantmentFilterEntity {
  final String id;
  final String name;

  const SpellItemEnchantmentFilterEntity({this.id = '', this.name = ''});

  factory SpellItemEnchantmentFilterEntity.fromJson(Map<String, dynamic> json) {
    return SpellItemEnchantmentFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  SpellItemEnchantmentFilterEntity copyWith({String? id, String? name}) {
    return SpellItemEnchantmentFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
