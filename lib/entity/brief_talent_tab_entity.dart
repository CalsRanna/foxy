class BriefTalentTabEntity {
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
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      classMask: json['ClassMask'] ?? 0,
      categoryEnumId: json['CategoryEnumID'] ?? 0,
      orderIndex: json['OrderIndex'] ?? 0,
    );
  }

  int get key => id;
}
