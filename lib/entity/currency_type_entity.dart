import 'package:foxy/constant/currency_type_constants.dart';

class CurrencyTypeEntity {
  final int id;
  final int itemId;
  final int categoryId;
  final int bitIndex;

  const CurrencyTypeEntity({
    this.id = 0,
    this.itemId = 0,
    this.categoryId = 0,
    this.bitIndex = 0,
  });

  factory CurrencyTypeEntity.fromJson(Map<String, dynamic> json) {
    return CurrencyTypeEntity(
      id: json['ID'] ?? 0,
      itemId: json['ItemID'] ?? 0,
      categoryId: json['CategoryID'] ?? 0,
      bitIndex: json['BitIndex'] ?? 0,
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

  void validate() {
    _requireRange(id, 1, 0x7fffffff, 'ID');
    _requireRange(itemId, 1, 0x7fffffff, 'ItemID');
    _requireRange(categoryId, 1, 0x7fffffff, 'CategoryID');
    _requireRange(
      bitIndex,
      kCurrencyBitIndexMinimum,
      kCurrencyBitIndexMaximum,
      'BitIndex',
    );
  }

  static void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
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
}

class BriefCurrencyTypeEntity {
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

  String get displayItemName =>
      localeItemName.isNotEmpty ? localeItemName : itemName;

  factory BriefCurrencyTypeEntity.fromJson(Map<String, dynamic> json) {
    return BriefCurrencyTypeEntity(
      id: json['ID'] ?? 0,
      itemId: json['ItemID'] ?? 0,
      categoryId: json['CategoryID'] ?? 0,
      bitIndex: json['BitIndex'] ?? 0,
      itemName: json['name'] ?? '',
      localeItemName: json['localeName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ItemID': itemId,
      'CategoryID': categoryId,
      'BitIndex': bitIndex,
      'name': itemName,
      'localeName': localeItemName,
    };
  }

  BriefCurrencyTypeEntity copyWith({
    int? id,
    int? itemId,
    int? categoryId,
    int? bitIndex,
    String? itemName,
    String? localeItemName,
  }) {
    return BriefCurrencyTypeEntity(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      categoryId: categoryId ?? this.categoryId,
      bitIndex: bitIndex ?? this.bitIndex,
      itemName: itemName ?? this.itemName,
      localeItemName: localeItemName ?? this.localeItemName,
    );
  }
}
