import 'package:foxy/entity/currency_category_key.dart';

class BriefCurrencyCategoryEntity {
  final int id;
  final int flags;
  final String nameLangZhCN;

  const BriefCurrencyCategoryEntity({
    this.id = 0,
    this.flags = 0,
    this.nameLangZhCN = '',
  });

  factory BriefCurrencyCategoryEntity.fromJson(Map<String, dynamic> json) {
    return BriefCurrencyCategoryEntity(
      id: json['ID'] ?? 0,
      flags: json['Flags'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
    );
  }

  CurrencyCategoryKey get key => CurrencyCategoryKey(id: id);
}
