class BriefSpellBonusDataEntity {
  final int entry;
  final double directBonus;
  final double dotBonus;
  final double apBonus;
  final double apDotBonus;
  final String comments;

  const BriefSpellBonusDataEntity({
    this.entry = 0,
    this.directBonus = 0.0,
    this.dotBonus = 0.0,
    this.apBonus = 0.0,
    this.apDotBonus = 0.0,
    this.comments = '',
  });

  factory BriefSpellBonusDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellBonusDataEntity(
      entry: json['entry'] ?? 0,
      directBonus: (json['direct_bonus'] as num?)?.toDouble() ?? 0.0,
      dotBonus: (json['dot_bonus'] as num?)?.toDouble() ?? 0.0,
      apBonus: (json['ap_bonus'] as num?)?.toDouble() ?? 0.0,
      apDotBonus: (json['ap_dot_bonus'] as num?)?.toDouble() ?? 0.0,
      comments: json['comments']?.toString() ?? '',
    );
  }

  int get key => entry;
}
