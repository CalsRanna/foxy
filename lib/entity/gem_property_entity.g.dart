// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_property_entity.dart';

mixin _GemPropertyEntityMixin {
  int get id;
  int get enchantId;
  int get maxCountInv;
  int get maxCountItem;
  int get type;

  static GemPropertyEntity fromJson(Map<String, dynamic> json) {
    return GemPropertyEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      enchantId: (json['Enchant_ID'] as num?)?.toInt() ?? 0,
      maxCountInv: (json['Maxcount_inv'] as num?)?.toInt() ?? 0,
      maxCountItem: (json['Maxcount_item'] as num?)?.toInt() ?? 0,
      type: (json['Type'] as num?)?.toInt() ?? 0,
    );
  }

  GemPropertyEntity copyWith({
    int? id,
    int? enchantId,
    int? maxCountInv,
    int? maxCountItem,
    int? type,
  }) {
    return GemPropertyEntity(
      id: id ?? this.id,
      enchantId: enchantId ?? this.enchantId,
      maxCountInv: maxCountInv ?? this.maxCountInv,
      maxCountItem: maxCountItem ?? this.maxCountItem,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Enchant_ID': enchantId,
      'Maxcount_inv': maxCountInv,
      'Maxcount_item': maxCountItem,
      'Type': type,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GemPropertyEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            enchantId == other.enchantId &&
            maxCountInv == other.maxCountInv &&
            maxCountItem == other.maxCountItem &&
            type == other.type;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      enchantId,
      maxCountInv,
      maxCountItem,
      type,
    ]);
  }

  @override
  String toString() {
    return 'GemPropertyEntity('
        'id: $id, '
        'enchantId: $enchantId, '
        'maxCountInv: $maxCountInv, '
        'maxCountItem: $maxCountItem, '
        'type: $type'
        ')';
  }
}
