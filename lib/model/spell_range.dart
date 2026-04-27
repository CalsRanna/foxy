class SpellRange {
  int id = 0;
  double rangeMin0 = 0.0;
  double rangeMax0 = 0.0;
  String displayNameLangZhCn = '';

  SpellRange();

  SpellRange.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    rangeMin0 = (json['RangeMin0'] ?? 0).toDouble();
    rangeMax0 = (json['RangeMax0'] ?? 0).toDouble();
    displayNameLangZhCn = json['DisplayName_lang_zhCN'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'RangeMin0': rangeMin0,
      'RangeMax0': rangeMax0,
      'DisplayName_lang_zhCN': displayNameLangZhCn,
    };
  }
}
