// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_type_entity.dart';

mixin _CurrencyTypeEntityMixin {
  int get id;
  int get itemId;
  int get categoryId;
  int get bitIndex;

  static CurrencyTypeEntity fromJson(Map<String, dynamic> json) {
    return CurrencyTypeEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      itemId: (json['ItemID'] as num?)?.toInt() ?? 0,
      categoryId: (json['CategoryID'] as num?)?.toInt() ?? 0,
      bitIndex: (json['BitIndex'] as num?)?.toInt() ?? 0,
    );
  }

  CurrencyTypeEntity copyWith({
    int? id,
    int? itemId,
    int? categoryId,
    int? bitIndex,
  }) {
    return CurrencyTypeEntity(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      categoryId: categoryId ?? this.categoryId,
      bitIndex: bitIndex ?? this.bitIndex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ItemID': itemId,
      'CategoryID': categoryId,
      'BitIndex': bitIndex,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CurrencyTypeEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            itemId == other.itemId &&
            categoryId == other.categoryId &&
            bitIndex == other.bitIndex;
  }

  @override
  int get hashCode {
    return Object.hashAll([runtimeType, id, itemId, categoryId, bitIndex]);
  }

  @override
  String toString() {
    return 'CurrencyTypeEntity('
        'id: $id, '
        'itemId: $itemId, '
        'categoryId: $categoryId, '
        'bitIndex: $bitIndex'
        ')';
  }
}
