/// 法术奖励系数
class SpellBonusData {
  int entry = 0;
  double directBonus = 0.0;
  double dotBonus = 0.0;
  double apBonus = 0.0;
  double apDotBonus = 0.0;
  String comments = '';

  SpellBonusData();

  factory SpellBonusData.fromJson(Map<String, dynamic> json) {
    return SpellBonusData()
      ..entry = json['entry'] ?? 0
      ..directBonus = (json['direct_bonus'] ?? 0.0).toDouble()
      ..dotBonus = (json['dot_bonus'] ?? 0.0).toDouble()
      ..apBonus = (json['ap_bonus'] ?? 0.0).toDouble()
      ..apDotBonus = (json['ap_dot_bonus'] ?? 0.0).toDouble()
      ..comments = json['comments'] ?? '';
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
