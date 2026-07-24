// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefItemRandomSuffixEntity {
  final int id;
  final String nameLangZhCN;
  final String internalName;

  const BriefItemRandomSuffixEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.internalName = '',
  });

  factory BriefItemRandomSuffixEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemRandomSuffixEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
      internalName: json['InternalName']?.toString() ?? '',
    );
  }

  int get key => id;
}
