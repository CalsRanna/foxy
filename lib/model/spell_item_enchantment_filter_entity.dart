class SpellItemEnchantmentFilterEntity {
  String id = '';
  String name = '';

  SpellItemEnchantmentFilterEntity();

  factory SpellItemEnchantmentFilterEntity.fromJson(Map<String, dynamic> json) {
    return SpellItemEnchantmentFilterEntity()
      ..id = json['id'] ?? ''
      ..name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
