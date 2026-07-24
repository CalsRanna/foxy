// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefTalentTabEntity {
  final int id;
  final String nameLangZhCN;
  final int classMask;
  final int categoryEnumId;
  final int orderIndex;

  const BriefTalentTabEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.classMask = 0,
    this.categoryEnumId = 0,
    this.orderIndex = 0,
  });

  factory BriefTalentTabEntity.fromJson(Map<String, dynamic> json) {
    return BriefTalentTabEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      classMask: (json['ClassMask'] as num?)?.toInt() ?? 0,
      categoryEnumId: (json['CategoryEnumID'] as num?)?.toInt() ?? 0,
      orderIndex: (json['OrderIndex'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
