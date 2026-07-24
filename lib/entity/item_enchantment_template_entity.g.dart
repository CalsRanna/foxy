// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_enchantment_template_entity.dart';

mixin _ItemEnchantmentTemplateEntityMixin {
  int get entry;
  int get ench;
  double get chance;

  static ItemEnchantmentTemplateEntity fromJson(Map<String, dynamic> json) {
    return ItemEnchantmentTemplateEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      ench: (json['ench'] as num?)?.toInt() ?? 0,
      chance: (json['chance'] as num?)?.toDouble() ?? 0.0,
    );
  }

  ItemEnchantmentTemplateEntity copyWith({
    int? entry,
    int? ench,
    double? chance,
  }) {
    return ItemEnchantmentTemplateEntity(
      entry: entry ?? this.entry,
      ench: ench ?? this.ench,
      chance: chance ?? this.chance,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'ench': ench, 'chance': chance};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemEnchantmentTemplateEntity &&
            runtimeType == other.runtimeType &&
            entry == other.entry &&
            ench == other.ench &&
            chance == other.chance;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, entry, ench, chance]);
  }

  @override
  String toString() {
    return 'ItemEnchantmentTemplateEntity('
        'entry: $entry, '
        'ench: $ench, '
        'chance: $chance'
        ')';
  }
}
