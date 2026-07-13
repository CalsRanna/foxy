class ItemBagFamilyEntity {
  final Map<String, dynamic> values;

  ItemBagFamilyEntity.fromJson(Map<String, dynamic> json)
    : values = Map.unmodifiable(Map<String, dynamic>.from(json));

  int get id => values['ID'] ?? 0;
  String get name => values['Name_lang_zhCN'] ?? '';

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(values);
}
