// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_repository.dart';

final class SpellItemEnchantmentFilter {
  final String id;
  final String name;

  const SpellItemEnchantmentFilter({this.id = '', this.name = ''});

  factory SpellItemEnchantmentFilter.fromJson(Map<String, dynamic> json) {
    return SpellItemEnchantmentFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  SpellItemEnchantmentFilter copyWith({String? id, String? name}) {
    return SpellItemEnchantmentFilter(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
