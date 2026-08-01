// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_property_entity.dart';

final class BriefGemPropertyEntity {
  final int id;
  final int enchantId;
  final int maxCountInv;
  final int maxCountItem;
  final int type;

  const BriefGemPropertyEntity({
    this.id = 0,
    this.enchantId = 0,
    this.maxCountInv = 0,
    this.maxCountItem = 0,
    this.type = 0,
  });

  factory BriefGemPropertyEntity.fromJson(Map<String, dynamic> json) {
    return BriefGemPropertyEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      enchantId: (json['Enchant_ID'] as num?)?.toInt() ?? 0,
      maxCountInv: (json['Maxcount_inv'] as num?)?.toInt() ?? 0,
      maxCountItem: (json['Maxcount_item'] as num?)?.toInt() ?? 0,
      type: (json['Type'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  int get hashCode =>
      Object.hashAll([id, enchantId, maxCountInv, maxCountItem, type]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefGemPropertyEntity &&
            id == other.id &&
            enchantId == other.enchantId &&
            maxCountInv == other.maxCountInv &&
            maxCountItem == other.maxCountItem &&
            type == other.type;
  }

  @override
  String toString() {
    return 'BriefGemPropertyEntity('
        'id: $id, '
        'enchantId: $enchantId, '
        'maxCountInv: $maxCountInv, '
        'maxCountItem: $maxCountItem, '
        'type: $type'
        ')';
  }
}

mixin _GemPropertyEntityMixin {
  @override
  int get hashCode {
    final self = this as GemPropertyEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.enchantId,
      self.maxCountInv,
      self.maxCountItem,
      self.type,
    ]);
  }

  @override
  bool operator ==(Object other) {
    final self = this as GemPropertyEntity;
    return identical(self, other) ||
        other is GemPropertyEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.enchantId == other.enchantId &&
            self.maxCountInv == other.maxCountInv &&
            self.maxCountItem == other.maxCountItem &&
            self.type == other.type;
  }

  GemPropertyEntity copyWith({
    int? id,
    int? enchantId,
    int? maxCountInv,
    int? maxCountItem,
    int? type,
  }) {
    final self = this as GemPropertyEntity;
    return GemPropertyEntity(
      id: id ?? self.id,
      enchantId: enchantId ?? self.enchantId,
      maxCountInv: maxCountInv ?? self.maxCountInv,
      maxCountItem: maxCountItem ?? self.maxCountItem,
      type: type ?? self.type,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as GemPropertyEntity;
    return {
      'ID': self.id,
      'Enchant_ID': self.enchantId,
      'Maxcount_inv': self.maxCountInv,
      'Maxcount_item': self.maxCountItem,
      'Type': self.type,
    };
  }

  @override
  String toString() {
    final self = this as GemPropertyEntity;
    return 'GemPropertyEntity('
        'id: ${self.id}, '
        'enchantId: ${self.enchantId}, '
        'maxCountInv: ${self.maxCountInv}, '
        'maxCountItem: ${self.maxCountItem}, '
        'type: ${self.type}'
        ')';
  }

  static GemPropertyEntity fromJson(Map<String, dynamic> json) {
    return GemPropertyEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      enchantId: (json['Enchant_ID'] as num?)?.toInt() ?? 0,
      maxCountInv: (json['Maxcount_inv'] as num?)?.toInt() ?? 0,
      maxCountItem: (json['Maxcount_item'] as num?)?.toInt() ?? 0,
      type: (json['Type'] as num?)?.toInt() ?? 0,
    );
  }
}
