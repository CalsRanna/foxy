import 'package:foxy/entity/spell_key.dart';

/// 法术（技能）简要模型 - 列表展示用
class BriefSpellEntity {
  final int id;
  final String name;
  final String subtext;
  final String localeName;
  final String localeSubtext;
  final String description;
  final String localeDescription;
  final String auraDescription;
  final String localeAuraDescription;
  final String textureFilename;

  const BriefSpellEntity({
    this.id = 0,
    this.name = '',
    this.subtext = '',
    this.localeName = '',
    this.localeSubtext = '',
    this.description = '',
    this.localeDescription = '',
    this.auraDescription = '',
    this.localeAuraDescription = '',
    this.textureFilename = '',
  });

  factory BriefSpellEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellEntity(
      id: json['ID'] ?? 0,
      name: json['Name_lang_enUS'] ?? '',
      subtext: json['NameSubtext_lang_enUS'] ?? '',
      localeName: json['Name_lang_zhCN'] ?? '',
      localeSubtext: json['NameSubtext_lang_zhCN'] ?? '',
      description: json['Description_lang_enUS'] ?? '',
      localeDescription: json['Description_lang_zhCN'] ?? '',
      auraDescription: json['AuraDescription_lang_enUS'] ?? '',
      localeAuraDescription: json['AuraDescription_lang_zhCN'] ?? '',
      textureFilename: json['TextureFilename'] ?? '',
    );
  }

  String get displayAuraDescription => localeAuraDescription.isNotEmpty
      ? localeAuraDescription
      : auraDescription;
  String get displayDescription =>
      localeDescription.isNotEmpty ? localeDescription : description;
  String get displayName => localeName.isNotEmpty ? localeName : name;
  String get displaySubtext =>
      localeSubtext.isNotEmpty ? localeSubtext : subtext;

  SpellKey get key => SpellKey(id: id);
}
