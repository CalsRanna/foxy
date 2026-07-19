/// 法术射程列表/Picker 展示模型。
class BriefSpellRangeEntity {
  final int id;
  final double rangeMin0;
  final double rangeMax0;
  final String displayNameLangZhCN;

  const BriefSpellRangeEntity({
    this.id = 0,
    this.rangeMin0 = 0.0,
    this.rangeMax0 = 0.0,
    this.displayNameLangZhCN = '',
  });

  factory BriefSpellRangeEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellRangeEntity(
      id: json['ID'] ?? 0,
      rangeMin0: (json['RangeMin0'] as num?)?.toDouble() ?? 0.0,
      rangeMax0: (json['RangeMax0'] as num?)?.toDouble() ?? 0.0,
      displayNameLangZhCN: json['DisplayName_lang_zhCN'] ?? '',
    );
  }

  int get key => id;
}
