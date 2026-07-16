class BriefItemLimitCategoryEntity {
  final int id;
  final String name;
  final int quantity;
  final int flags;

  const BriefItemLimitCategoryEntity({
    this.id = 0,
    this.name = '',
    this.quantity = 0,
    this.flags = 0,
  });

  factory BriefItemLimitCategoryEntity.fromJson(Map<String, dynamic> json) =>
      BriefItemLimitCategoryEntity(
        id: json['ID'] ?? 0,
        name: json['Name_lang_zhCN'] ?? '',
        quantity: json['Quantity'] ?? 0,
        flags: json['Flags'] ?? 0,
      );
}

class ItemLimitCategoryEntity {
  final Map<String, dynamic> values;

  ItemLimitCategoryEntity.fromJson(Map<String, dynamic> json)
    : values = Map.unmodifiable(Map<String, dynamic>.from(json));

  int get flags => values['Flags'] ?? 0;
  int get id => values['ID'] ?? 0;
  String get name => values['Name_lang_zhCN'] ?? '';
  int get quantity => values['Quantity'] ?? 0;

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(values);
}
