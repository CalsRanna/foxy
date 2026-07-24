// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefItemRandomPropertiesEntity {
  final int id;
  final String name;
  final String nameLangZhCN;

  const BriefItemRandomPropertiesEntity({
    this.id = 0,
    this.name = '',
    this.nameLangZhCN = '',
  });

  factory BriefItemRandomPropertiesEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemRandomPropertiesEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
