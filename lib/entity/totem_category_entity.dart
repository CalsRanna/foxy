class TotemCategoryEntity {
  final Map<String, dynamic> values;

  TotemCategoryEntity.fromJson(Map<String, dynamic> json)
    : values = Map.unmodifiable(Map<String, dynamic>.from(json));

  int get categoryMask => values['TotemCategoryMask'] ?? 0;
  int get categoryType => values['TotemCategoryType'] ?? 0;
  int get id => values['ID'] ?? 0;
  String get name => values['Name_lang_zhCN'] ?? '';

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(values);
}
