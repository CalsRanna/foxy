// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_type_entity.dart';

mixin _CurrencyTypeEntityMixin {
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
    final self = this as CurrencyTypeEntity;
    return CurrencyTypeEntity(
      id: id ?? self.id,
      itemId: itemId ?? self.itemId,
      categoryId: categoryId ?? self.categoryId,
      bitIndex: bitIndex ?? self.bitIndex,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CurrencyTypeEntity;
    return {
      'ID': self.id,
      'ItemID': self.itemId,
      'CategoryID': self.categoryId,
      'BitIndex': self.bitIndex,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CurrencyTypeEntity;
    return identical(self, other) ||
        other is CurrencyTypeEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.itemId == other.itemId &&
            self.categoryId == other.categoryId &&
            self.bitIndex == other.bitIndex;
  }

  @override
  int get hashCode {
    final self = this as CurrencyTypeEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.itemId,
      self.categoryId,
      self.bitIndex,
    ]);
  }

  @override
  String toString() {
    final self = this as CurrencyTypeEntity;
    return 'CurrencyTypeEntity('
        'id: ${self.id}, '
        'itemId: ${self.itemId}, '
        'categoryId: ${self.categoryId}, '
        'bitIndex: ${self.bitIndex}'
        ')';
  }
}
