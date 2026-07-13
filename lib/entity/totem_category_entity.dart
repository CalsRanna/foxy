class TotemCategoryEntity {
  final Map<String, dynamic> values;

  TotemCategoryEntity.fromJson(Map<String, dynamic> json)
    : values = Map.unmodifiable(Map<String, dynamic>.from(json));

  int get id => values['ID'] ?? 0;
  String get name => values['Name_lang_zhCN'] ?? '';
  int get categoryType => values['TotemCategoryType'] ?? 0;
  int get categoryMask => values['TotemCategoryMask'] ?? 0;

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(values);
}

class BriefTotemCategoryEntity {
  final int id;
  final String name;
  final int categoryType;
  final int categoryMask;

  const BriefTotemCategoryEntity({
    this.id = 0,
    this.name = '',
    this.categoryType = 0,
    this.categoryMask = 0,
  });

  factory BriefTotemCategoryEntity.fromJson(Map<String, dynamic> json) =>
      BriefTotemCategoryEntity(
        id: json['ID'] ?? 0,
        name: json['Name_lang_zhCN'] ?? '',
        categoryType: json['TotemCategoryType'] ?? 0,
        categoryMask: json['TotemCategoryMask'] ?? 0,
      );
}
