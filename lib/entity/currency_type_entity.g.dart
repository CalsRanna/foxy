// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_type_entity.dart';

final class BriefCurrencyTypeEntity {
  final int id;
  final int itemId;
  final int categoryId;
  final int bitIndex;
  final String itemName;
  final String localeItemName;

  const BriefCurrencyTypeEntity({
    this.id = 0,
    this.itemId = 0,
    this.categoryId = 0,
    this.bitIndex = 0,
    this.itemName = '',
    this.localeItemName = '',
  });

  factory BriefCurrencyTypeEntity.fromJson(Map<String, dynamic> json) {
    return BriefCurrencyTypeEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      itemId: json['ItemID'] == true
          ? 1
          : json['ItemID'] == false
          ? 0
          : (json['ItemID'] as num?)?.toInt() ?? 0,
      categoryId: json['CategoryID'] == true
          ? 1
          : json['CategoryID'] == false
          ? 0
          : (json['CategoryID'] as num?)?.toInt() ?? 0,
      bitIndex: json['BitIndex'] == true
          ? 1
          : json['BitIndex'] == false
          ? 0
          : (json['BitIndex'] as num?)?.toInt() ?? 0,
      itemName: json['itemName']?.toString() ?? '',
      localeItemName: json['localeItemName']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    itemId,
    categoryId,
    bitIndex,
    itemName,
    localeItemName,
  ]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefCurrencyTypeEntity &&
            id == other.id &&
            itemId == other.itemId &&
            categoryId == other.categoryId &&
            bitIndex == other.bitIndex &&
            itemName == other.itemName &&
            localeItemName == other.localeItemName;
  }

  @override
  String toString() {
    return 'BriefCurrencyTypeEntity('
        'id: $id, '
        'itemId: $itemId, '
        'categoryId: $categoryId, '
        'bitIndex: $bitIndex, '
        'itemName: $itemName, '
        'localeItemName: $localeItemName'
        ')';
  }
}

mixin _CurrencyTypeEntityMixin {
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
  String toString() {
    final self = this as CurrencyTypeEntity;
    return 'CurrencyTypeEntity('
        'id: ${self.id}, '
        'itemId: ${self.itemId}, '
        'categoryId: ${self.categoryId}, '
        'bitIndex: ${self.bitIndex}'
        ')';
  }

  static CurrencyTypeEntity fromJson(Map<String, dynamic> json) {
    return CurrencyTypeEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      itemId: json['ItemID'] == true
          ? 1
          : json['ItemID'] == false
          ? 0
          : (json['ItemID'] as num?)?.toInt() ?? 0,
      categoryId: json['CategoryID'] == true
          ? 1
          : json['CategoryID'] == false
          ? 0
          : (json['CategoryID'] as num?)?.toInt() ?? 0,
      bitIndex: json['BitIndex'] == true
          ? 1
          : json['BitIndex'] == false
          ? 0
          : (json['BitIndex'] as num?)?.toInt() ?? 0,
    );
  }
}
