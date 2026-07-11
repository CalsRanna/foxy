class ItemEnchantmentTemplateFilterEntity {
  final String entry;

  const ItemEnchantmentTemplateFilterEntity({this.entry = ''});

  factory ItemEnchantmentTemplateFilterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return ItemEnchantmentTemplateFilterEntity(entry: json['entry'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry};
  }

  ItemEnchantmentTemplateFilterEntity copyWith({String? entry}) {
    return ItemEnchantmentTemplateFilterEntity(entry: entry ?? this.entry);
  }
}
