// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_enchantment_template_repository.dart';

final class ItemEnchantmentTemplateFilter {
  final String entry;

  const ItemEnchantmentTemplateFilter({this.entry = ''});

  factory ItemEnchantmentTemplateFilter.fromJson(Map<String, dynamic> json) {
    return ItemEnchantmentTemplateFilter(
      entry: json['entry']?.toString() ?? '',
    );
  }

  ItemEnchantmentTemplateFilter copyWith({String? entry}) {
    return ItemEnchantmentTemplateFilter(entry: entry ?? this.entry);
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry};
  }
}
