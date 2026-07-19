import 'package:foxy/entity/totem_category_key.dart';

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

  TotemCategoryKey get key => TotemCategoryKey(id: id);
}
