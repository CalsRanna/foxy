// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_item_enchantment_condition_repository.dart';

final class SpellItemEnchantmentConditionFilter {
  final String id;

  const SpellItemEnchantmentConditionFilter({this.id = ''});

  factory SpellItemEnchantmentConditionFilter.fromJson(
    Map<String, dynamic> json,
  ) {
    return SpellItemEnchantmentConditionFilter(
      id: json['id']?.toString() ?? '',
    );
  }

  SpellItemEnchantmentConditionFilter copyWith({String? id}) {
    return SpellItemEnchantmentConditionFilter(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
