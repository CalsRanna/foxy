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
