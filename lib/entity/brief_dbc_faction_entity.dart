import 'package:foxy/entity/dbc_faction_key.dart';

class BriefDbcFactionEntity {
  final int id;
  final String nameLangZhCN;
  final String descriptionLangZhCN;

  const BriefDbcFactionEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.descriptionLangZhCN = '',
  });

  factory BriefDbcFactionEntity.fromJson(Map<String, dynamic> json) {
    return BriefDbcFactionEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      descriptionLangZhCN: json['Description_lang_zhCN'] ?? '',
    );
  }

  DbcFactionKey get key => DbcFactionKey(id: id);
}
