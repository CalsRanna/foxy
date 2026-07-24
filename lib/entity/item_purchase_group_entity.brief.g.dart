// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefItemPurchaseGroupEntity {
  final int id;
  final String nameLangZhCN;

  const BriefItemPurchaseGroupEntity({this.id = 0, this.nameLangZhCN = ''});

  factory BriefItemPurchaseGroupEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemPurchaseGroupEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
