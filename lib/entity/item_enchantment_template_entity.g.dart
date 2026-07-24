// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_enchantment_template_entity.dart';

mixin _ItemEnchantmentTemplateEntityMixin {
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
    final self = this as ItemEnchantmentTemplateEntity;
    return ItemEnchantmentTemplateEntity(
      entry: entry ?? self.entry,
      ench: ench ?? self.ench,
      chance: chance ?? self.chance,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as ItemEnchantmentTemplateEntity;
    return {'entry': self.entry, 'ench': self.ench, 'chance': self.chance};
  }

  @override
  bool operator ==(Object other) {
    final self = this as ItemEnchantmentTemplateEntity;
    return identical(self, other) ||
        other is ItemEnchantmentTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.ench == other.ench &&
            self.chance == other.chance;
  }

  @override
  int get hashCode {
    final self = this as ItemEnchantmentTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.ench,
      self.chance,
    ]);
  }

  @override
  String toString() {
    final self = this as ItemEnchantmentTemplateEntity;
    return 'ItemEnchantmentTemplateEntity('
        'entry: ${self.entry}, '
        'ench: ${self.ench}, '
        'chance: ${self.chance}'
        ')';
  }
}

final class ItemEnchantmentTemplateKey {
  final int entry;
  final int ench;

  const ItemEnchantmentTemplateKey({required this.entry, required this.ench});

  factory ItemEnchantmentTemplateKey.fromEntity(
    ItemEnchantmentTemplateEntity entity,
  ) {
    return ItemEnchantmentTemplateKey(entry: entity.entry, ench: entity.ench);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemEnchantmentTemplateKey &&
            entry == other.entry &&
            ench == other.ench;
  }

  @override
  int get hashCode => Object.hashAll([entry, ench]);

  @override
  String toString() {
    return 'ItemEnchantmentTemplateKey('
        'entry: $entry, '
        'ench: $ench'
        ')';
  }
}
