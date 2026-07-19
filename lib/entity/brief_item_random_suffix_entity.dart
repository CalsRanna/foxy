import 'package:foxy/entity/item_random_suffix_key.dart';

class BriefItemRandomSuffixEntity {
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
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      internalName: json['InternalName'] ?? '',
    );
  }

  ItemRandomSuffixKey get key => ItemRandomSuffixKey(id: id);
}
