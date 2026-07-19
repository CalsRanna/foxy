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
}
