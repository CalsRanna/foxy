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
}

class BriefCurrencyTypeEntity {
  final int id;
  final int itemId;
  final int categoryId;
  final int bitIndex;

  const BriefCurrencyTypeEntity({
    this.id = 0,
    this.itemId = 0,
    this.categoryId = 0,
    this.bitIndex = 0,
  });

  factory BriefCurrencyTypeEntity.fromJson(Map<String, dynamic> json) {
    return BriefCurrencyTypeEntity(
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
}
