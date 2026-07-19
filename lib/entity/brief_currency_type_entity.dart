import 'package:foxy/entity/currency_type_key.dart';

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

  String get displayItemName =>
      localeItemName.isNotEmpty ? localeItemName : itemName;

  CurrencyTypeKey get key => CurrencyTypeKey(id: id);
}
