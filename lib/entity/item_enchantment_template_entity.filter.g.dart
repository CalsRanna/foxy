// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class ItemEnchantmentTemplateFilterEntity {
  final String entry;

  const ItemEnchantmentTemplateFilterEntity({this.entry = ''});

  factory ItemEnchantmentTemplateFilterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return ItemEnchantmentTemplateFilterEntity(
      entry: json['entry']?.toString() ?? '',
    );
  }

  ItemEnchantmentTemplateFilterEntity copyWith({String? entry}) {
    return ItemEnchantmentTemplateFilterEntity(entry: entry ?? this.entry);
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry};
  }
}
