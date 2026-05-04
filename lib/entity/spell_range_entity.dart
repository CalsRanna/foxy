class SpellRangeEntity {
  final int id;
  final double rangeMin0;
  final double rangeMax0;
  final String displayNameLangZhCn;

  const SpellRangeEntity({
    this.id = 0,
    this.rangeMin0 = 0.0,
    this.rangeMax0 = 0.0,
    this.displayNameLangZhCn = '',
  });

  factory SpellRangeEntity.fromJson(Map<String, dynamic> json) {
    return SpellRangeEntity(
      id: json['ID'] ?? 0,
      rangeMin0: (json['RangeMin0'] ?? 0.0),
      rangeMax0: (json['RangeMax0'] ?? 0.0),
      displayNameLangZhCn: json['DisplayName_lang_zhCN'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'RangeMin0': rangeMin0,
      'RangeMax0': rangeMax0,
      'DisplayName_lang_zhCN': displayNameLangZhCn,
    };
  }

  SpellRangeEntity copyWith({
    int? id,
    double? rangeMin0,
    double? rangeMax0,
    String? displayNameLangZhCn,
  }) {
    return SpellRangeEntity(
      id: id ?? this.id,
      rangeMin0: rangeMin0 ?? this.rangeMin0,
      rangeMax0: rangeMax0 ?? this.rangeMax0,
      displayNameLangZhCn: displayNameLangZhCn ?? this.displayNameLangZhCn,
    );
  }
}
