/// 法术奖励系数
class SpellBonusDataEntity {
  final int entry;
  final double directBonus;
  final double dotBonus;
  final double apBonus;
  final double apDotBonus;
  final String comments;

  const SpellBonusDataEntity({
    this.entry = 0,
    this.directBonus = 0.0,
    this.dotBonus = 0.0,
    this.apBonus = 0.0,
    this.apDotBonus = 0.0,
    this.comments = '',
  });

  factory SpellBonusDataEntity.fromJson(Map<String, dynamic> json) {
    return SpellBonusDataEntity(
      entry: json['entry'] ?? 0,
      directBonus: (json['direct_bonus'] ?? 0.0),
      dotBonus: (json['dot_bonus'] ?? 0.0),
      apBonus: (json['ap_bonus'] ?? 0.0),
      apDotBonus: (json['ap_dot_bonus'] ?? 0.0),
      comments: json['comments'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'direct_bonus': directBonus,
      'dot_bonus': dotBonus,
      'ap_bonus': apBonus,
      'ap_dot_bonus': apDotBonus,
      'comments': comments,
    };
  }
}
